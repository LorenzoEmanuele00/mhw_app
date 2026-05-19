# POSTHOG.md — Guida implementazione Analytics

Fase 7 del progetto. Nessun PII raccolto — tutti gli eventi sono anonimi.
Per lo stato dei task vedi `PROGRESS.md` → Phase 7.

---

## 1. Setup iniziale

### 1a. Crea il progetto PostHog

1. Vai su [app.posthog.com](https://app.posthog.com) e crea un account (piano free: 1M eventi/mese)
2. Crea un nuovo progetto → ti viene dato un **API Key** (`phc_xxxxxxxxxxxx`) e un **host** (`https://eu.i.posthog.com` per EU o `https://us.i.posthog.com` per US)
3. Crea un secondo progetto chiamato `mhw-app-dev` per i build di sviluppo

### 1b. Aggiungi le dipendenze

In `pubspec.yaml`, sezione `dependencies`:

```yaml
posthog_flutter: ^5.1.0
shared_preferences: ^2.3.0
```

Poi:

```bash
flutter pub get
```

### 1c. Configura la API Key in modo sicuro

Crea il file `lib/core/config/app_config.dart`:

```dart
class AppConfig {
  static const String postHogApiKey = String.fromEnvironment(
    'POSTHOG_API_KEY',
    defaultValue: '',
  );
  static const String postHogHost = String.fromEnvironment(
    'POSTHOG_HOST',
    defaultValue: 'https://eu.i.posthog.com',
  );
  static const bool isRelease = bool.fromEnvironment('dart.vm.product');
}
```

Per buildare con la key (non committiamo mai la key nel codice):

```bash
# Build di sviluppo (usa il progetto dev)
flutter run --dart-define=POSTHOG_API_KEY=phc_DEV_KEY_QUI

# Build di release
flutter build ios --dart-define=POSTHOG_API_KEY=phc_PROD_KEY_QUI --dart-define=POSTHOG_HOST=https://eu.i.posthog.com
```

Aggiungi a `.gitignore` se hai un file `.env` locale con le key.

---

## 2. Analytics Service (astrazione)

Creare l'astrazione ci permette di iniettare il `NoopAnalyticsService` nei test senza mai chiamare PostHog.

### 2a. Abstract class

Crea `lib/core/analytics/analytics_service.dart`:

```dart
abstract class AnalyticsService {
  Future<void> identify(String distinctId);
  Future<void> capture(String eventName, {Map<String, Object>? properties});
  Future<void> screen(String screenName);
  Future<void> reset();
}
```

### 2b. PostHog implementation

Crea `lib/core/analytics/posthog_analytics_service.dart`:

```dart
import 'package:posthog_flutter/posthog_flutter.dart';
import 'analytics_service.dart';

class PostHogAnalyticsService implements AnalyticsService {
  @override
  Future<void> identify(String distinctId) async {
    await Posthog().identify(userId: distinctId);
  }

  @override
  Future<void> capture(String eventName, {Map<String, Object>? properties}) async {
    await Posthog().capture(eventName: eventName, properties: properties);
  }

  @override
  Future<void> screen(String screenName) async {
    await Posthog().screen(screenName: screenName);
  }

  @override
  Future<void> reset() async {
    await Posthog().reset();
  }
}
```

### 2c. Noop implementation (per test e debug)

Crea `lib/core/analytics/noop_analytics_service.dart`:

```dart
import 'analytics_service.dart';

class NoopAnalyticsService implements AnalyticsService {
  @override
  Future<void> identify(String distinctId) async {}
  @override
  Future<void> capture(String eventName, {Map<String, Object>? properties}) async {}
  @override
  Future<void> screen(String screenName) async {}
  @override
  Future<void> reset() async {}
}
```

### 2d. Riverpod provider

Crea `lib/core/analytics/analytics_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'analytics_service.dart';
import 'noop_analytics_service.dart';
import 'posthog_analytics_service.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  // In release usa PostHog, in debug usa Noop
  const isRelease = bool.fromEnvironment('dart.vm.product');
  return isRelease ? PostHogAnalyticsService() : NoopAnalyticsService();
});
```

---

## 3. Anonymous ID Service

L'utente non si logga mai — usiamo un UUID generato al primo avvio e persistito su disco.

Crea `lib/core/analytics/anonymous_id_service.dart`:

```dart
import 'package:shared_preferences/shared_preferences.dart';

class AnonymousIdService {
  static const _key = 'anonymous_user_id';

  static Future<String> getOrCreate() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_key);
    if (existing != null) return existing;

    final id = _generateUuid();
    await prefs.setString(_key, id);
    return id;
  }

  // UUID v4 senza dipendenze esterne
  static String _generateUuid() {
    final now = DateTime.now().microsecondsSinceEpoch;
    final rand = now ^ (now >> 16);
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replaceAllMapped(
      RegExp(r'[xy]'),
      (m) {
        final v = (rand + m.start * 7) & 0xf;
        return (m[0] == 'x' ? v : (v & 0x3 | 0x8)).toRadixString(16);
      },
    );
  }
}
```

> **Nota**: se vuoi un UUID standard compliant, aggiungi il package `uuid: ^4.x` e usa `Uuid().v4()`. Il metodo sopra è una semplificazione accettabile per un anonymous ID.

---

## 4. Inizializzazione in main.dart

In `lib/main.dart`, modifica la funzione `main()`:

```dart
import 'package:posthog_flutter/posthog_flutter.dart';
import 'core/analytics/anonymous_id_service.dart';
import 'core/analytics/analytics_provider.dart';
import 'core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init PostHog solo in release
  if (AppConfig.isRelease && AppConfig.postHogApiKey.isNotEmpty) {
    final config = PostHogConfig(AppConfig.postHogApiKey)
      ..host = AppConfig.postHogHost
      ..captureApplicationLifecycleEvents = true
      ..sessionReplay = false
      ..debug = false;
    await Posthog().setup(config);
  }

  // Genera / recupera l'anonymous ID e identificati
  final anonymousId = await AnonymousIdService.getOrCreate();

  runApp(
    ProviderScope(
      overrides: [],
      child: MhwApp(anonymousId: anonymousId),
    ),
  );
}
```

In `MhwApp` (o dove monti `ProviderScope`), dopo il primo build chiama `identify`:

```dart
// In MhwApp.build(), dopo aver ottenuto il container:
ref.read(analyticsServiceProvider).identify(anonymousId);
```

---

## 5. Navigation tracking

Creare un `NavigatorObserver` che chiama `screen()` ad ogni cambio di tab.

Crea `lib/core/analytics/analytics_navigator_observer.dart`:

```dart
import 'package:flutter/material.dart';
import 'analytics_service.dart';

class AnalyticsNavigatorObserver extends NavigatorObserver {
  final AnalyticsService analytics;
  AnalyticsNavigatorObserver(this.analytics);

  @override
  void didPush(Route route, Route? previousRoute) {
    _trackRoute(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null) _trackRoute(newRoute);
  }

  void _trackRoute(Route route) {
    final name = route.settings.name;
    if (name != null && name.isNotEmpty) {
      analytics.screen(name);
    }
  }
}
```

In `lib/core/router/router.dart`, aggiungi l'observer al `GoRouter`:

```dart
final analyticsObserver = AnalyticsNavigatorObserver(
  ref.read(analyticsServiceProvider),
);

final router = GoRouter(
  observers: [analyticsObserver],
  // ... resto della config
);
```

Con go_router le route cambiano via `GoRouter.go()` — gli observer `NavigatorObserver` vengono notificati automaticamente ad ogni push/replace.

---

## 6. Event tracking — Build actions

In `lib/features/build/build_notifier.dart`, inietta l'`AnalyticsService` tramite `ref`:

```dart
class BuildNotifier extends Notifier<BuildState> {

  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);

  Future<void> newBuild() async {
    // ... logica esistente ...
    _analytics.capture('build_created');
  }

  Future<void> loadBuild(int buildId) async {
    // ... logica esistente ...
    _analytics.capture('build_loaded');
    // Non loggare il buildId raw — è un dato locale
  }

  Future<void> renameBuild(String newName) async {
    // ... logica esistente ...
    _analytics.capture('build_renamed');
  }

  Future<void> deleteBuild(int buildId) async {
    // ... logica esistente ...
    _analytics.capture('build_deleted');
  }

  Future<void> equipWeapon(int weaponId) async {
    // ... logica esistente ...
    _analytics.capture('item_equipped', properties: {'slot_type': 'weapon'});
  }

  Future<void> equipArmor(int armorId, ArmorSlotType slot) async {
    // ... logica esistente ...
    _analytics.capture('item_equipped', properties: {'slot_type': slot.name});
  }

  Future<void> equipCharm(int charmId) async {
    // ... logica esistente ...
    _analytics.capture('item_equipped', properties: {'slot_type': 'charm'});
  }

  Future<void> setJewel(JewelSlotSource source, int slotIndex, int jewelId, int slotLevel) async {
    // ... logica esistente ...
    _analytics.capture('jewel_equipped', properties: {'slot_level': slotLevel});
  }

  Future<void> clearJewel(JewelSlotSource source, int slotIndex) async {
    // ... logica esistente ...
    _analytics.capture('jewel_cleared');
  }
}
```

---

## 7. Equipment search tracking

In `lib/features/equipment/equipment_screen.dart`, aggiungi un debounce sulla search:

```dart
// Dentro _EquipmentScreenState
Timer? _searchDebounce;

void _onSearchChanged(String query, String segment, bool hasResults) {
  _searchDebounce?.cancel();
  _searchDebounce = Timer(const Duration(milliseconds: 500), () {
    ref.read(analyticsServiceProvider).capture('equipment_searched', properties: {
      'segment': segment,          // 'weapons' | 'armor' | 'charm'
      'query_length': query.length,
      'has_results': hasResults,
    });
  });
}

@override
void dispose() {
  _searchDebounce?.cancel();
  super.dispose();
}
```

Chiama `_onSearchChanged` dentro il callback `onChanged` del `SearchField`.

---

## 8. Error tracking

In `lib/main.dart`, subito prima di `runApp`:

```dart
FlutterError.onError = (FlutterErrorDetails details) {
  FlutterError.presentError(details);
  // Non loggare il messaggio di errore completo — solo il tipo
  final errorType = details.exception.runtimeType.toString();
  Posthog().capture(
    eventName: 'error_occurred',
    properties: {
      'feature_area': 'unknown',
      'error_type': errorType,
    },
  );
};

PlatformDispatcher.instance.onError = (error, stack) {
  final errorType = error.runtimeType.toString();
  Posthog().capture(
    eventName: 'error_occurred',
    properties: {
      'feature_area': 'platform',
      'error_type': errorType,
    },
  );
  return false;
};
```

Per errori in feature specifiche, chiama direttamente:

```dart
_analytics.capture('error_occurred', properties: {
  'feature_area': 'build',    // build | equipment | stats | sync
  'error_type': e.runtimeType.toString(),
});
```

---

## 9. Sync tracking (Phase 5)

Quando implementerai `SyncService` in `lib/core/sync/sync_service.dart`:

```dart
Future<void> checkAndSync() async {
  final stopwatch = Stopwatch()..start();
  try {
    final updated = await _performSync();
    stopwatch.stop();
    if (updated > 0) {
      _analytics.capture('sync_completed', properties: {
        'tables_updated': updated,
        'duration_ms': stopwatch.elapsedMilliseconds,
      });
    } else {
      _analytics.capture('sync_skipped');
    }
  } catch (e) {
    _analytics.capture('sync_failed', properties: {
      'error_type': e.runtimeType.toString(),
    });
    rethrow;
  }
}
```

---

## 10. Test

Crea `test/core/analytics/anonymous_id_service_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mhw_app/core/analytics/anonymous_id_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('generates ID on first call', () async {
    final id = await AnonymousIdService.getOrCreate();
    expect(id, isNotEmpty);
  });

  test('returns same ID on subsequent calls', () async {
    final id1 = await AnonymousIdService.getOrCreate();
    final id2 = await AnonymousIdService.getOrCreate();
    expect(id1, equals(id2));
  });
}
```

Crea `test/core/analytics/noop_analytics_service_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mhw_app/core/analytics/noop_analytics_service.dart';

void main() {
  test('NoopAnalyticsService completes without throwing', () async {
    final svc = NoopAnalyticsService();
    await expectLater(svc.identify('test-id'), completes);
    await expectLater(svc.capture('test_event'), completes);
    await expectLater(svc.screen('test_screen'), completes);
    await expectLater(svc.reset(), completes);
  });
}
```

Per i widget test esistenti, nessuna modifica necessaria: `analyticsServiceProvider` in `AppConfig.isRelease = false` restituisce già il `NoopAnalyticsService`.

Nei test che usano `ProviderContainer`, aggiungi l'override esplicitamente per sicurezza:

```dart
final container = ProviderContainer(
  overrides: [
    analyticsServiceProvider.overrideWithValue(NoopAnalyticsService()),
  ],
);
```

---

## Evento index (riepilogo)

| Evento | Quando | Proprietà |
|--------|--------|-----------|
| `screen_viewed` | Cambio tab | `screen` |
| `build_created` | `newBuild()` | — |
| `build_loaded` | `loadBuild()` | — |
| `build_renamed` | `renameBuild()` | — |
| `build_deleted` | `deleteBuild()` | — |
| `item_equipped` | `equipWeapon/Armor/Charm()` | `slot_type` |
| `item_cleared` | clear slot | `slot_type` |
| `jewel_equipped` | `setJewel()` | `slot_level` |
| `jewel_cleared` | `clearJewel()` | — |
| `equipment_searched` | search dopo 500ms | `segment`, `query_length`, `has_results` |
| `sync_completed` | sync ok | `tables_updated`, `duration_ms` |
| `sync_skipped` | versione aggiornata | — |
| `sync_failed` | errore sync | `error_type` |
| `error_occurred` | errore runtime | `feature_area`, `error_type` |

---

## Ordine di implementazione consigliato

1. `AppConfig` + pubspec → `flutter pub get`
2. `AnalyticsService` (abstract) + `NoopAnalyticsService` + `PostHogAnalyticsService`
3. `analytics_provider.dart`
4. `AnonymousIdService`
5. Test per i punti 2–4 → `flutter test`
6. `main.dart`: init PostHog + `identify`
7. `AnalyticsNavigatorObserver` → wiring in `router.dart`
8. `build_notifier.dart`: tutti gli eventi build/jewel
9. `equipment_screen.dart`: search debounce
10. `main.dart`: error handlers
11. (Phase 5) `sync_service.dart`: sync events
