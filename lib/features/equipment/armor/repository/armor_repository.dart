import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/providers/database_provider.dart';

class ArmorRepository {
  final AppDatabase _db;
  ArmorRepository(this._db);

  Stream<List<ArmorPiece>> watchAll() => _db.armorDao.watchAll();

  Stream<List<ArmorPiece>> watchBySlot(String slotType) =>
      _db.armorDao.watchBySlot(slotType);

  Future<ArmorPiece?> getById(String id) => _db.armorDao.getById(id);

  Future<List<ArmorSetSkill>> getSetSkills(String setId) =>
      _db.armorDao.getSetSkills(setId);
}

final armorRepositoryProvider = Provider<ArmorRepository>((ref) {
  return ArmorRepository(ref.watch(databaseProvider));
});

final allArmorProvider = StreamProvider<List<ArmorPiece>>((ref) {
  return ref.watch(armorRepositoryProvider).watchAll();
});

final armorBySlotProvider =
    StreamProvider.family<List<ArmorPiece>, String>((ref, slot) {
  return ref.watch(armorRepositoryProvider).watchBySlot(slot);
});
