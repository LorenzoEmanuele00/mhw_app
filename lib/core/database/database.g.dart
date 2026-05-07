// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WeaponsTable extends Weapons with TableInfo<$WeaponsTable, Weapon> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeaponsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WeaponType, String> weaponType =
      GeneratedColumn<String>(
        'weapon_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WeaponType>($WeaponsTable.$converterweaponType);
  static const VerificationMeta _baseAttackMeta = const VerificationMeta(
    'baseAttack',
  );
  @override
  late final GeneratedColumn<int> baseAttack = GeneratedColumn<int>(
    'base_attack',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseAffinityMeta = const VerificationMeta(
    'baseAffinity',
  );
  @override
  late final GeneratedColumn<double> baseAffinity = GeneratedColumn<double>(
    'base_affinity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ElementType?, String>
  elementType = GeneratedColumn<String>(
    'element_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ElementType?>($WeaponsTable.$converterelementTypen);
  static const VerificationMeta _elementValueMeta = const VerificationMeta(
    'elementValue',
  );
  @override
  late final GeneratedColumn<int> elementValue = GeneratedColumn<int>(
    'element_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SharpnessLevel, String>
  sharpnessMax = GeneratedColumn<String>(
    'sharpness_max',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('white'),
  ).withConverter<SharpnessLevel>($WeaponsTable.$convertersharpnessMax);
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<int> rarity = GeneratedColumn<int>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _slotsMeta = const VerificationMeta('slots');
  @override
  late final GeneratedColumn<String> slots = GeneratedColumn<String>(
    'slots',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _rmvMeta = const VerificationMeta('rmv');
  @override
  late final GeneratedColumn<double> rmv = GeneratedColumn<double>(
    'rmv',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _emvMeta = const VerificationMeta('emv');
  @override
  late final GeneratedColumn<double> emv = GeneratedColumn<double>(
    'emv',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DamageType, String> damageType =
      GeneratedColumn<String>(
        'damage_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('cut'),
      ).withConverter<DamageType>($WeaponsTable.$converterdamageType);
  static const VerificationMeta _burstGroupMeta = const VerificationMeta(
    'burstGroup',
  );
  @override
  late final GeneratedColumn<String> burstGroup = GeneratedColumn<String>(
    'burst_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Other'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    name,
    weaponType,
    baseAttack,
    baseAffinity,
    elementType,
    elementValue,
    sharpnessMax,
    rarity,
    slots,
    rmv,
    emv,
    damageType,
    burstGroup,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weapons';
  @override
  VerificationContext validateIntegrity(
    Insertable<Weapon> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_attack')) {
      context.handle(
        _baseAttackMeta,
        baseAttack.isAcceptableOrUnknown(data['base_attack']!, _baseAttackMeta),
      );
    } else if (isInserting) {
      context.missing(_baseAttackMeta);
    }
    if (data.containsKey('base_affinity')) {
      context.handle(
        _baseAffinityMeta,
        baseAffinity.isAcceptableOrUnknown(
          data['base_affinity']!,
          _baseAffinityMeta,
        ),
      );
    }
    if (data.containsKey('element_value')) {
      context.handle(
        _elementValueMeta,
        elementValue.isAcceptableOrUnknown(
          data['element_value']!,
          _elementValueMeta,
        ),
      );
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    }
    if (data.containsKey('slots')) {
      context.handle(
        _slotsMeta,
        slots.isAcceptableOrUnknown(data['slots']!, _slotsMeta),
      );
    }
    if (data.containsKey('rmv')) {
      context.handle(
        _rmvMeta,
        rmv.isAcceptableOrUnknown(data['rmv']!, _rmvMeta),
      );
    }
    if (data.containsKey('emv')) {
      context.handle(
        _emvMeta,
        emv.isAcceptableOrUnknown(data['emv']!, _emvMeta),
      );
    }
    if (data.containsKey('burst_group')) {
      context.handle(
        _burstGroupMeta,
        burstGroup.isAcceptableOrUnknown(data['burst_group']!, _burstGroupMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {slug},
  ];
  @override
  Weapon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weapon(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      weaponType: $WeaponsTable.$converterweaponType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}weapon_type'],
        )!,
      ),
      baseAttack: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_attack'],
      )!,
      baseAffinity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}base_affinity'],
      )!,
      elementType: $WeaponsTable.$converterelementTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}element_type'],
        ),
      ),
      elementValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}element_value'],
      ),
      sharpnessMax: $WeaponsTable.$convertersharpnessMax.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sharpness_max'],
        )!,
      ),
      rarity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rarity'],
      )!,
      slots: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slots'],
      )!,
      rmv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rmv'],
      )!,
      emv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}emv'],
      )!,
      damageType: $WeaponsTable.$converterdamageType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}damage_type'],
        )!,
      ),
      burstGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}burst_group'],
      )!,
    );
  }

  @override
  $WeaponsTable createAlias(String alias) {
    return $WeaponsTable(attachedDatabase, alias);
  }

  static TypeConverter<WeaponType, String> $converterweaponType =
      const WeaponTypeConverter();
  static TypeConverter<ElementType, String> $converterelementType =
      const ElementTypeConverter();
  static TypeConverter<ElementType?, String?> $converterelementTypen =
      NullAwareTypeConverter.wrap($converterelementType);
  static TypeConverter<SharpnessLevel, String> $convertersharpnessMax =
      const SharpnessLevelConverter();
  static TypeConverter<DamageType, String> $converterdamageType =
      const DamageTypeConverter();
}

class Weapon extends DataClass implements Insertable<Weapon> {
  final int id;
  final String slug;
  final String name;
  final WeaponType weaponType;
  final int baseAttack;
  final double baseAffinity;
  final ElementType? elementType;
  final int? elementValue;
  final SharpnessLevel sharpnessMax;
  final int rarity;
  final String slots;
  final double rmv;
  final double emv;
  final DamageType damageType;
  final String burstGroup;
  const Weapon({
    required this.id,
    required this.slug,
    required this.name,
    required this.weaponType,
    required this.baseAttack,
    required this.baseAffinity,
    this.elementType,
    this.elementValue,
    required this.sharpnessMax,
    required this.rarity,
    required this.slots,
    required this.rmv,
    required this.emv,
    required this.damageType,
    required this.burstGroup,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    {
      map['weapon_type'] = Variable<String>(
        $WeaponsTable.$converterweaponType.toSql(weaponType),
      );
    }
    map['base_attack'] = Variable<int>(baseAttack);
    map['base_affinity'] = Variable<double>(baseAffinity);
    if (!nullToAbsent || elementType != null) {
      map['element_type'] = Variable<String>(
        $WeaponsTable.$converterelementTypen.toSql(elementType),
      );
    }
    if (!nullToAbsent || elementValue != null) {
      map['element_value'] = Variable<int>(elementValue);
    }
    {
      map['sharpness_max'] = Variable<String>(
        $WeaponsTable.$convertersharpnessMax.toSql(sharpnessMax),
      );
    }
    map['rarity'] = Variable<int>(rarity);
    map['slots'] = Variable<String>(slots);
    map['rmv'] = Variable<double>(rmv);
    map['emv'] = Variable<double>(emv);
    {
      map['damage_type'] = Variable<String>(
        $WeaponsTable.$converterdamageType.toSql(damageType),
      );
    }
    map['burst_group'] = Variable<String>(burstGroup);
    return map;
  }

  WeaponsCompanion toCompanion(bool nullToAbsent) {
    return WeaponsCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      weaponType: Value(weaponType),
      baseAttack: Value(baseAttack),
      baseAffinity: Value(baseAffinity),
      elementType: elementType == null && nullToAbsent
          ? const Value.absent()
          : Value(elementType),
      elementValue: elementValue == null && nullToAbsent
          ? const Value.absent()
          : Value(elementValue),
      sharpnessMax: Value(sharpnessMax),
      rarity: Value(rarity),
      slots: Value(slots),
      rmv: Value(rmv),
      emv: Value(emv),
      damageType: Value(damageType),
      burstGroup: Value(burstGroup),
    );
  }

  factory Weapon.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weapon(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      weaponType: serializer.fromJson<WeaponType>(json['weaponType']),
      baseAttack: serializer.fromJson<int>(json['baseAttack']),
      baseAffinity: serializer.fromJson<double>(json['baseAffinity']),
      elementType: serializer.fromJson<ElementType?>(json['elementType']),
      elementValue: serializer.fromJson<int?>(json['elementValue']),
      sharpnessMax: serializer.fromJson<SharpnessLevel>(json['sharpnessMax']),
      rarity: serializer.fromJson<int>(json['rarity']),
      slots: serializer.fromJson<String>(json['slots']),
      rmv: serializer.fromJson<double>(json['rmv']),
      emv: serializer.fromJson<double>(json['emv']),
      damageType: serializer.fromJson<DamageType>(json['damageType']),
      burstGroup: serializer.fromJson<String>(json['burstGroup']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'weaponType': serializer.toJson<WeaponType>(weaponType),
      'baseAttack': serializer.toJson<int>(baseAttack),
      'baseAffinity': serializer.toJson<double>(baseAffinity),
      'elementType': serializer.toJson<ElementType?>(elementType),
      'elementValue': serializer.toJson<int?>(elementValue),
      'sharpnessMax': serializer.toJson<SharpnessLevel>(sharpnessMax),
      'rarity': serializer.toJson<int>(rarity),
      'slots': serializer.toJson<String>(slots),
      'rmv': serializer.toJson<double>(rmv),
      'emv': serializer.toJson<double>(emv),
      'damageType': serializer.toJson<DamageType>(damageType),
      'burstGroup': serializer.toJson<String>(burstGroup),
    };
  }

  Weapon copyWith({
    int? id,
    String? slug,
    String? name,
    WeaponType? weaponType,
    int? baseAttack,
    double? baseAffinity,
    Value<ElementType?> elementType = const Value.absent(),
    Value<int?> elementValue = const Value.absent(),
    SharpnessLevel? sharpnessMax,
    int? rarity,
    String? slots,
    double? rmv,
    double? emv,
    DamageType? damageType,
    String? burstGroup,
  }) => Weapon(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    weaponType: weaponType ?? this.weaponType,
    baseAttack: baseAttack ?? this.baseAttack,
    baseAffinity: baseAffinity ?? this.baseAffinity,
    elementType: elementType.present ? elementType.value : this.elementType,
    elementValue: elementValue.present ? elementValue.value : this.elementValue,
    sharpnessMax: sharpnessMax ?? this.sharpnessMax,
    rarity: rarity ?? this.rarity,
    slots: slots ?? this.slots,
    rmv: rmv ?? this.rmv,
    emv: emv ?? this.emv,
    damageType: damageType ?? this.damageType,
    burstGroup: burstGroup ?? this.burstGroup,
  );
  Weapon copyWithCompanion(WeaponsCompanion data) {
    return Weapon(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      weaponType: data.weaponType.present
          ? data.weaponType.value
          : this.weaponType,
      baseAttack: data.baseAttack.present
          ? data.baseAttack.value
          : this.baseAttack,
      baseAffinity: data.baseAffinity.present
          ? data.baseAffinity.value
          : this.baseAffinity,
      elementType: data.elementType.present
          ? data.elementType.value
          : this.elementType,
      elementValue: data.elementValue.present
          ? data.elementValue.value
          : this.elementValue,
      sharpnessMax: data.sharpnessMax.present
          ? data.sharpnessMax.value
          : this.sharpnessMax,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      slots: data.slots.present ? data.slots.value : this.slots,
      rmv: data.rmv.present ? data.rmv.value : this.rmv,
      emv: data.emv.present ? data.emv.value : this.emv,
      damageType: data.damageType.present
          ? data.damageType.value
          : this.damageType,
      burstGroup: data.burstGroup.present
          ? data.burstGroup.value
          : this.burstGroup,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Weapon(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('weaponType: $weaponType, ')
          ..write('baseAttack: $baseAttack, ')
          ..write('baseAffinity: $baseAffinity, ')
          ..write('elementType: $elementType, ')
          ..write('elementValue: $elementValue, ')
          ..write('sharpnessMax: $sharpnessMax, ')
          ..write('rarity: $rarity, ')
          ..write('slots: $slots, ')
          ..write('rmv: $rmv, ')
          ..write('emv: $emv, ')
          ..write('damageType: $damageType, ')
          ..write('burstGroup: $burstGroup')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    name,
    weaponType,
    baseAttack,
    baseAffinity,
    elementType,
    elementValue,
    sharpnessMax,
    rarity,
    slots,
    rmv,
    emv,
    damageType,
    burstGroup,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weapon &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.weaponType == this.weaponType &&
          other.baseAttack == this.baseAttack &&
          other.baseAffinity == this.baseAffinity &&
          other.elementType == this.elementType &&
          other.elementValue == this.elementValue &&
          other.sharpnessMax == this.sharpnessMax &&
          other.rarity == this.rarity &&
          other.slots == this.slots &&
          other.rmv == this.rmv &&
          other.emv == this.emv &&
          other.damageType == this.damageType &&
          other.burstGroup == this.burstGroup);
}

class WeaponsCompanion extends UpdateCompanion<Weapon> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<WeaponType> weaponType;
  final Value<int> baseAttack;
  final Value<double> baseAffinity;
  final Value<ElementType?> elementType;
  final Value<int?> elementValue;
  final Value<SharpnessLevel> sharpnessMax;
  final Value<int> rarity;
  final Value<String> slots;
  final Value<double> rmv;
  final Value<double> emv;
  final Value<DamageType> damageType;
  final Value<String> burstGroup;
  const WeaponsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.weaponType = const Value.absent(),
    this.baseAttack = const Value.absent(),
    this.baseAffinity = const Value.absent(),
    this.elementType = const Value.absent(),
    this.elementValue = const Value.absent(),
    this.sharpnessMax = const Value.absent(),
    this.rarity = const Value.absent(),
    this.slots = const Value.absent(),
    this.rmv = const Value.absent(),
    this.emv = const Value.absent(),
    this.damageType = const Value.absent(),
    this.burstGroup = const Value.absent(),
  });
  WeaponsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String name,
    required WeaponType weaponType,
    required int baseAttack,
    this.baseAffinity = const Value.absent(),
    this.elementType = const Value.absent(),
    this.elementValue = const Value.absent(),
    this.sharpnessMax = const Value.absent(),
    this.rarity = const Value.absent(),
    this.slots = const Value.absent(),
    this.rmv = const Value.absent(),
    this.emv = const Value.absent(),
    this.damageType = const Value.absent(),
    this.burstGroup = const Value.absent(),
  }) : slug = Value(slug),
       name = Value(name),
       weaponType = Value(weaponType),
       baseAttack = Value(baseAttack);
  static Insertable<Weapon> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<String>? weaponType,
    Expression<int>? baseAttack,
    Expression<double>? baseAffinity,
    Expression<String>? elementType,
    Expression<int>? elementValue,
    Expression<String>? sharpnessMax,
    Expression<int>? rarity,
    Expression<String>? slots,
    Expression<double>? rmv,
    Expression<double>? emv,
    Expression<String>? damageType,
    Expression<String>? burstGroup,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (weaponType != null) 'weapon_type': weaponType,
      if (baseAttack != null) 'base_attack': baseAttack,
      if (baseAffinity != null) 'base_affinity': baseAffinity,
      if (elementType != null) 'element_type': elementType,
      if (elementValue != null) 'element_value': elementValue,
      if (sharpnessMax != null) 'sharpness_max': sharpnessMax,
      if (rarity != null) 'rarity': rarity,
      if (slots != null) 'slots': slots,
      if (rmv != null) 'rmv': rmv,
      if (emv != null) 'emv': emv,
      if (damageType != null) 'damage_type': damageType,
      if (burstGroup != null) 'burst_group': burstGroup,
    });
  }

  WeaponsCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<WeaponType>? weaponType,
    Value<int>? baseAttack,
    Value<double>? baseAffinity,
    Value<ElementType?>? elementType,
    Value<int?>? elementValue,
    Value<SharpnessLevel>? sharpnessMax,
    Value<int>? rarity,
    Value<String>? slots,
    Value<double>? rmv,
    Value<double>? emv,
    Value<DamageType>? damageType,
    Value<String>? burstGroup,
  }) {
    return WeaponsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      weaponType: weaponType ?? this.weaponType,
      baseAttack: baseAttack ?? this.baseAttack,
      baseAffinity: baseAffinity ?? this.baseAffinity,
      elementType: elementType ?? this.elementType,
      elementValue: elementValue ?? this.elementValue,
      sharpnessMax: sharpnessMax ?? this.sharpnessMax,
      rarity: rarity ?? this.rarity,
      slots: slots ?? this.slots,
      rmv: rmv ?? this.rmv,
      emv: emv ?? this.emv,
      damageType: damageType ?? this.damageType,
      burstGroup: burstGroup ?? this.burstGroup,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weaponType.present) {
      map['weapon_type'] = Variable<String>(
        $WeaponsTable.$converterweaponType.toSql(weaponType.value),
      );
    }
    if (baseAttack.present) {
      map['base_attack'] = Variable<int>(baseAttack.value);
    }
    if (baseAffinity.present) {
      map['base_affinity'] = Variable<double>(baseAffinity.value);
    }
    if (elementType.present) {
      map['element_type'] = Variable<String>(
        $WeaponsTable.$converterelementTypen.toSql(elementType.value),
      );
    }
    if (elementValue.present) {
      map['element_value'] = Variable<int>(elementValue.value);
    }
    if (sharpnessMax.present) {
      map['sharpness_max'] = Variable<String>(
        $WeaponsTable.$convertersharpnessMax.toSql(sharpnessMax.value),
      );
    }
    if (rarity.present) {
      map['rarity'] = Variable<int>(rarity.value);
    }
    if (slots.present) {
      map['slots'] = Variable<String>(slots.value);
    }
    if (rmv.present) {
      map['rmv'] = Variable<double>(rmv.value);
    }
    if (emv.present) {
      map['emv'] = Variable<double>(emv.value);
    }
    if (damageType.present) {
      map['damage_type'] = Variable<String>(
        $WeaponsTable.$converterdamageType.toSql(damageType.value),
      );
    }
    if (burstGroup.present) {
      map['burst_group'] = Variable<String>(burstGroup.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeaponsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('weaponType: $weaponType, ')
          ..write('baseAttack: $baseAttack, ')
          ..write('baseAffinity: $baseAffinity, ')
          ..write('elementType: $elementType, ')
          ..write('elementValue: $elementValue, ')
          ..write('sharpnessMax: $sharpnessMax, ')
          ..write('rarity: $rarity, ')
          ..write('slots: $slots, ')
          ..write('rmv: $rmv, ')
          ..write('emv: $emv, ')
          ..write('damageType: $damageType, ')
          ..write('burstGroup: $burstGroup')
          ..write(')'))
        .toString();
  }
}

class $ArmorSetsTable extends ArmorSets
    with TableInfo<$ArmorSetsTable, ArmorSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArmorSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, slug, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'armor_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArmorSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {slug},
  ];
  @override
  ArmorSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArmorSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ArmorSetsTable createAlias(String alias) {
    return $ArmorSetsTable(attachedDatabase, alias);
  }
}

class ArmorSet extends DataClass implements Insertable<ArmorSet> {
  final int id;
  final String slug;
  final String name;
  const ArmorSet({required this.id, required this.slug, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    return map;
  }

  ArmorSetsCompanion toCompanion(bool nullToAbsent) {
    return ArmorSetsCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
    );
  }

  factory ArmorSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArmorSet(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
    };
  }

  ArmorSet copyWith({int? id, String? slug, String? name}) => ArmorSet(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
  );
  ArmorSet copyWithCompanion(ArmorSetsCompanion data) {
    return ArmorSet(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArmorSet(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArmorSet &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name);
}

class ArmorSetsCompanion extends UpdateCompanion<ArmorSet> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> name;
  const ArmorSetsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
  });
  ArmorSetsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String name,
  }) : slug = Value(slug),
       name = Value(name);
  static Insertable<ArmorSet> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
    });
  }

  ArmorSetsCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? name,
  }) {
    return ArmorSetsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArmorSetsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ArmorPiecesTable extends ArmorPieces
    with TableInfo<$ArmorPiecesTable, ArmorPiece> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArmorPiecesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ArmorSlotType, String> slotType =
      GeneratedColumn<String>(
        'slot_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ArmorSlotType>($ArmorPiecesTable.$converterslotType);
  static const VerificationMeta _baseDefenseMeta = const VerificationMeta(
    'baseDefense',
  );
  @override
  late final GeneratedColumn<int> baseDefense = GeneratedColumn<int>(
    'base_defense',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fireResMeta = const VerificationMeta(
    'fireRes',
  );
  @override
  late final GeneratedColumn<int> fireRes = GeneratedColumn<int>(
    'fire_res',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _waterResMeta = const VerificationMeta(
    'waterRes',
  );
  @override
  late final GeneratedColumn<int> waterRes = GeneratedColumn<int>(
    'water_res',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _thunderResMeta = const VerificationMeta(
    'thunderRes',
  );
  @override
  late final GeneratedColumn<int> thunderRes = GeneratedColumn<int>(
    'thunder_res',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _iceResMeta = const VerificationMeta('iceRes');
  @override
  late final GeneratedColumn<int> iceRes = GeneratedColumn<int>(
    'ice_res',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dragonResMeta = const VerificationMeta(
    'dragonRes',
  );
  @override
  late final GeneratedColumn<int> dragonRes = GeneratedColumn<int>(
    'dragon_res',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<int> rarity = GeneratedColumn<int>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _slotsMeta = const VerificationMeta('slots');
  @override
  late final GeneratedColumn<String> slots = GeneratedColumn<String>(
    'slots',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<int> setId = GeneratedColumn<int>(
    'set_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES armor_sets (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    name,
    slotType,
    baseDefense,
    fireRes,
    waterRes,
    thunderRes,
    iceRes,
    dragonRes,
    rarity,
    slots,
    setId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'armor_pieces';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArmorPiece> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_defense')) {
      context.handle(
        _baseDefenseMeta,
        baseDefense.isAcceptableOrUnknown(
          data['base_defense']!,
          _baseDefenseMeta,
        ),
      );
    }
    if (data.containsKey('fire_res')) {
      context.handle(
        _fireResMeta,
        fireRes.isAcceptableOrUnknown(data['fire_res']!, _fireResMeta),
      );
    }
    if (data.containsKey('water_res')) {
      context.handle(
        _waterResMeta,
        waterRes.isAcceptableOrUnknown(data['water_res']!, _waterResMeta),
      );
    }
    if (data.containsKey('thunder_res')) {
      context.handle(
        _thunderResMeta,
        thunderRes.isAcceptableOrUnknown(data['thunder_res']!, _thunderResMeta),
      );
    }
    if (data.containsKey('ice_res')) {
      context.handle(
        _iceResMeta,
        iceRes.isAcceptableOrUnknown(data['ice_res']!, _iceResMeta),
      );
    }
    if (data.containsKey('dragon_res')) {
      context.handle(
        _dragonResMeta,
        dragonRes.isAcceptableOrUnknown(data['dragon_res']!, _dragonResMeta),
      );
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    }
    if (data.containsKey('slots')) {
      context.handle(
        _slotsMeta,
        slots.isAcceptableOrUnknown(data['slots']!, _slotsMeta),
      );
    }
    if (data.containsKey('set_id')) {
      context.handle(
        _setIdMeta,
        setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta),
      );
    } else if (isInserting) {
      context.missing(_setIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {slug},
  ];
  @override
  ArmorPiece map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArmorPiece(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slotType: $ArmorPiecesTable.$converterslotType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}slot_type'],
        )!,
      ),
      baseDefense: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_defense'],
      )!,
      fireRes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fire_res'],
      )!,
      waterRes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}water_res'],
      )!,
      thunderRes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}thunder_res'],
      )!,
      iceRes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ice_res'],
      )!,
      dragonRes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dragon_res'],
      )!,
      rarity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rarity'],
      )!,
      slots: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slots'],
      )!,
      setId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_id'],
      )!,
    );
  }

  @override
  $ArmorPiecesTable createAlias(String alias) {
    return $ArmorPiecesTable(attachedDatabase, alias);
  }

  static TypeConverter<ArmorSlotType, String> $converterslotType =
      const ArmorSlotTypeConverter();
}

class ArmorPiece extends DataClass implements Insertable<ArmorPiece> {
  final int id;
  final String slug;
  final String name;
  final ArmorSlotType slotType;
  final int baseDefense;
  final int fireRes;
  final int waterRes;
  final int thunderRes;
  final int iceRes;
  final int dragonRes;
  final int rarity;
  final String slots;
  final int setId;
  const ArmorPiece({
    required this.id,
    required this.slug,
    required this.name,
    required this.slotType,
    required this.baseDefense,
    required this.fireRes,
    required this.waterRes,
    required this.thunderRes,
    required this.iceRes,
    required this.dragonRes,
    required this.rarity,
    required this.slots,
    required this.setId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    {
      map['slot_type'] = Variable<String>(
        $ArmorPiecesTable.$converterslotType.toSql(slotType),
      );
    }
    map['base_defense'] = Variable<int>(baseDefense);
    map['fire_res'] = Variable<int>(fireRes);
    map['water_res'] = Variable<int>(waterRes);
    map['thunder_res'] = Variable<int>(thunderRes);
    map['ice_res'] = Variable<int>(iceRes);
    map['dragon_res'] = Variable<int>(dragonRes);
    map['rarity'] = Variable<int>(rarity);
    map['slots'] = Variable<String>(slots);
    map['set_id'] = Variable<int>(setId);
    return map;
  }

  ArmorPiecesCompanion toCompanion(bool nullToAbsent) {
    return ArmorPiecesCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      slotType: Value(slotType),
      baseDefense: Value(baseDefense),
      fireRes: Value(fireRes),
      waterRes: Value(waterRes),
      thunderRes: Value(thunderRes),
      iceRes: Value(iceRes),
      dragonRes: Value(dragonRes),
      rarity: Value(rarity),
      slots: Value(slots),
      setId: Value(setId),
    );
  }

  factory ArmorPiece.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArmorPiece(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      slotType: serializer.fromJson<ArmorSlotType>(json['slotType']),
      baseDefense: serializer.fromJson<int>(json['baseDefense']),
      fireRes: serializer.fromJson<int>(json['fireRes']),
      waterRes: serializer.fromJson<int>(json['waterRes']),
      thunderRes: serializer.fromJson<int>(json['thunderRes']),
      iceRes: serializer.fromJson<int>(json['iceRes']),
      dragonRes: serializer.fromJson<int>(json['dragonRes']),
      rarity: serializer.fromJson<int>(json['rarity']),
      slots: serializer.fromJson<String>(json['slots']),
      setId: serializer.fromJson<int>(json['setId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'slotType': serializer.toJson<ArmorSlotType>(slotType),
      'baseDefense': serializer.toJson<int>(baseDefense),
      'fireRes': serializer.toJson<int>(fireRes),
      'waterRes': serializer.toJson<int>(waterRes),
      'thunderRes': serializer.toJson<int>(thunderRes),
      'iceRes': serializer.toJson<int>(iceRes),
      'dragonRes': serializer.toJson<int>(dragonRes),
      'rarity': serializer.toJson<int>(rarity),
      'slots': serializer.toJson<String>(slots),
      'setId': serializer.toJson<int>(setId),
    };
  }

  ArmorPiece copyWith({
    int? id,
    String? slug,
    String? name,
    ArmorSlotType? slotType,
    int? baseDefense,
    int? fireRes,
    int? waterRes,
    int? thunderRes,
    int? iceRes,
    int? dragonRes,
    int? rarity,
    String? slots,
    int? setId,
  }) => ArmorPiece(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    slotType: slotType ?? this.slotType,
    baseDefense: baseDefense ?? this.baseDefense,
    fireRes: fireRes ?? this.fireRes,
    waterRes: waterRes ?? this.waterRes,
    thunderRes: thunderRes ?? this.thunderRes,
    iceRes: iceRes ?? this.iceRes,
    dragonRes: dragonRes ?? this.dragonRes,
    rarity: rarity ?? this.rarity,
    slots: slots ?? this.slots,
    setId: setId ?? this.setId,
  );
  ArmorPiece copyWithCompanion(ArmorPiecesCompanion data) {
    return ArmorPiece(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      slotType: data.slotType.present ? data.slotType.value : this.slotType,
      baseDefense: data.baseDefense.present
          ? data.baseDefense.value
          : this.baseDefense,
      fireRes: data.fireRes.present ? data.fireRes.value : this.fireRes,
      waterRes: data.waterRes.present ? data.waterRes.value : this.waterRes,
      thunderRes: data.thunderRes.present
          ? data.thunderRes.value
          : this.thunderRes,
      iceRes: data.iceRes.present ? data.iceRes.value : this.iceRes,
      dragonRes: data.dragonRes.present ? data.dragonRes.value : this.dragonRes,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      slots: data.slots.present ? data.slots.value : this.slots,
      setId: data.setId.present ? data.setId.value : this.setId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArmorPiece(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('slotType: $slotType, ')
          ..write('baseDefense: $baseDefense, ')
          ..write('fireRes: $fireRes, ')
          ..write('waterRes: $waterRes, ')
          ..write('thunderRes: $thunderRes, ')
          ..write('iceRes: $iceRes, ')
          ..write('dragonRes: $dragonRes, ')
          ..write('rarity: $rarity, ')
          ..write('slots: $slots, ')
          ..write('setId: $setId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    name,
    slotType,
    baseDefense,
    fireRes,
    waterRes,
    thunderRes,
    iceRes,
    dragonRes,
    rarity,
    slots,
    setId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArmorPiece &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.slotType == this.slotType &&
          other.baseDefense == this.baseDefense &&
          other.fireRes == this.fireRes &&
          other.waterRes == this.waterRes &&
          other.thunderRes == this.thunderRes &&
          other.iceRes == this.iceRes &&
          other.dragonRes == this.dragonRes &&
          other.rarity == this.rarity &&
          other.slots == this.slots &&
          other.setId == this.setId);
}

class ArmorPiecesCompanion extends UpdateCompanion<ArmorPiece> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<ArmorSlotType> slotType;
  final Value<int> baseDefense;
  final Value<int> fireRes;
  final Value<int> waterRes;
  final Value<int> thunderRes;
  final Value<int> iceRes;
  final Value<int> dragonRes;
  final Value<int> rarity;
  final Value<String> slots;
  final Value<int> setId;
  const ArmorPiecesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.slotType = const Value.absent(),
    this.baseDefense = const Value.absent(),
    this.fireRes = const Value.absent(),
    this.waterRes = const Value.absent(),
    this.thunderRes = const Value.absent(),
    this.iceRes = const Value.absent(),
    this.dragonRes = const Value.absent(),
    this.rarity = const Value.absent(),
    this.slots = const Value.absent(),
    this.setId = const Value.absent(),
  });
  ArmorPiecesCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String name,
    required ArmorSlotType slotType,
    this.baseDefense = const Value.absent(),
    this.fireRes = const Value.absent(),
    this.waterRes = const Value.absent(),
    this.thunderRes = const Value.absent(),
    this.iceRes = const Value.absent(),
    this.dragonRes = const Value.absent(),
    this.rarity = const Value.absent(),
    this.slots = const Value.absent(),
    required int setId,
  }) : slug = Value(slug),
       name = Value(name),
       slotType = Value(slotType),
       setId = Value(setId);
  static Insertable<ArmorPiece> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<String>? slotType,
    Expression<int>? baseDefense,
    Expression<int>? fireRes,
    Expression<int>? waterRes,
    Expression<int>? thunderRes,
    Expression<int>? iceRes,
    Expression<int>? dragonRes,
    Expression<int>? rarity,
    Expression<String>? slots,
    Expression<int>? setId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (slotType != null) 'slot_type': slotType,
      if (baseDefense != null) 'base_defense': baseDefense,
      if (fireRes != null) 'fire_res': fireRes,
      if (waterRes != null) 'water_res': waterRes,
      if (thunderRes != null) 'thunder_res': thunderRes,
      if (iceRes != null) 'ice_res': iceRes,
      if (dragonRes != null) 'dragon_res': dragonRes,
      if (rarity != null) 'rarity': rarity,
      if (slots != null) 'slots': slots,
      if (setId != null) 'set_id': setId,
    });
  }

  ArmorPiecesCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<ArmorSlotType>? slotType,
    Value<int>? baseDefense,
    Value<int>? fireRes,
    Value<int>? waterRes,
    Value<int>? thunderRes,
    Value<int>? iceRes,
    Value<int>? dragonRes,
    Value<int>? rarity,
    Value<String>? slots,
    Value<int>? setId,
  }) {
    return ArmorPiecesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      slotType: slotType ?? this.slotType,
      baseDefense: baseDefense ?? this.baseDefense,
      fireRes: fireRes ?? this.fireRes,
      waterRes: waterRes ?? this.waterRes,
      thunderRes: thunderRes ?? this.thunderRes,
      iceRes: iceRes ?? this.iceRes,
      dragonRes: dragonRes ?? this.dragonRes,
      rarity: rarity ?? this.rarity,
      slots: slots ?? this.slots,
      setId: setId ?? this.setId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slotType.present) {
      map['slot_type'] = Variable<String>(
        $ArmorPiecesTable.$converterslotType.toSql(slotType.value),
      );
    }
    if (baseDefense.present) {
      map['base_defense'] = Variable<int>(baseDefense.value);
    }
    if (fireRes.present) {
      map['fire_res'] = Variable<int>(fireRes.value);
    }
    if (waterRes.present) {
      map['water_res'] = Variable<int>(waterRes.value);
    }
    if (thunderRes.present) {
      map['thunder_res'] = Variable<int>(thunderRes.value);
    }
    if (iceRes.present) {
      map['ice_res'] = Variable<int>(iceRes.value);
    }
    if (dragonRes.present) {
      map['dragon_res'] = Variable<int>(dragonRes.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<int>(rarity.value);
    }
    if (slots.present) {
      map['slots'] = Variable<String>(slots.value);
    }
    if (setId.present) {
      map['set_id'] = Variable<int>(setId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArmorPiecesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('slotType: $slotType, ')
          ..write('baseDefense: $baseDefense, ')
          ..write('fireRes: $fireRes, ')
          ..write('waterRes: $waterRes, ')
          ..write('thunderRes: $thunderRes, ')
          ..write('iceRes: $iceRes, ')
          ..write('dragonRes: $dragonRes, ')
          ..write('rarity: $rarity, ')
          ..write('slots: $slots, ')
          ..write('setId: $setId')
          ..write(')'))
        .toString();
  }
}

class $SkillsTable extends Skills with TableInfo<$SkillsTable, Skill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxLevelMeta = const VerificationMeta(
    'maxLevel',
  );
  @override
  late final GeneratedColumn<int> maxLevel = GeneratedColumn<int>(
    'max_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SkillCategory, String> type1 =
      GeneratedColumn<String>(
        'type1',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('armor'),
      ).withConverter<SkillCategory>($SkillsTable.$convertertype1);
  @override
  late final GeneratedColumnWithTypeConverter<SkillSubcategory, String> type2 =
      GeneratedColumn<String>(
        'type2',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('utility'),
      ).withConverter<SkillSubcategory>($SkillsTable.$convertertype2);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    name,
    maxLevel,
    type1,
    type2,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<Skill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('max_level')) {
      context.handle(
        _maxLevelMeta,
        maxLevel.isAcceptableOrUnknown(data['max_level']!, _maxLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_maxLevelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {slug},
  ];
  @override
  Skill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Skill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      maxLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_level'],
      )!,
      type1: $SkillsTable.$convertertype1.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type1'],
        )!,
      ),
      type2: $SkillsTable.$convertertype2.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type2'],
        )!,
      ),
    );
  }

  @override
  $SkillsTable createAlias(String alias) {
    return $SkillsTable(attachedDatabase, alias);
  }

  static TypeConverter<SkillCategory, String> $convertertype1 =
      const SkillCategoryConverter();
  static TypeConverter<SkillSubcategory, String> $convertertype2 =
      const SkillSubcategoryConverter();
}

class Skill extends DataClass implements Insertable<Skill> {
  final int id;
  final String slug;
  final String name;
  final int maxLevel;
  final SkillCategory type1;
  final SkillSubcategory type2;
  const Skill({
    required this.id,
    required this.slug,
    required this.name,
    required this.maxLevel,
    required this.type1,
    required this.type2,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['max_level'] = Variable<int>(maxLevel);
    {
      map['type1'] = Variable<String>(
        $SkillsTable.$convertertype1.toSql(type1),
      );
    }
    {
      map['type2'] = Variable<String>(
        $SkillsTable.$convertertype2.toSql(type2),
      );
    }
    return map;
  }

  SkillsCompanion toCompanion(bool nullToAbsent) {
    return SkillsCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      maxLevel: Value(maxLevel),
      type1: Value(type1),
      type2: Value(type2),
    );
  }

  factory Skill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Skill(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      maxLevel: serializer.fromJson<int>(json['maxLevel']),
      type1: serializer.fromJson<SkillCategory>(json['type1']),
      type2: serializer.fromJson<SkillSubcategory>(json['type2']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'maxLevel': serializer.toJson<int>(maxLevel),
      'type1': serializer.toJson<SkillCategory>(type1),
      'type2': serializer.toJson<SkillSubcategory>(type2),
    };
  }

  Skill copyWith({
    int? id,
    String? slug,
    String? name,
    int? maxLevel,
    SkillCategory? type1,
    SkillSubcategory? type2,
  }) => Skill(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    maxLevel: maxLevel ?? this.maxLevel,
    type1: type1 ?? this.type1,
    type2: type2 ?? this.type2,
  );
  Skill copyWithCompanion(SkillsCompanion data) {
    return Skill(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      maxLevel: data.maxLevel.present ? data.maxLevel.value : this.maxLevel,
      type1: data.type1.present ? data.type1.value : this.type1,
      type2: data.type2.present ? data.type2.value : this.type2,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Skill(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('maxLevel: $maxLevel, ')
          ..write('type1: $type1, ')
          ..write('type2: $type2')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, name, maxLevel, type1, type2);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Skill &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.maxLevel == this.maxLevel &&
          other.type1 == this.type1 &&
          other.type2 == this.type2);
}

class SkillsCompanion extends UpdateCompanion<Skill> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<int> maxLevel;
  final Value<SkillCategory> type1;
  final Value<SkillSubcategory> type2;
  const SkillsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.maxLevel = const Value.absent(),
    this.type1 = const Value.absent(),
    this.type2 = const Value.absent(),
  });
  SkillsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String name,
    required int maxLevel,
    this.type1 = const Value.absent(),
    this.type2 = const Value.absent(),
  }) : slug = Value(slug),
       name = Value(name),
       maxLevel = Value(maxLevel);
  static Insertable<Skill> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<int>? maxLevel,
    Expression<String>? type1,
    Expression<String>? type2,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (maxLevel != null) 'max_level': maxLevel,
      if (type1 != null) 'type1': type1,
      if (type2 != null) 'type2': type2,
    });
  }

  SkillsCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<int>? maxLevel,
    Value<SkillCategory>? type1,
    Value<SkillSubcategory>? type2,
  }) {
    return SkillsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      maxLevel: maxLevel ?? this.maxLevel,
      type1: type1 ?? this.type1,
      type2: type2 ?? this.type2,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (maxLevel.present) {
      map['max_level'] = Variable<int>(maxLevel.value);
    }
    if (type1.present) {
      map['type1'] = Variable<String>(
        $SkillsTable.$convertertype1.toSql(type1.value),
      );
    }
    if (type2.present) {
      map['type2'] = Variable<String>(
        $SkillsTable.$convertertype2.toSql(type2.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('maxLevel: $maxLevel, ')
          ..write('type1: $type1, ')
          ..write('type2: $type2')
          ..write(')'))
        .toString();
  }
}

class $ArmorSetSkillsTable extends ArmorSetSkills
    with TableInfo<$ArmorSetSkillsTable, ArmorSetSkill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArmorSetSkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<int> setId = GeneratedColumn<int>(
    'set_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES armor_sets (id)',
    ),
  );
  static const VerificationMeta _requiredPiecesMeta = const VerificationMeta(
    'requiredPieces',
  );
  @override
  late final GeneratedColumn<int> requiredPieces = GeneratedColumn<int>(
    'required_pieces',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<int> skillId = GeneratedColumn<int>(
    'skill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skills (id)',
    ),
  );
  static const VerificationMeta _skillLevelMeta = const VerificationMeta(
    'skillLevel',
  );
  @override
  late final GeneratedColumn<int> skillLevel = GeneratedColumn<int>(
    'skill_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SetSkillType, String>
  skillCategory = GeneratedColumn<String>(
    'skill_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SetSkillType>($ArmorSetSkillsTable.$converterskillCategory);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    setId,
    requiredPieces,
    skillId,
    skillLevel,
    skillCategory,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'armor_set_skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArmorSetSkill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('set_id')) {
      context.handle(
        _setIdMeta,
        setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta),
      );
    } else if (isInserting) {
      context.missing(_setIdMeta);
    }
    if (data.containsKey('required_pieces')) {
      context.handle(
        _requiredPiecesMeta,
        requiredPieces.isAcceptableOrUnknown(
          data['required_pieces']!,
          _requiredPiecesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredPiecesMeta);
    }
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skillIdMeta);
    }
    if (data.containsKey('skill_level')) {
      context.handle(
        _skillLevelMeta,
        skillLevel.isAcceptableOrUnknown(data['skill_level']!, _skillLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_skillLevelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArmorSetSkill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArmorSetSkill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      setId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_id'],
      )!,
      requiredPieces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}required_pieces'],
      )!,
      skillId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill_id'],
      )!,
      skillLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill_level'],
      )!,
      skillCategory: $ArmorSetSkillsTable.$converterskillCategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}skill_category'],
        )!,
      ),
    );
  }

  @override
  $ArmorSetSkillsTable createAlias(String alias) {
    return $ArmorSetSkillsTable(attachedDatabase, alias);
  }

  static TypeConverter<SetSkillType, String> $converterskillCategory =
      const SetSkillTypeConverter();
}

class ArmorSetSkill extends DataClass implements Insertable<ArmorSetSkill> {
  final int id;
  final int setId;
  final int requiredPieces;
  final int skillId;
  final int skillLevel;
  final SetSkillType skillCategory;
  const ArmorSetSkill({
    required this.id,
    required this.setId,
    required this.requiredPieces,
    required this.skillId,
    required this.skillLevel,
    required this.skillCategory,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['set_id'] = Variable<int>(setId);
    map['required_pieces'] = Variable<int>(requiredPieces);
    map['skill_id'] = Variable<int>(skillId);
    map['skill_level'] = Variable<int>(skillLevel);
    {
      map['skill_category'] = Variable<String>(
        $ArmorSetSkillsTable.$converterskillCategory.toSql(skillCategory),
      );
    }
    return map;
  }

  ArmorSetSkillsCompanion toCompanion(bool nullToAbsent) {
    return ArmorSetSkillsCompanion(
      id: Value(id),
      setId: Value(setId),
      requiredPieces: Value(requiredPieces),
      skillId: Value(skillId),
      skillLevel: Value(skillLevel),
      skillCategory: Value(skillCategory),
    );
  }

  factory ArmorSetSkill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArmorSetSkill(
      id: serializer.fromJson<int>(json['id']),
      setId: serializer.fromJson<int>(json['setId']),
      requiredPieces: serializer.fromJson<int>(json['requiredPieces']),
      skillId: serializer.fromJson<int>(json['skillId']),
      skillLevel: serializer.fromJson<int>(json['skillLevel']),
      skillCategory: serializer.fromJson<SetSkillType>(json['skillCategory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'setId': serializer.toJson<int>(setId),
      'requiredPieces': serializer.toJson<int>(requiredPieces),
      'skillId': serializer.toJson<int>(skillId),
      'skillLevel': serializer.toJson<int>(skillLevel),
      'skillCategory': serializer.toJson<SetSkillType>(skillCategory),
    };
  }

  ArmorSetSkill copyWith({
    int? id,
    int? setId,
    int? requiredPieces,
    int? skillId,
    int? skillLevel,
    SetSkillType? skillCategory,
  }) => ArmorSetSkill(
    id: id ?? this.id,
    setId: setId ?? this.setId,
    requiredPieces: requiredPieces ?? this.requiredPieces,
    skillId: skillId ?? this.skillId,
    skillLevel: skillLevel ?? this.skillLevel,
    skillCategory: skillCategory ?? this.skillCategory,
  );
  ArmorSetSkill copyWithCompanion(ArmorSetSkillsCompanion data) {
    return ArmorSetSkill(
      id: data.id.present ? data.id.value : this.id,
      setId: data.setId.present ? data.setId.value : this.setId,
      requiredPieces: data.requiredPieces.present
          ? data.requiredPieces.value
          : this.requiredPieces,
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      skillLevel: data.skillLevel.present
          ? data.skillLevel.value
          : this.skillLevel,
      skillCategory: data.skillCategory.present
          ? data.skillCategory.value
          : this.skillCategory,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArmorSetSkill(')
          ..write('id: $id, ')
          ..write('setId: $setId, ')
          ..write('requiredPieces: $requiredPieces, ')
          ..write('skillId: $skillId, ')
          ..write('skillLevel: $skillLevel, ')
          ..write('skillCategory: $skillCategory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    setId,
    requiredPieces,
    skillId,
    skillLevel,
    skillCategory,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArmorSetSkill &&
          other.id == this.id &&
          other.setId == this.setId &&
          other.requiredPieces == this.requiredPieces &&
          other.skillId == this.skillId &&
          other.skillLevel == this.skillLevel &&
          other.skillCategory == this.skillCategory);
}

class ArmorSetSkillsCompanion extends UpdateCompanion<ArmorSetSkill> {
  final Value<int> id;
  final Value<int> setId;
  final Value<int> requiredPieces;
  final Value<int> skillId;
  final Value<int> skillLevel;
  final Value<SetSkillType> skillCategory;
  const ArmorSetSkillsCompanion({
    this.id = const Value.absent(),
    this.setId = const Value.absent(),
    this.requiredPieces = const Value.absent(),
    this.skillId = const Value.absent(),
    this.skillLevel = const Value.absent(),
    this.skillCategory = const Value.absent(),
  });
  ArmorSetSkillsCompanion.insert({
    this.id = const Value.absent(),
    required int setId,
    required int requiredPieces,
    required int skillId,
    required int skillLevel,
    required SetSkillType skillCategory,
  }) : setId = Value(setId),
       requiredPieces = Value(requiredPieces),
       skillId = Value(skillId),
       skillLevel = Value(skillLevel),
       skillCategory = Value(skillCategory);
  static Insertable<ArmorSetSkill> custom({
    Expression<int>? id,
    Expression<int>? setId,
    Expression<int>? requiredPieces,
    Expression<int>? skillId,
    Expression<int>? skillLevel,
    Expression<String>? skillCategory,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (setId != null) 'set_id': setId,
      if (requiredPieces != null) 'required_pieces': requiredPieces,
      if (skillId != null) 'skill_id': skillId,
      if (skillLevel != null) 'skill_level': skillLevel,
      if (skillCategory != null) 'skill_category': skillCategory,
    });
  }

  ArmorSetSkillsCompanion copyWith({
    Value<int>? id,
    Value<int>? setId,
    Value<int>? requiredPieces,
    Value<int>? skillId,
    Value<int>? skillLevel,
    Value<SetSkillType>? skillCategory,
  }) {
    return ArmorSetSkillsCompanion(
      id: id ?? this.id,
      setId: setId ?? this.setId,
      requiredPieces: requiredPieces ?? this.requiredPieces,
      skillId: skillId ?? this.skillId,
      skillLevel: skillLevel ?? this.skillLevel,
      skillCategory: skillCategory ?? this.skillCategory,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (setId.present) {
      map['set_id'] = Variable<int>(setId.value);
    }
    if (requiredPieces.present) {
      map['required_pieces'] = Variable<int>(requiredPieces.value);
    }
    if (skillId.present) {
      map['skill_id'] = Variable<int>(skillId.value);
    }
    if (skillLevel.present) {
      map['skill_level'] = Variable<int>(skillLevel.value);
    }
    if (skillCategory.present) {
      map['skill_category'] = Variable<String>(
        $ArmorSetSkillsTable.$converterskillCategory.toSql(skillCategory.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArmorSetSkillsCompanion(')
          ..write('id: $id, ')
          ..write('setId: $setId, ')
          ..write('requiredPieces: $requiredPieces, ')
          ..write('skillId: $skillId, ')
          ..write('skillLevel: $skillLevel, ')
          ..write('skillCategory: $skillCategory')
          ..write(')'))
        .toString();
  }
}

class $JewelsTable extends Jewels with TableInfo<$JewelsTable, Jewel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JewelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<int> rarity = GeneratedColumn<int>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _slotSizeMeta = const VerificationMeta(
    'slotSize',
  );
  @override
  late final GeneratedColumn<int> slotSize = GeneratedColumn<int>(
    'slot_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<int> skillId = GeneratedColumn<int>(
    'skill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skills (id)',
    ),
  );
  static const VerificationMeta _skillLevelMeta = const VerificationMeta(
    'skillLevel',
  );
  @override
  late final GeneratedColumn<int> skillLevel = GeneratedColumn<int>(
    'skill_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    name,
    rarity,
    slotSize,
    skillId,
    skillLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jewels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Jewel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    }
    if (data.containsKey('slot_size')) {
      context.handle(
        _slotSizeMeta,
        slotSize.isAcceptableOrUnknown(data['slot_size']!, _slotSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_slotSizeMeta);
    }
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skillIdMeta);
    }
    if (data.containsKey('skill_level')) {
      context.handle(
        _skillLevelMeta,
        skillLevel.isAcceptableOrUnknown(data['skill_level']!, _skillLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_skillLevelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {slug},
  ];
  @override
  Jewel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Jewel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      rarity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rarity'],
      )!,
      slotSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot_size'],
      )!,
      skillId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill_id'],
      )!,
      skillLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill_level'],
      )!,
    );
  }

  @override
  $JewelsTable createAlias(String alias) {
    return $JewelsTable(attachedDatabase, alias);
  }
}

class Jewel extends DataClass implements Insertable<Jewel> {
  final int id;
  final String slug;
  final String name;
  final int rarity;
  final int slotSize;
  final int skillId;
  final int skillLevel;
  const Jewel({
    required this.id,
    required this.slug,
    required this.name,
    required this.rarity,
    required this.slotSize,
    required this.skillId,
    required this.skillLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['rarity'] = Variable<int>(rarity);
    map['slot_size'] = Variable<int>(slotSize);
    map['skill_id'] = Variable<int>(skillId);
    map['skill_level'] = Variable<int>(skillLevel);
    return map;
  }

  JewelsCompanion toCompanion(bool nullToAbsent) {
    return JewelsCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      rarity: Value(rarity),
      slotSize: Value(slotSize),
      skillId: Value(skillId),
      skillLevel: Value(skillLevel),
    );
  }

  factory Jewel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Jewel(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      rarity: serializer.fromJson<int>(json['rarity']),
      slotSize: serializer.fromJson<int>(json['slotSize']),
      skillId: serializer.fromJson<int>(json['skillId']),
      skillLevel: serializer.fromJson<int>(json['skillLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'rarity': serializer.toJson<int>(rarity),
      'slotSize': serializer.toJson<int>(slotSize),
      'skillId': serializer.toJson<int>(skillId),
      'skillLevel': serializer.toJson<int>(skillLevel),
    };
  }

  Jewel copyWith({
    int? id,
    String? slug,
    String? name,
    int? rarity,
    int? slotSize,
    int? skillId,
    int? skillLevel,
  }) => Jewel(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    rarity: rarity ?? this.rarity,
    slotSize: slotSize ?? this.slotSize,
    skillId: skillId ?? this.skillId,
    skillLevel: skillLevel ?? this.skillLevel,
  );
  Jewel copyWithCompanion(JewelsCompanion data) {
    return Jewel(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      slotSize: data.slotSize.present ? data.slotSize.value : this.slotSize,
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      skillLevel: data.skillLevel.present
          ? data.skillLevel.value
          : this.skillLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Jewel(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('rarity: $rarity, ')
          ..write('slotSize: $slotSize, ')
          ..write('skillId: $skillId, ')
          ..write('skillLevel: $skillLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, slug, name, rarity, slotSize, skillId, skillLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Jewel &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.rarity == this.rarity &&
          other.slotSize == this.slotSize &&
          other.skillId == this.skillId &&
          other.skillLevel == this.skillLevel);
}

class JewelsCompanion extends UpdateCompanion<Jewel> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<int> rarity;
  final Value<int> slotSize;
  final Value<int> skillId;
  final Value<int> skillLevel;
  const JewelsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.rarity = const Value.absent(),
    this.slotSize = const Value.absent(),
    this.skillId = const Value.absent(),
    this.skillLevel = const Value.absent(),
  });
  JewelsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String name,
    this.rarity = const Value.absent(),
    required int slotSize,
    required int skillId,
    required int skillLevel,
  }) : slug = Value(slug),
       name = Value(name),
       slotSize = Value(slotSize),
       skillId = Value(skillId),
       skillLevel = Value(skillLevel);
  static Insertable<Jewel> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<int>? rarity,
    Expression<int>? slotSize,
    Expression<int>? skillId,
    Expression<int>? skillLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (rarity != null) 'rarity': rarity,
      if (slotSize != null) 'slot_size': slotSize,
      if (skillId != null) 'skill_id': skillId,
      if (skillLevel != null) 'skill_level': skillLevel,
    });
  }

  JewelsCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<int>? rarity,
    Value<int>? slotSize,
    Value<int>? skillId,
    Value<int>? skillLevel,
  }) {
    return JewelsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      rarity: rarity ?? this.rarity,
      slotSize: slotSize ?? this.slotSize,
      skillId: skillId ?? this.skillId,
      skillLevel: skillLevel ?? this.skillLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<int>(rarity.value);
    }
    if (slotSize.present) {
      map['slot_size'] = Variable<int>(slotSize.value);
    }
    if (skillId.present) {
      map['skill_id'] = Variable<int>(skillId.value);
    }
    if (skillLevel.present) {
      map['skill_level'] = Variable<int>(skillLevel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JewelsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('rarity: $rarity, ')
          ..write('slotSize: $slotSize, ')
          ..write('skillId: $skillId, ')
          ..write('skillLevel: $skillLevel')
          ..write(')'))
        .toString();
  }
}

class $SkillLevelsTable extends SkillLevels
    with TableInfo<$SkillLevelsTable, SkillLevel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillLevelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<int> skillId = GeneratedColumn<int>(
    'skill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skills (id)',
    ),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _piecesRequiredMeta = const VerificationMeta(
    'piecesRequired',
  );
  @override
  late final GeneratedColumn<int> piecesRequired = GeneratedColumn<int>(
    'pieces_required',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bonus1ValueMeta = const VerificationMeta(
    'bonus1Value',
  );
  @override
  late final GeneratedColumn<double> bonus1Value = GeneratedColumn<double>(
    'bonus1_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bonus1TypeMeta = const VerificationMeta(
    'bonus1Type',
  );
  @override
  late final GeneratedColumn<String> bonus1Type = GeneratedColumn<String>(
    'bonus1_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bonus2ValueMeta = const VerificationMeta(
    'bonus2Value',
  );
  @override
  late final GeneratedColumn<double> bonus2Value = GeneratedColumn<double>(
    'bonus2_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bonus2TypeMeta = const VerificationMeta(
    'bonus2Type',
  );
  @override
  late final GeneratedColumn<String> bonus2Type = GeneratedColumn<String>(
    'bonus2_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bonus3ValueMeta = const VerificationMeta(
    'bonus3Value',
  );
  @override
  late final GeneratedColumn<double> bonus3Value = GeneratedColumn<double>(
    'bonus3_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bonus3TypeMeta = const VerificationMeta(
    'bonus3Type',
  );
  @override
  late final GeneratedColumn<String> bonus3Type = GeneratedColumn<String>(
    'bonus3_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSMeta = const VerificationMeta(
    'durationS',
  );
  @override
  late final GeneratedColumn<double> durationS = GeneratedColumn<double>(
    'duration_s',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cooldownSMeta = const VerificationMeta(
    'cooldownS',
  );
  @override
  late final GeneratedColumn<double> cooldownS = GeneratedColumn<double>(
    'cooldown_s',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    skillId,
    level,
    piecesRequired,
    bonus1Value,
    bonus1Type,
    bonus2Value,
    bonus2Type,
    bonus3Value,
    bonus3Type,
    durationS,
    cooldownS,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_levels';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkillLevel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skillIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('pieces_required')) {
      context.handle(
        _piecesRequiredMeta,
        piecesRequired.isAcceptableOrUnknown(
          data['pieces_required']!,
          _piecesRequiredMeta,
        ),
      );
    }
    if (data.containsKey('bonus1_value')) {
      context.handle(
        _bonus1ValueMeta,
        bonus1Value.isAcceptableOrUnknown(
          data['bonus1_value']!,
          _bonus1ValueMeta,
        ),
      );
    }
    if (data.containsKey('bonus1_type')) {
      context.handle(
        _bonus1TypeMeta,
        bonus1Type.isAcceptableOrUnknown(data['bonus1_type']!, _bonus1TypeMeta),
      );
    }
    if (data.containsKey('bonus2_value')) {
      context.handle(
        _bonus2ValueMeta,
        bonus2Value.isAcceptableOrUnknown(
          data['bonus2_value']!,
          _bonus2ValueMeta,
        ),
      );
    }
    if (data.containsKey('bonus2_type')) {
      context.handle(
        _bonus2TypeMeta,
        bonus2Type.isAcceptableOrUnknown(data['bonus2_type']!, _bonus2TypeMeta),
      );
    }
    if (data.containsKey('bonus3_value')) {
      context.handle(
        _bonus3ValueMeta,
        bonus3Value.isAcceptableOrUnknown(
          data['bonus3_value']!,
          _bonus3ValueMeta,
        ),
      );
    }
    if (data.containsKey('bonus3_type')) {
      context.handle(
        _bonus3TypeMeta,
        bonus3Type.isAcceptableOrUnknown(data['bonus3_type']!, _bonus3TypeMeta),
      );
    }
    if (data.containsKey('duration_s')) {
      context.handle(
        _durationSMeta,
        durationS.isAcceptableOrUnknown(data['duration_s']!, _durationSMeta),
      );
    }
    if (data.containsKey('cooldown_s')) {
      context.handle(
        _cooldownSMeta,
        cooldownS.isAcceptableOrUnknown(data['cooldown_s']!, _cooldownSMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkillLevel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillLevel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      skillId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill_id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      piecesRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pieces_required'],
      ),
      bonus1Value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bonus1_value'],
      ),
      bonus1Type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bonus1_type'],
      ),
      bonus2Value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bonus2_value'],
      ),
      bonus2Type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bonus2_type'],
      ),
      bonus3Value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bonus3_value'],
      ),
      bonus3Type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bonus3_type'],
      ),
      durationS: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration_s'],
      ),
      cooldownS: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cooldown_s'],
      ),
    );
  }

  @override
  $SkillLevelsTable createAlias(String alias) {
    return $SkillLevelsTable(attachedDatabase, alias);
  }
}

class SkillLevel extends DataClass implements Insertable<SkillLevel> {
  final int id;
  final int skillId;
  final int level;
  final int? piecesRequired;
  final double? bonus1Value;
  final String? bonus1Type;
  final double? bonus2Value;
  final String? bonus2Type;
  final double? bonus3Value;
  final String? bonus3Type;
  final double? durationS;
  final double? cooldownS;
  const SkillLevel({
    required this.id,
    required this.skillId,
    required this.level,
    this.piecesRequired,
    this.bonus1Value,
    this.bonus1Type,
    this.bonus2Value,
    this.bonus2Type,
    this.bonus3Value,
    this.bonus3Type,
    this.durationS,
    this.cooldownS,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['skill_id'] = Variable<int>(skillId);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || piecesRequired != null) {
      map['pieces_required'] = Variable<int>(piecesRequired);
    }
    if (!nullToAbsent || bonus1Value != null) {
      map['bonus1_value'] = Variable<double>(bonus1Value);
    }
    if (!nullToAbsent || bonus1Type != null) {
      map['bonus1_type'] = Variable<String>(bonus1Type);
    }
    if (!nullToAbsent || bonus2Value != null) {
      map['bonus2_value'] = Variable<double>(bonus2Value);
    }
    if (!nullToAbsent || bonus2Type != null) {
      map['bonus2_type'] = Variable<String>(bonus2Type);
    }
    if (!nullToAbsent || bonus3Value != null) {
      map['bonus3_value'] = Variable<double>(bonus3Value);
    }
    if (!nullToAbsent || bonus3Type != null) {
      map['bonus3_type'] = Variable<String>(bonus3Type);
    }
    if (!nullToAbsent || durationS != null) {
      map['duration_s'] = Variable<double>(durationS);
    }
    if (!nullToAbsent || cooldownS != null) {
      map['cooldown_s'] = Variable<double>(cooldownS);
    }
    return map;
  }

  SkillLevelsCompanion toCompanion(bool nullToAbsent) {
    return SkillLevelsCompanion(
      id: Value(id),
      skillId: Value(skillId),
      level: Value(level),
      piecesRequired: piecesRequired == null && nullToAbsent
          ? const Value.absent()
          : Value(piecesRequired),
      bonus1Value: bonus1Value == null && nullToAbsent
          ? const Value.absent()
          : Value(bonus1Value),
      bonus1Type: bonus1Type == null && nullToAbsent
          ? const Value.absent()
          : Value(bonus1Type),
      bonus2Value: bonus2Value == null && nullToAbsent
          ? const Value.absent()
          : Value(bonus2Value),
      bonus2Type: bonus2Type == null && nullToAbsent
          ? const Value.absent()
          : Value(bonus2Type),
      bonus3Value: bonus3Value == null && nullToAbsent
          ? const Value.absent()
          : Value(bonus3Value),
      bonus3Type: bonus3Type == null && nullToAbsent
          ? const Value.absent()
          : Value(bonus3Type),
      durationS: durationS == null && nullToAbsent
          ? const Value.absent()
          : Value(durationS),
      cooldownS: cooldownS == null && nullToAbsent
          ? const Value.absent()
          : Value(cooldownS),
    );
  }

  factory SkillLevel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillLevel(
      id: serializer.fromJson<int>(json['id']),
      skillId: serializer.fromJson<int>(json['skillId']),
      level: serializer.fromJson<int>(json['level']),
      piecesRequired: serializer.fromJson<int?>(json['piecesRequired']),
      bonus1Value: serializer.fromJson<double?>(json['bonus1Value']),
      bonus1Type: serializer.fromJson<String?>(json['bonus1Type']),
      bonus2Value: serializer.fromJson<double?>(json['bonus2Value']),
      bonus2Type: serializer.fromJson<String?>(json['bonus2Type']),
      bonus3Value: serializer.fromJson<double?>(json['bonus3Value']),
      bonus3Type: serializer.fromJson<String?>(json['bonus3Type']),
      durationS: serializer.fromJson<double?>(json['durationS']),
      cooldownS: serializer.fromJson<double?>(json['cooldownS']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'skillId': serializer.toJson<int>(skillId),
      'level': serializer.toJson<int>(level),
      'piecesRequired': serializer.toJson<int?>(piecesRequired),
      'bonus1Value': serializer.toJson<double?>(bonus1Value),
      'bonus1Type': serializer.toJson<String?>(bonus1Type),
      'bonus2Value': serializer.toJson<double?>(bonus2Value),
      'bonus2Type': serializer.toJson<String?>(bonus2Type),
      'bonus3Value': serializer.toJson<double?>(bonus3Value),
      'bonus3Type': serializer.toJson<String?>(bonus3Type),
      'durationS': serializer.toJson<double?>(durationS),
      'cooldownS': serializer.toJson<double?>(cooldownS),
    };
  }

  SkillLevel copyWith({
    int? id,
    int? skillId,
    int? level,
    Value<int?> piecesRequired = const Value.absent(),
    Value<double?> bonus1Value = const Value.absent(),
    Value<String?> bonus1Type = const Value.absent(),
    Value<double?> bonus2Value = const Value.absent(),
    Value<String?> bonus2Type = const Value.absent(),
    Value<double?> bonus3Value = const Value.absent(),
    Value<String?> bonus3Type = const Value.absent(),
    Value<double?> durationS = const Value.absent(),
    Value<double?> cooldownS = const Value.absent(),
  }) => SkillLevel(
    id: id ?? this.id,
    skillId: skillId ?? this.skillId,
    level: level ?? this.level,
    piecesRequired: piecesRequired.present
        ? piecesRequired.value
        : this.piecesRequired,
    bonus1Value: bonus1Value.present ? bonus1Value.value : this.bonus1Value,
    bonus1Type: bonus1Type.present ? bonus1Type.value : this.bonus1Type,
    bonus2Value: bonus2Value.present ? bonus2Value.value : this.bonus2Value,
    bonus2Type: bonus2Type.present ? bonus2Type.value : this.bonus2Type,
    bonus3Value: bonus3Value.present ? bonus3Value.value : this.bonus3Value,
    bonus3Type: bonus3Type.present ? bonus3Type.value : this.bonus3Type,
    durationS: durationS.present ? durationS.value : this.durationS,
    cooldownS: cooldownS.present ? cooldownS.value : this.cooldownS,
  );
  SkillLevel copyWithCompanion(SkillLevelsCompanion data) {
    return SkillLevel(
      id: data.id.present ? data.id.value : this.id,
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      level: data.level.present ? data.level.value : this.level,
      piecesRequired: data.piecesRequired.present
          ? data.piecesRequired.value
          : this.piecesRequired,
      bonus1Value: data.bonus1Value.present
          ? data.bonus1Value.value
          : this.bonus1Value,
      bonus1Type: data.bonus1Type.present
          ? data.bonus1Type.value
          : this.bonus1Type,
      bonus2Value: data.bonus2Value.present
          ? data.bonus2Value.value
          : this.bonus2Value,
      bonus2Type: data.bonus2Type.present
          ? data.bonus2Type.value
          : this.bonus2Type,
      bonus3Value: data.bonus3Value.present
          ? data.bonus3Value.value
          : this.bonus3Value,
      bonus3Type: data.bonus3Type.present
          ? data.bonus3Type.value
          : this.bonus3Type,
      durationS: data.durationS.present ? data.durationS.value : this.durationS,
      cooldownS: data.cooldownS.present ? data.cooldownS.value : this.cooldownS,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillLevel(')
          ..write('id: $id, ')
          ..write('skillId: $skillId, ')
          ..write('level: $level, ')
          ..write('piecesRequired: $piecesRequired, ')
          ..write('bonus1Value: $bonus1Value, ')
          ..write('bonus1Type: $bonus1Type, ')
          ..write('bonus2Value: $bonus2Value, ')
          ..write('bonus2Type: $bonus2Type, ')
          ..write('bonus3Value: $bonus3Value, ')
          ..write('bonus3Type: $bonus3Type, ')
          ..write('durationS: $durationS, ')
          ..write('cooldownS: $cooldownS')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    skillId,
    level,
    piecesRequired,
    bonus1Value,
    bonus1Type,
    bonus2Value,
    bonus2Type,
    bonus3Value,
    bonus3Type,
    durationS,
    cooldownS,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillLevel &&
          other.id == this.id &&
          other.skillId == this.skillId &&
          other.level == this.level &&
          other.piecesRequired == this.piecesRequired &&
          other.bonus1Value == this.bonus1Value &&
          other.bonus1Type == this.bonus1Type &&
          other.bonus2Value == this.bonus2Value &&
          other.bonus2Type == this.bonus2Type &&
          other.bonus3Value == this.bonus3Value &&
          other.bonus3Type == this.bonus3Type &&
          other.durationS == this.durationS &&
          other.cooldownS == this.cooldownS);
}

class SkillLevelsCompanion extends UpdateCompanion<SkillLevel> {
  final Value<int> id;
  final Value<int> skillId;
  final Value<int> level;
  final Value<int?> piecesRequired;
  final Value<double?> bonus1Value;
  final Value<String?> bonus1Type;
  final Value<double?> bonus2Value;
  final Value<String?> bonus2Type;
  final Value<double?> bonus3Value;
  final Value<String?> bonus3Type;
  final Value<double?> durationS;
  final Value<double?> cooldownS;
  const SkillLevelsCompanion({
    this.id = const Value.absent(),
    this.skillId = const Value.absent(),
    this.level = const Value.absent(),
    this.piecesRequired = const Value.absent(),
    this.bonus1Value = const Value.absent(),
    this.bonus1Type = const Value.absent(),
    this.bonus2Value = const Value.absent(),
    this.bonus2Type = const Value.absent(),
    this.bonus3Value = const Value.absent(),
    this.bonus3Type = const Value.absent(),
    this.durationS = const Value.absent(),
    this.cooldownS = const Value.absent(),
  });
  SkillLevelsCompanion.insert({
    this.id = const Value.absent(),
    required int skillId,
    required int level,
    this.piecesRequired = const Value.absent(),
    this.bonus1Value = const Value.absent(),
    this.bonus1Type = const Value.absent(),
    this.bonus2Value = const Value.absent(),
    this.bonus2Type = const Value.absent(),
    this.bonus3Value = const Value.absent(),
    this.bonus3Type = const Value.absent(),
    this.durationS = const Value.absent(),
    this.cooldownS = const Value.absent(),
  }) : skillId = Value(skillId),
       level = Value(level);
  static Insertable<SkillLevel> custom({
    Expression<int>? id,
    Expression<int>? skillId,
    Expression<int>? level,
    Expression<int>? piecesRequired,
    Expression<double>? bonus1Value,
    Expression<String>? bonus1Type,
    Expression<double>? bonus2Value,
    Expression<String>? bonus2Type,
    Expression<double>? bonus3Value,
    Expression<String>? bonus3Type,
    Expression<double>? durationS,
    Expression<double>? cooldownS,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (skillId != null) 'skill_id': skillId,
      if (level != null) 'level': level,
      if (piecesRequired != null) 'pieces_required': piecesRequired,
      if (bonus1Value != null) 'bonus1_value': bonus1Value,
      if (bonus1Type != null) 'bonus1_type': bonus1Type,
      if (bonus2Value != null) 'bonus2_value': bonus2Value,
      if (bonus2Type != null) 'bonus2_type': bonus2Type,
      if (bonus3Value != null) 'bonus3_value': bonus3Value,
      if (bonus3Type != null) 'bonus3_type': bonus3Type,
      if (durationS != null) 'duration_s': durationS,
      if (cooldownS != null) 'cooldown_s': cooldownS,
    });
  }

  SkillLevelsCompanion copyWith({
    Value<int>? id,
    Value<int>? skillId,
    Value<int>? level,
    Value<int?>? piecesRequired,
    Value<double?>? bonus1Value,
    Value<String?>? bonus1Type,
    Value<double?>? bonus2Value,
    Value<String?>? bonus2Type,
    Value<double?>? bonus3Value,
    Value<String?>? bonus3Type,
    Value<double?>? durationS,
    Value<double?>? cooldownS,
  }) {
    return SkillLevelsCompanion(
      id: id ?? this.id,
      skillId: skillId ?? this.skillId,
      level: level ?? this.level,
      piecesRequired: piecesRequired ?? this.piecesRequired,
      bonus1Value: bonus1Value ?? this.bonus1Value,
      bonus1Type: bonus1Type ?? this.bonus1Type,
      bonus2Value: bonus2Value ?? this.bonus2Value,
      bonus2Type: bonus2Type ?? this.bonus2Type,
      bonus3Value: bonus3Value ?? this.bonus3Value,
      bonus3Type: bonus3Type ?? this.bonus3Type,
      durationS: durationS ?? this.durationS,
      cooldownS: cooldownS ?? this.cooldownS,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (skillId.present) {
      map['skill_id'] = Variable<int>(skillId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (piecesRequired.present) {
      map['pieces_required'] = Variable<int>(piecesRequired.value);
    }
    if (bonus1Value.present) {
      map['bonus1_value'] = Variable<double>(bonus1Value.value);
    }
    if (bonus1Type.present) {
      map['bonus1_type'] = Variable<String>(bonus1Type.value);
    }
    if (bonus2Value.present) {
      map['bonus2_value'] = Variable<double>(bonus2Value.value);
    }
    if (bonus2Type.present) {
      map['bonus2_type'] = Variable<String>(bonus2Type.value);
    }
    if (bonus3Value.present) {
      map['bonus3_value'] = Variable<double>(bonus3Value.value);
    }
    if (bonus3Type.present) {
      map['bonus3_type'] = Variable<String>(bonus3Type.value);
    }
    if (durationS.present) {
      map['duration_s'] = Variable<double>(durationS.value);
    }
    if (cooldownS.present) {
      map['cooldown_s'] = Variable<double>(cooldownS.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillLevelsCompanion(')
          ..write('id: $id, ')
          ..write('skillId: $skillId, ')
          ..write('level: $level, ')
          ..write('piecesRequired: $piecesRequired, ')
          ..write('bonus1Value: $bonus1Value, ')
          ..write('bonus1Type: $bonus1Type, ')
          ..write('bonus2Value: $bonus2Value, ')
          ..write('bonus2Type: $bonus2Type, ')
          ..write('bonus3Value: $bonus3Value, ')
          ..write('bonus3Type: $bonus3Type, ')
          ..write('durationS: $durationS, ')
          ..write('cooldownS: $cooldownS')
          ..write(')'))
        .toString();
  }
}

class $TalismansTable extends Talismans
    with TableInfo<$TalismansTable, Talisman> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TalismansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skill1IdMeta = const VerificationMeta(
    'skill1Id',
  );
  @override
  late final GeneratedColumn<int> skill1Id = GeneratedColumn<int>(
    'skill1_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skills (id)',
    ),
  );
  static const VerificationMeta _skill1LevelMeta = const VerificationMeta(
    'skill1Level',
  );
  @override
  late final GeneratedColumn<int> skill1Level = GeneratedColumn<int>(
    'skill1_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skill2IdMeta = const VerificationMeta(
    'skill2Id',
  );
  @override
  late final GeneratedColumn<int> skill2Id = GeneratedColumn<int>(
    'skill2_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skills (id)',
    ),
  );
  static const VerificationMeta _skill2LevelMeta = const VerificationMeta(
    'skill2Level',
  );
  @override
  late final GeneratedColumn<int> skill2Level = GeneratedColumn<int>(
    'skill2_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slotsMeta = const VerificationMeta('slots');
  @override
  late final GeneratedColumn<String> slots = GeneratedColumn<String>(
    'slots',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    skill1Id,
    skill1Level,
    skill2Id,
    skill2Level,
    slots,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'talismans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Talisman> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('skill1_id')) {
      context.handle(
        _skill1IdMeta,
        skill1Id.isAcceptableOrUnknown(data['skill1_id']!, _skill1IdMeta),
      );
    }
    if (data.containsKey('skill1_level')) {
      context.handle(
        _skill1LevelMeta,
        skill1Level.isAcceptableOrUnknown(
          data['skill1_level']!,
          _skill1LevelMeta,
        ),
      );
    }
    if (data.containsKey('skill2_id')) {
      context.handle(
        _skill2IdMeta,
        skill2Id.isAcceptableOrUnknown(data['skill2_id']!, _skill2IdMeta),
      );
    }
    if (data.containsKey('skill2_level')) {
      context.handle(
        _skill2LevelMeta,
        skill2Level.isAcceptableOrUnknown(
          data['skill2_level']!,
          _skill2LevelMeta,
        ),
      );
    }
    if (data.containsKey('slots')) {
      context.handle(
        _slotsMeta,
        slots.isAcceptableOrUnknown(data['slots']!, _slotsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Talisman map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Talisman(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      skill1Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill1_id'],
      ),
      skill1Level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill1_level'],
      ),
      skill2Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill2_id'],
      ),
      skill2Level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skill2_level'],
      ),
      slots: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slots'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TalismansTable createAlias(String alias) {
    return $TalismansTable(attachedDatabase, alias);
  }
}

class Talisman extends DataClass implements Insertable<Talisman> {
  final int id;
  final String name;
  final int? skill1Id;
  final int? skill1Level;
  final int? skill2Id;
  final int? skill2Level;
  final String slots;
  final int createdAt;
  const Talisman({
    required this.id,
    required this.name,
    this.skill1Id,
    this.skill1Level,
    this.skill2Id,
    this.skill2Level,
    required this.slots,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || skill1Id != null) {
      map['skill1_id'] = Variable<int>(skill1Id);
    }
    if (!nullToAbsent || skill1Level != null) {
      map['skill1_level'] = Variable<int>(skill1Level);
    }
    if (!nullToAbsent || skill2Id != null) {
      map['skill2_id'] = Variable<int>(skill2Id);
    }
    if (!nullToAbsent || skill2Level != null) {
      map['skill2_level'] = Variable<int>(skill2Level);
    }
    map['slots'] = Variable<String>(slots);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TalismansCompanion toCompanion(bool nullToAbsent) {
    return TalismansCompanion(
      id: Value(id),
      name: Value(name),
      skill1Id: skill1Id == null && nullToAbsent
          ? const Value.absent()
          : Value(skill1Id),
      skill1Level: skill1Level == null && nullToAbsent
          ? const Value.absent()
          : Value(skill1Level),
      skill2Id: skill2Id == null && nullToAbsent
          ? const Value.absent()
          : Value(skill2Id),
      skill2Level: skill2Level == null && nullToAbsent
          ? const Value.absent()
          : Value(skill2Level),
      slots: Value(slots),
      createdAt: Value(createdAt),
    );
  }

  factory Talisman.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Talisman(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      skill1Id: serializer.fromJson<int?>(json['skill1Id']),
      skill1Level: serializer.fromJson<int?>(json['skill1Level']),
      skill2Id: serializer.fromJson<int?>(json['skill2Id']),
      skill2Level: serializer.fromJson<int?>(json['skill2Level']),
      slots: serializer.fromJson<String>(json['slots']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'skill1Id': serializer.toJson<int?>(skill1Id),
      'skill1Level': serializer.toJson<int?>(skill1Level),
      'skill2Id': serializer.toJson<int?>(skill2Id),
      'skill2Level': serializer.toJson<int?>(skill2Level),
      'slots': serializer.toJson<String>(slots),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Talisman copyWith({
    int? id,
    String? name,
    Value<int?> skill1Id = const Value.absent(),
    Value<int?> skill1Level = const Value.absent(),
    Value<int?> skill2Id = const Value.absent(),
    Value<int?> skill2Level = const Value.absent(),
    String? slots,
    int? createdAt,
  }) => Talisman(
    id: id ?? this.id,
    name: name ?? this.name,
    skill1Id: skill1Id.present ? skill1Id.value : this.skill1Id,
    skill1Level: skill1Level.present ? skill1Level.value : this.skill1Level,
    skill2Id: skill2Id.present ? skill2Id.value : this.skill2Id,
    skill2Level: skill2Level.present ? skill2Level.value : this.skill2Level,
    slots: slots ?? this.slots,
    createdAt: createdAt ?? this.createdAt,
  );
  Talisman copyWithCompanion(TalismansCompanion data) {
    return Talisman(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      skill1Id: data.skill1Id.present ? data.skill1Id.value : this.skill1Id,
      skill1Level: data.skill1Level.present
          ? data.skill1Level.value
          : this.skill1Level,
      skill2Id: data.skill2Id.present ? data.skill2Id.value : this.skill2Id,
      skill2Level: data.skill2Level.present
          ? data.skill2Level.value
          : this.skill2Level,
      slots: data.slots.present ? data.slots.value : this.slots,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Talisman(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('skill1Id: $skill1Id, ')
          ..write('skill1Level: $skill1Level, ')
          ..write('skill2Id: $skill2Id, ')
          ..write('skill2Level: $skill2Level, ')
          ..write('slots: $slots, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    skill1Id,
    skill1Level,
    skill2Id,
    skill2Level,
    slots,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Talisman &&
          other.id == this.id &&
          other.name == this.name &&
          other.skill1Id == this.skill1Id &&
          other.skill1Level == this.skill1Level &&
          other.skill2Id == this.skill2Id &&
          other.skill2Level == this.skill2Level &&
          other.slots == this.slots &&
          other.createdAt == this.createdAt);
}

class TalismansCompanion extends UpdateCompanion<Talisman> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> skill1Id;
  final Value<int?> skill1Level;
  final Value<int?> skill2Id;
  final Value<int?> skill2Level;
  final Value<String> slots;
  final Value<int> createdAt;
  const TalismansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.skill1Id = const Value.absent(),
    this.skill1Level = const Value.absent(),
    this.skill2Id = const Value.absent(),
    this.skill2Level = const Value.absent(),
    this.slots = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TalismansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.skill1Id = const Value.absent(),
    this.skill1Level = const Value.absent(),
    this.skill2Id = const Value.absent(),
    this.skill2Level = const Value.absent(),
    this.slots = const Value.absent(),
    required int createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Talisman> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? skill1Id,
    Expression<int>? skill1Level,
    Expression<int>? skill2Id,
    Expression<int>? skill2Level,
    Expression<String>? slots,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (skill1Id != null) 'skill1_id': skill1Id,
      if (skill1Level != null) 'skill1_level': skill1Level,
      if (skill2Id != null) 'skill2_id': skill2Id,
      if (skill2Level != null) 'skill2_level': skill2Level,
      if (slots != null) 'slots': slots,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TalismansCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? skill1Id,
    Value<int?>? skill1Level,
    Value<int?>? skill2Id,
    Value<int?>? skill2Level,
    Value<String>? slots,
    Value<int>? createdAt,
  }) {
    return TalismansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      skill1Id: skill1Id ?? this.skill1Id,
      skill1Level: skill1Level ?? this.skill1Level,
      skill2Id: skill2Id ?? this.skill2Id,
      skill2Level: skill2Level ?? this.skill2Level,
      slots: slots ?? this.slots,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (skill1Id.present) {
      map['skill1_id'] = Variable<int>(skill1Id.value);
    }
    if (skill1Level.present) {
      map['skill1_level'] = Variable<int>(skill1Level.value);
    }
    if (skill2Id.present) {
      map['skill2_id'] = Variable<int>(skill2Id.value);
    }
    if (skill2Level.present) {
      map['skill2_level'] = Variable<int>(skill2Level.value);
    }
    if (slots.present) {
      map['slots'] = Variable<String>(slots.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TalismansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('skill1Id: $skill1Id, ')
          ..write('skill1Level: $skill1Level, ')
          ..write('skill2Id: $skill2Id, ')
          ..write('skill2Level: $skill2Level, ')
          ..write('slots: $slots, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BuildsTable extends Builds with TableInfo<$BuildsTable, Build> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weaponIdMeta = const VerificationMeta(
    'weaponId',
  );
  @override
  late final GeneratedColumn<int> weaponId = GeneratedColumn<int>(
    'weapon_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weapons (id)',
    ),
  );
  static const VerificationMeta _headIdMeta = const VerificationMeta('headId');
  @override
  late final GeneratedColumn<int> headId = GeneratedColumn<int>(
    'head_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES armor_pieces (id)',
    ),
  );
  static const VerificationMeta _chestIdMeta = const VerificationMeta(
    'chestId',
  );
  @override
  late final GeneratedColumn<int> chestId = GeneratedColumn<int>(
    'chest_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES armor_pieces (id)',
    ),
  );
  static const VerificationMeta _armsIdMeta = const VerificationMeta('armsId');
  @override
  late final GeneratedColumn<int> armsId = GeneratedColumn<int>(
    'arms_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES armor_pieces (id)',
    ),
  );
  static const VerificationMeta _waistIdMeta = const VerificationMeta(
    'waistId',
  );
  @override
  late final GeneratedColumn<int> waistId = GeneratedColumn<int>(
    'waist_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES armor_pieces (id)',
    ),
  );
  static const VerificationMeta _legsIdMeta = const VerificationMeta('legsId');
  @override
  late final GeneratedColumn<int> legsId = GeneratedColumn<int>(
    'legs_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES armor_pieces (id)',
    ),
  );
  static const VerificationMeta _talismanIdMeta = const VerificationMeta(
    'talismanId',
  );
  @override
  late final GeneratedColumn<int> talismanId = GeneratedColumn<int>(
    'talisman_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES talismans (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    weaponId,
    headId,
    chestId,
    armsId,
    waistId,
    legsId,
    talismanId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'builds';
  @override
  VerificationContext validateIntegrity(
    Insertable<Build> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weapon_id')) {
      context.handle(
        _weaponIdMeta,
        weaponId.isAcceptableOrUnknown(data['weapon_id']!, _weaponIdMeta),
      );
    }
    if (data.containsKey('head_id')) {
      context.handle(
        _headIdMeta,
        headId.isAcceptableOrUnknown(data['head_id']!, _headIdMeta),
      );
    }
    if (data.containsKey('chest_id')) {
      context.handle(
        _chestIdMeta,
        chestId.isAcceptableOrUnknown(data['chest_id']!, _chestIdMeta),
      );
    }
    if (data.containsKey('arms_id')) {
      context.handle(
        _armsIdMeta,
        armsId.isAcceptableOrUnknown(data['arms_id']!, _armsIdMeta),
      );
    }
    if (data.containsKey('waist_id')) {
      context.handle(
        _waistIdMeta,
        waistId.isAcceptableOrUnknown(data['waist_id']!, _waistIdMeta),
      );
    }
    if (data.containsKey('legs_id')) {
      context.handle(
        _legsIdMeta,
        legsId.isAcceptableOrUnknown(data['legs_id']!, _legsIdMeta),
      );
    }
    if (data.containsKey('talisman_id')) {
      context.handle(
        _talismanIdMeta,
        talismanId.isAcceptableOrUnknown(data['talisman_id']!, _talismanIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Build map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Build(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      weaponId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weapon_id'],
      ),
      headId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}head_id'],
      ),
      chestId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chest_id'],
      ),
      armsId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}arms_id'],
      ),
      waistId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}waist_id'],
      ),
      legsId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}legs_id'],
      ),
      talismanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}talisman_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BuildsTable createAlias(String alias) {
    return $BuildsTable(attachedDatabase, alias);
  }
}

class Build extends DataClass implements Insertable<Build> {
  final int id;
  final String name;
  final int? weaponId;
  final int? headId;
  final int? chestId;
  final int? armsId;
  final int? waistId;
  final int? legsId;
  final int? talismanId;
  final int createdAt;
  final int updatedAt;
  const Build({
    required this.id,
    required this.name,
    this.weaponId,
    this.headId,
    this.chestId,
    this.armsId,
    this.waistId,
    this.legsId,
    this.talismanId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || weaponId != null) {
      map['weapon_id'] = Variable<int>(weaponId);
    }
    if (!nullToAbsent || headId != null) {
      map['head_id'] = Variable<int>(headId);
    }
    if (!nullToAbsent || chestId != null) {
      map['chest_id'] = Variable<int>(chestId);
    }
    if (!nullToAbsent || armsId != null) {
      map['arms_id'] = Variable<int>(armsId);
    }
    if (!nullToAbsent || waistId != null) {
      map['waist_id'] = Variable<int>(waistId);
    }
    if (!nullToAbsent || legsId != null) {
      map['legs_id'] = Variable<int>(legsId);
    }
    if (!nullToAbsent || talismanId != null) {
      map['talisman_id'] = Variable<int>(talismanId);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  BuildsCompanion toCompanion(bool nullToAbsent) {
    return BuildsCompanion(
      id: Value(id),
      name: Value(name),
      weaponId: weaponId == null && nullToAbsent
          ? const Value.absent()
          : Value(weaponId),
      headId: headId == null && nullToAbsent
          ? const Value.absent()
          : Value(headId),
      chestId: chestId == null && nullToAbsent
          ? const Value.absent()
          : Value(chestId),
      armsId: armsId == null && nullToAbsent
          ? const Value.absent()
          : Value(armsId),
      waistId: waistId == null && nullToAbsent
          ? const Value.absent()
          : Value(waistId),
      legsId: legsId == null && nullToAbsent
          ? const Value.absent()
          : Value(legsId),
      talismanId: talismanId == null && nullToAbsent
          ? const Value.absent()
          : Value(talismanId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Build.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Build(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      weaponId: serializer.fromJson<int?>(json['weaponId']),
      headId: serializer.fromJson<int?>(json['headId']),
      chestId: serializer.fromJson<int?>(json['chestId']),
      armsId: serializer.fromJson<int?>(json['armsId']),
      waistId: serializer.fromJson<int?>(json['waistId']),
      legsId: serializer.fromJson<int?>(json['legsId']),
      talismanId: serializer.fromJson<int?>(json['talismanId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'weaponId': serializer.toJson<int?>(weaponId),
      'headId': serializer.toJson<int?>(headId),
      'chestId': serializer.toJson<int?>(chestId),
      'armsId': serializer.toJson<int?>(armsId),
      'waistId': serializer.toJson<int?>(waistId),
      'legsId': serializer.toJson<int?>(legsId),
      'talismanId': serializer.toJson<int?>(talismanId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Build copyWith({
    int? id,
    String? name,
    Value<int?> weaponId = const Value.absent(),
    Value<int?> headId = const Value.absent(),
    Value<int?> chestId = const Value.absent(),
    Value<int?> armsId = const Value.absent(),
    Value<int?> waistId = const Value.absent(),
    Value<int?> legsId = const Value.absent(),
    Value<int?> talismanId = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => Build(
    id: id ?? this.id,
    name: name ?? this.name,
    weaponId: weaponId.present ? weaponId.value : this.weaponId,
    headId: headId.present ? headId.value : this.headId,
    chestId: chestId.present ? chestId.value : this.chestId,
    armsId: armsId.present ? armsId.value : this.armsId,
    waistId: waistId.present ? waistId.value : this.waistId,
    legsId: legsId.present ? legsId.value : this.legsId,
    talismanId: talismanId.present ? talismanId.value : this.talismanId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Build copyWithCompanion(BuildsCompanion data) {
    return Build(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      weaponId: data.weaponId.present ? data.weaponId.value : this.weaponId,
      headId: data.headId.present ? data.headId.value : this.headId,
      chestId: data.chestId.present ? data.chestId.value : this.chestId,
      armsId: data.armsId.present ? data.armsId.value : this.armsId,
      waistId: data.waistId.present ? data.waistId.value : this.waistId,
      legsId: data.legsId.present ? data.legsId.value : this.legsId,
      talismanId: data.talismanId.present
          ? data.talismanId.value
          : this.talismanId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Build(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('weaponId: $weaponId, ')
          ..write('headId: $headId, ')
          ..write('chestId: $chestId, ')
          ..write('armsId: $armsId, ')
          ..write('waistId: $waistId, ')
          ..write('legsId: $legsId, ')
          ..write('talismanId: $talismanId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    weaponId,
    headId,
    chestId,
    armsId,
    waistId,
    legsId,
    talismanId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Build &&
          other.id == this.id &&
          other.name == this.name &&
          other.weaponId == this.weaponId &&
          other.headId == this.headId &&
          other.chestId == this.chestId &&
          other.armsId == this.armsId &&
          other.waistId == this.waistId &&
          other.legsId == this.legsId &&
          other.talismanId == this.talismanId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BuildsCompanion extends UpdateCompanion<Build> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> weaponId;
  final Value<int?> headId;
  final Value<int?> chestId;
  final Value<int?> armsId;
  final Value<int?> waistId;
  final Value<int?> legsId;
  final Value<int?> talismanId;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const BuildsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.weaponId = const Value.absent(),
    this.headId = const Value.absent(),
    this.chestId = const Value.absent(),
    this.armsId = const Value.absent(),
    this.waistId = const Value.absent(),
    this.legsId = const Value.absent(),
    this.talismanId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BuildsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.weaponId = const Value.absent(),
    this.headId = const Value.absent(),
    this.chestId = const Value.absent(),
    this.armsId = const Value.absent(),
    this.waistId = const Value.absent(),
    this.legsId = const Value.absent(),
    this.talismanId = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Build> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? weaponId,
    Expression<int>? headId,
    Expression<int>? chestId,
    Expression<int>? armsId,
    Expression<int>? waistId,
    Expression<int>? legsId,
    Expression<int>? talismanId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (weaponId != null) 'weapon_id': weaponId,
      if (headId != null) 'head_id': headId,
      if (chestId != null) 'chest_id': chestId,
      if (armsId != null) 'arms_id': armsId,
      if (waistId != null) 'waist_id': waistId,
      if (legsId != null) 'legs_id': legsId,
      if (talismanId != null) 'talisman_id': talismanId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BuildsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? weaponId,
    Value<int?>? headId,
    Value<int?>? chestId,
    Value<int?>? armsId,
    Value<int?>? waistId,
    Value<int?>? legsId,
    Value<int?>? talismanId,
    Value<int>? createdAt,
    Value<int>? updatedAt,
  }) {
    return BuildsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      weaponId: weaponId ?? this.weaponId,
      headId: headId ?? this.headId,
      chestId: chestId ?? this.chestId,
      armsId: armsId ?? this.armsId,
      waistId: waistId ?? this.waistId,
      legsId: legsId ?? this.legsId,
      talismanId: talismanId ?? this.talismanId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weaponId.present) {
      map['weapon_id'] = Variable<int>(weaponId.value);
    }
    if (headId.present) {
      map['head_id'] = Variable<int>(headId.value);
    }
    if (chestId.present) {
      map['chest_id'] = Variable<int>(chestId.value);
    }
    if (armsId.present) {
      map['arms_id'] = Variable<int>(armsId.value);
    }
    if (waistId.present) {
      map['waist_id'] = Variable<int>(waistId.value);
    }
    if (legsId.present) {
      map['legs_id'] = Variable<int>(legsId.value);
    }
    if (talismanId.present) {
      map['talisman_id'] = Variable<int>(talismanId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('weaponId: $weaponId, ')
          ..write('headId: $headId, ')
          ..write('chestId: $chestId, ')
          ..write('armsId: $armsId, ')
          ..write('waistId: $waistId, ')
          ..write('legsId: $legsId, ')
          ..write('talismanId: $talismanId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BuildJewelsTable extends BuildJewels
    with TableInfo<$BuildJewelsTable, BuildJewel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildJewelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _buildIdMeta = const VerificationMeta(
    'buildId',
  );
  @override
  late final GeneratedColumn<int> buildId = GeneratedColumn<int>(
    'build_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES builds (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<JewelSlotSource, String>
  slotSource = GeneratedColumn<String>(
    'slot_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<JewelSlotSource>($BuildJewelsTable.$converterslotSource);
  static const VerificationMeta _slotIndexMeta = const VerificationMeta(
    'slotIndex',
  );
  @override
  late final GeneratedColumn<int> slotIndex = GeneratedColumn<int>(
    'slot_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jewelIdMeta = const VerificationMeta(
    'jewelId',
  );
  @override
  late final GeneratedColumn<int> jewelId = GeneratedColumn<int>(
    'jewel_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jewels (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    buildId,
    slotSource,
    slotIndex,
    jewelId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'build_jewels';
  @override
  VerificationContext validateIntegrity(
    Insertable<BuildJewel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('build_id')) {
      context.handle(
        _buildIdMeta,
        buildId.isAcceptableOrUnknown(data['build_id']!, _buildIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buildIdMeta);
    }
    if (data.containsKey('slot_index')) {
      context.handle(
        _slotIndexMeta,
        slotIndex.isAcceptableOrUnknown(data['slot_index']!, _slotIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_slotIndexMeta);
    }
    if (data.containsKey('jewel_id')) {
      context.handle(
        _jewelIdMeta,
        jewelId.isAcceptableOrUnknown(data['jewel_id']!, _jewelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jewelIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuildJewel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuildJewel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      buildId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}build_id'],
      )!,
      slotSource: $BuildJewelsTable.$converterslotSource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}slot_source'],
        )!,
      ),
      slotIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot_index'],
      )!,
      jewelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jewel_id'],
      )!,
    );
  }

  @override
  $BuildJewelsTable createAlias(String alias) {
    return $BuildJewelsTable(attachedDatabase, alias);
  }

  static TypeConverter<JewelSlotSource, String> $converterslotSource =
      const JewelSlotSourceConverter();
}

class BuildJewel extends DataClass implements Insertable<BuildJewel> {
  final int id;
  final int buildId;
  final JewelSlotSource slotSource;
  final int slotIndex;
  final int jewelId;
  const BuildJewel({
    required this.id,
    required this.buildId,
    required this.slotSource,
    required this.slotIndex,
    required this.jewelId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['build_id'] = Variable<int>(buildId);
    {
      map['slot_source'] = Variable<String>(
        $BuildJewelsTable.$converterslotSource.toSql(slotSource),
      );
    }
    map['slot_index'] = Variable<int>(slotIndex);
    map['jewel_id'] = Variable<int>(jewelId);
    return map;
  }

  BuildJewelsCompanion toCompanion(bool nullToAbsent) {
    return BuildJewelsCompanion(
      id: Value(id),
      buildId: Value(buildId),
      slotSource: Value(slotSource),
      slotIndex: Value(slotIndex),
      jewelId: Value(jewelId),
    );
  }

  factory BuildJewel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuildJewel(
      id: serializer.fromJson<int>(json['id']),
      buildId: serializer.fromJson<int>(json['buildId']),
      slotSource: serializer.fromJson<JewelSlotSource>(json['slotSource']),
      slotIndex: serializer.fromJson<int>(json['slotIndex']),
      jewelId: serializer.fromJson<int>(json['jewelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buildId': serializer.toJson<int>(buildId),
      'slotSource': serializer.toJson<JewelSlotSource>(slotSource),
      'slotIndex': serializer.toJson<int>(slotIndex),
      'jewelId': serializer.toJson<int>(jewelId),
    };
  }

  BuildJewel copyWith({
    int? id,
    int? buildId,
    JewelSlotSource? slotSource,
    int? slotIndex,
    int? jewelId,
  }) => BuildJewel(
    id: id ?? this.id,
    buildId: buildId ?? this.buildId,
    slotSource: slotSource ?? this.slotSource,
    slotIndex: slotIndex ?? this.slotIndex,
    jewelId: jewelId ?? this.jewelId,
  );
  BuildJewel copyWithCompanion(BuildJewelsCompanion data) {
    return BuildJewel(
      id: data.id.present ? data.id.value : this.id,
      buildId: data.buildId.present ? data.buildId.value : this.buildId,
      slotSource: data.slotSource.present
          ? data.slotSource.value
          : this.slotSource,
      slotIndex: data.slotIndex.present ? data.slotIndex.value : this.slotIndex,
      jewelId: data.jewelId.present ? data.jewelId.value : this.jewelId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BuildJewel(')
          ..write('id: $id, ')
          ..write('buildId: $buildId, ')
          ..write('slotSource: $slotSource, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('jewelId: $jewelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, buildId, slotSource, slotIndex, jewelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuildJewel &&
          other.id == this.id &&
          other.buildId == this.buildId &&
          other.slotSource == this.slotSource &&
          other.slotIndex == this.slotIndex &&
          other.jewelId == this.jewelId);
}

class BuildJewelsCompanion extends UpdateCompanion<BuildJewel> {
  final Value<int> id;
  final Value<int> buildId;
  final Value<JewelSlotSource> slotSource;
  final Value<int> slotIndex;
  final Value<int> jewelId;
  const BuildJewelsCompanion({
    this.id = const Value.absent(),
    this.buildId = const Value.absent(),
    this.slotSource = const Value.absent(),
    this.slotIndex = const Value.absent(),
    this.jewelId = const Value.absent(),
  });
  BuildJewelsCompanion.insert({
    this.id = const Value.absent(),
    required int buildId,
    required JewelSlotSource slotSource,
    required int slotIndex,
    required int jewelId,
  }) : buildId = Value(buildId),
       slotSource = Value(slotSource),
       slotIndex = Value(slotIndex),
       jewelId = Value(jewelId);
  static Insertable<BuildJewel> custom({
    Expression<int>? id,
    Expression<int>? buildId,
    Expression<String>? slotSource,
    Expression<int>? slotIndex,
    Expression<int>? jewelId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buildId != null) 'build_id': buildId,
      if (slotSource != null) 'slot_source': slotSource,
      if (slotIndex != null) 'slot_index': slotIndex,
      if (jewelId != null) 'jewel_id': jewelId,
    });
  }

  BuildJewelsCompanion copyWith({
    Value<int>? id,
    Value<int>? buildId,
    Value<JewelSlotSource>? slotSource,
    Value<int>? slotIndex,
    Value<int>? jewelId,
  }) {
    return BuildJewelsCompanion(
      id: id ?? this.id,
      buildId: buildId ?? this.buildId,
      slotSource: slotSource ?? this.slotSource,
      slotIndex: slotIndex ?? this.slotIndex,
      jewelId: jewelId ?? this.jewelId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buildId.present) {
      map['build_id'] = Variable<int>(buildId.value);
    }
    if (slotSource.present) {
      map['slot_source'] = Variable<String>(
        $BuildJewelsTable.$converterslotSource.toSql(slotSource.value),
      );
    }
    if (slotIndex.present) {
      map['slot_index'] = Variable<int>(slotIndex.value);
    }
    if (jewelId.present) {
      map['jewel_id'] = Variable<int>(jewelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildJewelsCompanion(')
          ..write('id: $id, ')
          ..write('buildId: $buildId, ')
          ..write('slotSource: $slotSource, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('jewelId: $jewelId')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tableNameColMeta = const VerificationMeta(
    'tableNameCol',
  );
  @override
  late final GeneratedColumn<String> tableNameCol = GeneratedColumn<String>(
    'table_name_col',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastVersionMeta = const VerificationMeta(
    'lastVersion',
  );
  @override
  late final GeneratedColumn<int> lastVersion = GeneratedColumn<int>(
    'last_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    tableNameCol,
    lastVersion,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('table_name_col')) {
      context.handle(
        _tableNameColMeta,
        tableNameCol.isAcceptableOrUnknown(
          data['table_name_col']!,
          _tableNameColMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tableNameColMeta);
    }
    if (data.containsKey('last_version')) {
      context.handle(
        _lastVersionMeta,
        lastVersion.isAcceptableOrUnknown(
          data['last_version']!,
          _lastVersionMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tableNameCol};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      tableNameCol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}table_name_col'],
      )!,
      lastVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_version'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String tableNameCol;
  final int lastVersion;
  final int? lastSyncedAt;
  const SyncMetadataData({
    required this.tableNameCol,
    required this.lastVersion,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['table_name_col'] = Variable<String>(tableNameCol);
    map['last_version'] = Variable<int>(lastVersion);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      tableNameCol: Value(tableNameCol),
      lastVersion: Value(lastVersion),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory SyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      tableNameCol: serializer.fromJson<String>(json['tableNameCol']),
      lastVersion: serializer.fromJson<int>(json['lastVersion']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tableNameCol': serializer.toJson<String>(tableNameCol),
      'lastVersion': serializer.toJson<int>(lastVersion),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
    };
  }

  SyncMetadataData copyWith({
    String? tableNameCol,
    int? lastVersion,
    Value<int?> lastSyncedAt = const Value.absent(),
  }) => SyncMetadataData(
    tableNameCol: tableNameCol ?? this.tableNameCol,
    lastVersion: lastVersion ?? this.lastVersion,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      tableNameCol: data.tableNameCol.present
          ? data.tableNameCol.value
          : this.tableNameCol,
      lastVersion: data.lastVersion.present
          ? data.lastVersion.value
          : this.lastVersion,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('tableNameCol: $tableNameCol, ')
          ..write('lastVersion: $lastVersion, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tableNameCol, lastVersion, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.tableNameCol == this.tableNameCol &&
          other.lastVersion == this.lastVersion &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> tableNameCol;
  final Value<int> lastVersion;
  final Value<int?> lastSyncedAt;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.tableNameCol = const Value.absent(),
    this.lastVersion = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String tableNameCol,
    this.lastVersion = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tableNameCol = Value(tableNameCol);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? tableNameCol,
    Expression<int>? lastVersion,
    Expression<int>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tableNameCol != null) 'table_name_col': tableNameCol,
      if (lastVersion != null) 'last_version': lastVersion,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? tableNameCol,
    Value<int>? lastVersion,
    Value<int?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      tableNameCol: tableNameCol ?? this.tableNameCol,
      lastVersion: lastVersion ?? this.lastVersion,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tableNameCol.present) {
      map['table_name_col'] = Variable<String>(tableNameCol.value);
    }
    if (lastVersion.present) {
      map['last_version'] = Variable<int>(lastVersion.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('tableNameCol: $tableNameCol, ')
          ..write('lastVersion: $lastVersion, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WeaponsTable weapons = $WeaponsTable(this);
  late final $ArmorSetsTable armorSets = $ArmorSetsTable(this);
  late final $ArmorPiecesTable armorPieces = $ArmorPiecesTable(this);
  late final $SkillsTable skills = $SkillsTable(this);
  late final $ArmorSetSkillsTable armorSetSkills = $ArmorSetSkillsTable(this);
  late final $JewelsTable jewels = $JewelsTable(this);
  late final $SkillLevelsTable skillLevels = $SkillLevelsTable(this);
  late final $TalismansTable talismans = $TalismansTable(this);
  late final $BuildsTable builds = $BuildsTable(this);
  late final $BuildJewelsTable buildJewels = $BuildJewelsTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  late final WeaponsDao weaponsDao = WeaponsDao(this as AppDatabase);
  late final ArmorDao armorDao = ArmorDao(this as AppDatabase);
  late final SkillsDao skillsDao = SkillsDao(this as AppDatabase);
  late final BuildsDao buildsDao = BuildsDao(this as AppDatabase);
  late final TalismansDao talismansDao = TalismansDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    weapons,
    armorSets,
    armorPieces,
    skills,
    armorSetSkills,
    jewels,
    skillLevels,
    talismans,
    builds,
    buildJewels,
    syncMetadata,
  ];
}

typedef $$WeaponsTableCreateCompanionBuilder =
    WeaponsCompanion Function({
      Value<int> id,
      required String slug,
      required String name,
      required WeaponType weaponType,
      required int baseAttack,
      Value<double> baseAffinity,
      Value<ElementType?> elementType,
      Value<int?> elementValue,
      Value<SharpnessLevel> sharpnessMax,
      Value<int> rarity,
      Value<String> slots,
      Value<double> rmv,
      Value<double> emv,
      Value<DamageType> damageType,
      Value<String> burstGroup,
    });
typedef $$WeaponsTableUpdateCompanionBuilder =
    WeaponsCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> name,
      Value<WeaponType> weaponType,
      Value<int> baseAttack,
      Value<double> baseAffinity,
      Value<ElementType?> elementType,
      Value<int?> elementValue,
      Value<SharpnessLevel> sharpnessMax,
      Value<int> rarity,
      Value<String> slots,
      Value<double> rmv,
      Value<double> emv,
      Value<DamageType> damageType,
      Value<String> burstGroup,
    });

final class $$WeaponsTableReferences
    extends BaseReferences<_$AppDatabase, $WeaponsTable, Weapon> {
  $$WeaponsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BuildsTable, List<Build>> _buildsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.builds,
    aliasName: $_aliasNameGenerator(db.weapons.id, db.builds.weaponId),
  );

  $$BuildsTableProcessedTableManager get buildsRefs {
    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.weaponId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeaponsTableFilterComposer
    extends Composer<_$AppDatabase, $WeaponsTable> {
  $$WeaponsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WeaponType, WeaponType, String>
  get weaponType => $composableBuilder(
    column: $table.weaponType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get baseAttack => $composableBuilder(
    column: $table.baseAttack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get baseAffinity => $composableBuilder(
    column: $table.baseAffinity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ElementType?, ElementType, String>
  get elementType => $composableBuilder(
    column: $table.elementType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get elementValue => $composableBuilder(
    column: $table.elementValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SharpnessLevel, SharpnessLevel, String>
  get sharpnessMax => $composableBuilder(
    column: $table.sharpnessMax,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slots => $composableBuilder(
    column: $table.slots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rmv => $composableBuilder(
    column: $table.rmv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get emv => $composableBuilder(
    column: $table.emv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DamageType, DamageType, String>
  get damageType => $composableBuilder(
    column: $table.damageType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get burstGroup => $composableBuilder(
    column: $table.burstGroup,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> buildsRefs(
    Expression<bool> Function($$BuildsTableFilterComposer f) f,
  ) {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.weaponId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeaponsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeaponsTable> {
  $$WeaponsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weaponType => $composableBuilder(
    column: $table.weaponType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseAttack => $composableBuilder(
    column: $table.baseAttack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get baseAffinity => $composableBuilder(
    column: $table.baseAffinity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get elementType => $composableBuilder(
    column: $table.elementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elementValue => $composableBuilder(
    column: $table.elementValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sharpnessMax => $composableBuilder(
    column: $table.sharpnessMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slots => $composableBuilder(
    column: $table.slots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rmv => $composableBuilder(
    column: $table.rmv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get emv => $composableBuilder(
    column: $table.emv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageType => $composableBuilder(
    column: $table.damageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get burstGroup => $composableBuilder(
    column: $table.burstGroup,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeaponsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeaponsTable> {
  $$WeaponsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WeaponType, String> get weaponType =>
      $composableBuilder(
        column: $table.weaponType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get baseAttack => $composableBuilder(
    column: $table.baseAttack,
    builder: (column) => column,
  );

  GeneratedColumn<double> get baseAffinity => $composableBuilder(
    column: $table.baseAffinity,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ElementType?, String> get elementType =>
      $composableBuilder(
        column: $table.elementType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get elementValue => $composableBuilder(
    column: $table.elementValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SharpnessLevel, String> get sharpnessMax =>
      $composableBuilder(
        column: $table.sharpnessMax,
        builder: (column) => column,
      );

  GeneratedColumn<int> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<String> get slots =>
      $composableBuilder(column: $table.slots, builder: (column) => column);

  GeneratedColumn<double> get rmv =>
      $composableBuilder(column: $table.rmv, builder: (column) => column);

  GeneratedColumn<double> get emv =>
      $composableBuilder(column: $table.emv, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DamageType, String> get damageType =>
      $composableBuilder(
        column: $table.damageType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get burstGroup => $composableBuilder(
    column: $table.burstGroup,
    builder: (column) => column,
  );

  Expression<T> buildsRefs<T extends Object>(
    Expression<T> Function($$BuildsTableAnnotationComposer a) f,
  ) {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.weaponId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeaponsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeaponsTable,
          Weapon,
          $$WeaponsTableFilterComposer,
          $$WeaponsTableOrderingComposer,
          $$WeaponsTableAnnotationComposer,
          $$WeaponsTableCreateCompanionBuilder,
          $$WeaponsTableUpdateCompanionBuilder,
          (Weapon, $$WeaponsTableReferences),
          Weapon,
          PrefetchHooks Function({bool buildsRefs})
        > {
  $$WeaponsTableTableManager(_$AppDatabase db, $WeaponsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeaponsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeaponsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeaponsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<WeaponType> weaponType = const Value.absent(),
                Value<int> baseAttack = const Value.absent(),
                Value<double> baseAffinity = const Value.absent(),
                Value<ElementType?> elementType = const Value.absent(),
                Value<int?> elementValue = const Value.absent(),
                Value<SharpnessLevel> sharpnessMax = const Value.absent(),
                Value<int> rarity = const Value.absent(),
                Value<String> slots = const Value.absent(),
                Value<double> rmv = const Value.absent(),
                Value<double> emv = const Value.absent(),
                Value<DamageType> damageType = const Value.absent(),
                Value<String> burstGroup = const Value.absent(),
              }) => WeaponsCompanion(
                id: id,
                slug: slug,
                name: name,
                weaponType: weaponType,
                baseAttack: baseAttack,
                baseAffinity: baseAffinity,
                elementType: elementType,
                elementValue: elementValue,
                sharpnessMax: sharpnessMax,
                rarity: rarity,
                slots: slots,
                rmv: rmv,
                emv: emv,
                damageType: damageType,
                burstGroup: burstGroup,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String name,
                required WeaponType weaponType,
                required int baseAttack,
                Value<double> baseAffinity = const Value.absent(),
                Value<ElementType?> elementType = const Value.absent(),
                Value<int?> elementValue = const Value.absent(),
                Value<SharpnessLevel> sharpnessMax = const Value.absent(),
                Value<int> rarity = const Value.absent(),
                Value<String> slots = const Value.absent(),
                Value<double> rmv = const Value.absent(),
                Value<double> emv = const Value.absent(),
                Value<DamageType> damageType = const Value.absent(),
                Value<String> burstGroup = const Value.absent(),
              }) => WeaponsCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                weaponType: weaponType,
                baseAttack: baseAttack,
                baseAffinity: baseAffinity,
                elementType: elementType,
                elementValue: elementValue,
                sharpnessMax: sharpnessMax,
                rarity: rarity,
                slots: slots,
                rmv: rmv,
                emv: emv,
                damageType: damageType,
                burstGroup: burstGroup,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeaponsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({buildsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (buildsRefs) db.builds],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (buildsRefs)
                    await $_getPrefetchedData<Weapon, $WeaponsTable, Build>(
                      currentTable: table,
                      referencedTable: $$WeaponsTableReferences
                          ._buildsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WeaponsTableReferences(db, table, p0).buildsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.weaponId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WeaponsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeaponsTable,
      Weapon,
      $$WeaponsTableFilterComposer,
      $$WeaponsTableOrderingComposer,
      $$WeaponsTableAnnotationComposer,
      $$WeaponsTableCreateCompanionBuilder,
      $$WeaponsTableUpdateCompanionBuilder,
      (Weapon, $$WeaponsTableReferences),
      Weapon,
      PrefetchHooks Function({bool buildsRefs})
    >;
typedef $$ArmorSetsTableCreateCompanionBuilder =
    ArmorSetsCompanion Function({
      Value<int> id,
      required String slug,
      required String name,
    });
typedef $$ArmorSetsTableUpdateCompanionBuilder =
    ArmorSetsCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> name,
    });

final class $$ArmorSetsTableReferences
    extends BaseReferences<_$AppDatabase, $ArmorSetsTable, ArmorSet> {
  $$ArmorSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ArmorPiecesTable, List<ArmorPiece>>
  _armorPiecesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.armorPieces,
    aliasName: $_aliasNameGenerator(db.armorSets.id, db.armorPieces.setId),
  );

  $$ArmorPiecesTableProcessedTableManager get armorPiecesRefs {
    final manager = $$ArmorPiecesTableTableManager(
      $_db,
      $_db.armorPieces,
    ).filter((f) => f.setId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_armorPiecesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ArmorSetSkillsTable, List<ArmorSetSkill>>
  _armorSetSkillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.armorSetSkills,
    aliasName: $_aliasNameGenerator(db.armorSets.id, db.armorSetSkills.setId),
  );

  $$ArmorSetSkillsTableProcessedTableManager get armorSetSkillsRefs {
    final manager = $$ArmorSetSkillsTableTableManager(
      $_db,
      $_db.armorSetSkills,
    ).filter((f) => f.setId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_armorSetSkillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ArmorSetsTableFilterComposer
    extends Composer<_$AppDatabase, $ArmorSetsTable> {
  $$ArmorSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> armorPiecesRefs(
    Expression<bool> Function($$ArmorPiecesTableFilterComposer f) f,
  ) {
    final $$ArmorPiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.setId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableFilterComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> armorSetSkillsRefs(
    Expression<bool> Function($$ArmorSetSkillsTableFilterComposer f) f,
  ) {
    final $$ArmorSetSkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.armorSetSkills,
      getReferencedColumn: (t) => t.setId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetSkillsTableFilterComposer(
            $db: $db,
            $table: $db.armorSetSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArmorSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArmorSetsTable> {
  $$ArmorSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArmorSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArmorSetsTable> {
  $$ArmorSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> armorPiecesRefs<T extends Object>(
    Expression<T> Function($$ArmorPiecesTableAnnotationComposer a) f,
  ) {
    final $$ArmorPiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.setId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> armorSetSkillsRefs<T extends Object>(
    Expression<T> Function($$ArmorSetSkillsTableAnnotationComposer a) f,
  ) {
    final $$ArmorSetSkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.armorSetSkills,
      getReferencedColumn: (t) => t.setId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetSkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.armorSetSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArmorSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArmorSetsTable,
          ArmorSet,
          $$ArmorSetsTableFilterComposer,
          $$ArmorSetsTableOrderingComposer,
          $$ArmorSetsTableAnnotationComposer,
          $$ArmorSetsTableCreateCompanionBuilder,
          $$ArmorSetsTableUpdateCompanionBuilder,
          (ArmorSet, $$ArmorSetsTableReferences),
          ArmorSet,
          PrefetchHooks Function({
            bool armorPiecesRefs,
            bool armorSetSkillsRefs,
          })
        > {
  $$ArmorSetsTableTableManager(_$AppDatabase db, $ArmorSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArmorSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArmorSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArmorSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ArmorSetsCompanion(id: id, slug: slug, name: name),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String name,
              }) => ArmorSetsCompanion.insert(id: id, slug: slug, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArmorSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({armorPiecesRefs = false, armorSetSkillsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (armorPiecesRefs) db.armorPieces,
                    if (armorSetSkillsRefs) db.armorSetSkills,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (armorPiecesRefs)
                        await $_getPrefetchedData<
                          ArmorSet,
                          $ArmorSetsTable,
                          ArmorPiece
                        >(
                          currentTable: table,
                          referencedTable: $$ArmorSetsTableReferences
                              ._armorPiecesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArmorSetsTableReferences(
                                db,
                                table,
                                p0,
                              ).armorPiecesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.setId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (armorSetSkillsRefs)
                        await $_getPrefetchedData<
                          ArmorSet,
                          $ArmorSetsTable,
                          ArmorSetSkill
                        >(
                          currentTable: table,
                          referencedTable: $$ArmorSetsTableReferences
                              ._armorSetSkillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArmorSetsTableReferences(
                                db,
                                table,
                                p0,
                              ).armorSetSkillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.setId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ArmorSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArmorSetsTable,
      ArmorSet,
      $$ArmorSetsTableFilterComposer,
      $$ArmorSetsTableOrderingComposer,
      $$ArmorSetsTableAnnotationComposer,
      $$ArmorSetsTableCreateCompanionBuilder,
      $$ArmorSetsTableUpdateCompanionBuilder,
      (ArmorSet, $$ArmorSetsTableReferences),
      ArmorSet,
      PrefetchHooks Function({bool armorPiecesRefs, bool armorSetSkillsRefs})
    >;
typedef $$ArmorPiecesTableCreateCompanionBuilder =
    ArmorPiecesCompanion Function({
      Value<int> id,
      required String slug,
      required String name,
      required ArmorSlotType slotType,
      Value<int> baseDefense,
      Value<int> fireRes,
      Value<int> waterRes,
      Value<int> thunderRes,
      Value<int> iceRes,
      Value<int> dragonRes,
      Value<int> rarity,
      Value<String> slots,
      required int setId,
    });
typedef $$ArmorPiecesTableUpdateCompanionBuilder =
    ArmorPiecesCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> name,
      Value<ArmorSlotType> slotType,
      Value<int> baseDefense,
      Value<int> fireRes,
      Value<int> waterRes,
      Value<int> thunderRes,
      Value<int> iceRes,
      Value<int> dragonRes,
      Value<int> rarity,
      Value<String> slots,
      Value<int> setId,
    });

final class $$ArmorPiecesTableReferences
    extends BaseReferences<_$AppDatabase, $ArmorPiecesTable, ArmorPiece> {
  $$ArmorPiecesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ArmorSetsTable _setIdTable(_$AppDatabase db) => db.armorSets
      .createAlias($_aliasNameGenerator(db.armorPieces.setId, db.armorSets.id));

  $$ArmorSetsTableProcessedTableManager get setId {
    final $_column = $_itemColumn<int>('set_id')!;

    final manager = $$ArmorSetsTableTableManager(
      $_db,
      $_db.armorSets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_setIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BuildsTable, List<Build>> _buildHeadRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.builds,
    aliasName: $_aliasNameGenerator(db.armorPieces.id, db.builds.headId),
  );

  $$BuildsTableProcessedTableManager get buildHeadRefs {
    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.headId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildHeadRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BuildsTable, List<Build>> _buildChestRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.builds,
    aliasName: $_aliasNameGenerator(db.armorPieces.id, db.builds.chestId),
  );

  $$BuildsTableProcessedTableManager get buildChestRefs {
    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.chestId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildChestRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BuildsTable, List<Build>> _buildArmsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.builds,
    aliasName: $_aliasNameGenerator(db.armorPieces.id, db.builds.armsId),
  );

  $$BuildsTableProcessedTableManager get buildArmsRefs {
    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.armsId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildArmsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BuildsTable, List<Build>> _buildWaistRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.builds,
    aliasName: $_aliasNameGenerator(db.armorPieces.id, db.builds.waistId),
  );

  $$BuildsTableProcessedTableManager get buildWaistRefs {
    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.waistId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildWaistRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BuildsTable, List<Build>> _buildLegsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.builds,
    aliasName: $_aliasNameGenerator(db.armorPieces.id, db.builds.legsId),
  );

  $$BuildsTableProcessedTableManager get buildLegsRefs {
    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.legsId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildLegsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ArmorPiecesTableFilterComposer
    extends Composer<_$AppDatabase, $ArmorPiecesTable> {
  $$ArmorPiecesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ArmorSlotType, ArmorSlotType, String>
  get slotType => $composableBuilder(
    column: $table.slotType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get baseDefense => $composableBuilder(
    column: $table.baseDefense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fireRes => $composableBuilder(
    column: $table.fireRes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get waterRes => $composableBuilder(
    column: $table.waterRes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get thunderRes => $composableBuilder(
    column: $table.thunderRes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iceRes => $composableBuilder(
    column: $table.iceRes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dragonRes => $composableBuilder(
    column: $table.dragonRes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slots => $composableBuilder(
    column: $table.slots,
    builder: (column) => ColumnFilters(column),
  );

  $$ArmorSetsTableFilterComposer get setId {
    final $$ArmorSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.armorSets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetsTableFilterComposer(
            $db: $db,
            $table: $db.armorSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> buildHeadRefs(
    Expression<bool> Function($$BuildsTableFilterComposer f) f,
  ) {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.headId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> buildChestRefs(
    Expression<bool> Function($$BuildsTableFilterComposer f) f,
  ) {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.chestId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> buildArmsRefs(
    Expression<bool> Function($$BuildsTableFilterComposer f) f,
  ) {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.armsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> buildWaistRefs(
    Expression<bool> Function($$BuildsTableFilterComposer f) f,
  ) {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.waistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> buildLegsRefs(
    Expression<bool> Function($$BuildsTableFilterComposer f) f,
  ) {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.legsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArmorPiecesTableOrderingComposer
    extends Composer<_$AppDatabase, $ArmorPiecesTable> {
  $$ArmorPiecesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slotType => $composableBuilder(
    column: $table.slotType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseDefense => $composableBuilder(
    column: $table.baseDefense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fireRes => $composableBuilder(
    column: $table.fireRes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get waterRes => $composableBuilder(
    column: $table.waterRes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get thunderRes => $composableBuilder(
    column: $table.thunderRes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iceRes => $composableBuilder(
    column: $table.iceRes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dragonRes => $composableBuilder(
    column: $table.dragonRes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slots => $composableBuilder(
    column: $table.slots,
    builder: (column) => ColumnOrderings(column),
  );

  $$ArmorSetsTableOrderingComposer get setId {
    final $$ArmorSetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.armorSets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetsTableOrderingComposer(
            $db: $db,
            $table: $db.armorSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArmorPiecesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArmorPiecesTable> {
  $$ArmorPiecesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ArmorSlotType, String> get slotType =>
      $composableBuilder(column: $table.slotType, builder: (column) => column);

  GeneratedColumn<int> get baseDefense => $composableBuilder(
    column: $table.baseDefense,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fireRes =>
      $composableBuilder(column: $table.fireRes, builder: (column) => column);

  GeneratedColumn<int> get waterRes =>
      $composableBuilder(column: $table.waterRes, builder: (column) => column);

  GeneratedColumn<int> get thunderRes => $composableBuilder(
    column: $table.thunderRes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get iceRes =>
      $composableBuilder(column: $table.iceRes, builder: (column) => column);

  GeneratedColumn<int> get dragonRes =>
      $composableBuilder(column: $table.dragonRes, builder: (column) => column);

  GeneratedColumn<int> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<String> get slots =>
      $composableBuilder(column: $table.slots, builder: (column) => column);

  $$ArmorSetsTableAnnotationComposer get setId {
    final $$ArmorSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.armorSets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.armorSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> buildHeadRefs<T extends Object>(
    Expression<T> Function($$BuildsTableAnnotationComposer a) f,
  ) {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.headId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> buildChestRefs<T extends Object>(
    Expression<T> Function($$BuildsTableAnnotationComposer a) f,
  ) {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.chestId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> buildArmsRefs<T extends Object>(
    Expression<T> Function($$BuildsTableAnnotationComposer a) f,
  ) {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.armsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> buildWaistRefs<T extends Object>(
    Expression<T> Function($$BuildsTableAnnotationComposer a) f,
  ) {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.waistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> buildLegsRefs<T extends Object>(
    Expression<T> Function($$BuildsTableAnnotationComposer a) f,
  ) {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.legsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArmorPiecesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArmorPiecesTable,
          ArmorPiece,
          $$ArmorPiecesTableFilterComposer,
          $$ArmorPiecesTableOrderingComposer,
          $$ArmorPiecesTableAnnotationComposer,
          $$ArmorPiecesTableCreateCompanionBuilder,
          $$ArmorPiecesTableUpdateCompanionBuilder,
          (ArmorPiece, $$ArmorPiecesTableReferences),
          ArmorPiece,
          PrefetchHooks Function({
            bool setId,
            bool buildHeadRefs,
            bool buildChestRefs,
            bool buildArmsRefs,
            bool buildWaistRefs,
            bool buildLegsRefs,
          })
        > {
  $$ArmorPiecesTableTableManager(_$AppDatabase db, $ArmorPiecesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArmorPiecesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArmorPiecesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArmorPiecesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ArmorSlotType> slotType = const Value.absent(),
                Value<int> baseDefense = const Value.absent(),
                Value<int> fireRes = const Value.absent(),
                Value<int> waterRes = const Value.absent(),
                Value<int> thunderRes = const Value.absent(),
                Value<int> iceRes = const Value.absent(),
                Value<int> dragonRes = const Value.absent(),
                Value<int> rarity = const Value.absent(),
                Value<String> slots = const Value.absent(),
                Value<int> setId = const Value.absent(),
              }) => ArmorPiecesCompanion(
                id: id,
                slug: slug,
                name: name,
                slotType: slotType,
                baseDefense: baseDefense,
                fireRes: fireRes,
                waterRes: waterRes,
                thunderRes: thunderRes,
                iceRes: iceRes,
                dragonRes: dragonRes,
                rarity: rarity,
                slots: slots,
                setId: setId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String name,
                required ArmorSlotType slotType,
                Value<int> baseDefense = const Value.absent(),
                Value<int> fireRes = const Value.absent(),
                Value<int> waterRes = const Value.absent(),
                Value<int> thunderRes = const Value.absent(),
                Value<int> iceRes = const Value.absent(),
                Value<int> dragonRes = const Value.absent(),
                Value<int> rarity = const Value.absent(),
                Value<String> slots = const Value.absent(),
                required int setId,
              }) => ArmorPiecesCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                slotType: slotType,
                baseDefense: baseDefense,
                fireRes: fireRes,
                waterRes: waterRes,
                thunderRes: thunderRes,
                iceRes: iceRes,
                dragonRes: dragonRes,
                rarity: rarity,
                slots: slots,
                setId: setId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArmorPiecesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                setId = false,
                buildHeadRefs = false,
                buildChestRefs = false,
                buildArmsRefs = false,
                buildWaistRefs = false,
                buildLegsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (buildHeadRefs) db.builds,
                    if (buildChestRefs) db.builds,
                    if (buildArmsRefs) db.builds,
                    if (buildWaistRefs) db.builds,
                    if (buildLegsRefs) db.builds,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (setId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.setId,
                                    referencedTable:
                                        $$ArmorPiecesTableReferences
                                            ._setIdTable(db),
                                    referencedColumn:
                                        $$ArmorPiecesTableReferences
                                            ._setIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (buildHeadRefs)
                        await $_getPrefetchedData<
                          ArmorPiece,
                          $ArmorPiecesTable,
                          Build
                        >(
                          currentTable: table,
                          referencedTable: $$ArmorPiecesTableReferences
                              ._buildHeadRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArmorPiecesTableReferences(
                                db,
                                table,
                                p0,
                              ).buildHeadRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.headId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (buildChestRefs)
                        await $_getPrefetchedData<
                          ArmorPiece,
                          $ArmorPiecesTable,
                          Build
                        >(
                          currentTable: table,
                          referencedTable: $$ArmorPiecesTableReferences
                              ._buildChestRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArmorPiecesTableReferences(
                                db,
                                table,
                                p0,
                              ).buildChestRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chestId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (buildArmsRefs)
                        await $_getPrefetchedData<
                          ArmorPiece,
                          $ArmorPiecesTable,
                          Build
                        >(
                          currentTable: table,
                          referencedTable: $$ArmorPiecesTableReferences
                              ._buildArmsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArmorPiecesTableReferences(
                                db,
                                table,
                                p0,
                              ).buildArmsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.armsId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (buildWaistRefs)
                        await $_getPrefetchedData<
                          ArmorPiece,
                          $ArmorPiecesTable,
                          Build
                        >(
                          currentTable: table,
                          referencedTable: $$ArmorPiecesTableReferences
                              ._buildWaistRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArmorPiecesTableReferences(
                                db,
                                table,
                                p0,
                              ).buildWaistRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.waistId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (buildLegsRefs)
                        await $_getPrefetchedData<
                          ArmorPiece,
                          $ArmorPiecesTable,
                          Build
                        >(
                          currentTable: table,
                          referencedTable: $$ArmorPiecesTableReferences
                              ._buildLegsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArmorPiecesTableReferences(
                                db,
                                table,
                                p0,
                              ).buildLegsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.legsId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ArmorPiecesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArmorPiecesTable,
      ArmorPiece,
      $$ArmorPiecesTableFilterComposer,
      $$ArmorPiecesTableOrderingComposer,
      $$ArmorPiecesTableAnnotationComposer,
      $$ArmorPiecesTableCreateCompanionBuilder,
      $$ArmorPiecesTableUpdateCompanionBuilder,
      (ArmorPiece, $$ArmorPiecesTableReferences),
      ArmorPiece,
      PrefetchHooks Function({
        bool setId,
        bool buildHeadRefs,
        bool buildChestRefs,
        bool buildArmsRefs,
        bool buildWaistRefs,
        bool buildLegsRefs,
      })
    >;
typedef $$SkillsTableCreateCompanionBuilder =
    SkillsCompanion Function({
      Value<int> id,
      required String slug,
      required String name,
      required int maxLevel,
      Value<SkillCategory> type1,
      Value<SkillSubcategory> type2,
    });
typedef $$SkillsTableUpdateCompanionBuilder =
    SkillsCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> name,
      Value<int> maxLevel,
      Value<SkillCategory> type1,
      Value<SkillSubcategory> type2,
    });

final class $$SkillsTableReferences
    extends BaseReferences<_$AppDatabase, $SkillsTable, Skill> {
  $$SkillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ArmorSetSkillsTable, List<ArmorSetSkill>>
  _armorSetSkillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.armorSetSkills,
    aliasName: $_aliasNameGenerator(db.skills.id, db.armorSetSkills.skillId),
  );

  $$ArmorSetSkillsTableProcessedTableManager get armorSetSkillsRefs {
    final manager = $$ArmorSetSkillsTableTableManager(
      $_db,
      $_db.armorSetSkills,
    ).filter((f) => f.skillId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_armorSetSkillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JewelsTable, List<Jewel>> _jewelsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jewels,
    aliasName: $_aliasNameGenerator(db.skills.id, db.jewels.skillId),
  );

  $$JewelsTableProcessedTableManager get jewelsRefs {
    final manager = $$JewelsTableTableManager(
      $_db,
      $_db.jewels,
    ).filter((f) => f.skillId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jewelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SkillLevelsTable, List<SkillLevel>>
  _skillLevelsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.skillLevels,
    aliasName: $_aliasNameGenerator(db.skills.id, db.skillLevels.skillId),
  );

  $$SkillLevelsTableProcessedTableManager get skillLevelsRefs {
    final manager = $$SkillLevelsTableTableManager(
      $_db,
      $_db.skillLevels,
    ).filter((f) => f.skillId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_skillLevelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TalismansTable, List<Talisman>>
  _talismanSkill1RefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.talismans,
    aliasName: $_aliasNameGenerator(db.skills.id, db.talismans.skill1Id),
  );

  $$TalismansTableProcessedTableManager get talismanSkill1Refs {
    final manager = $$TalismansTableTableManager(
      $_db,
      $_db.talismans,
    ).filter((f) => f.skill1Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_talismanSkill1RefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TalismansTable, List<Talisman>>
  _talismanSkill2RefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.talismans,
    aliasName: $_aliasNameGenerator(db.skills.id, db.talismans.skill2Id),
  );

  $$TalismansTableProcessedTableManager get talismanSkill2Refs {
    final manager = $$TalismansTableTableManager(
      $_db,
      $_db.talismans,
    ).filter((f) => f.skill2Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_talismanSkill2RefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkillsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxLevel => $composableBuilder(
    column: $table.maxLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SkillCategory, SkillCategory, String>
  get type1 => $composableBuilder(
    column: $table.type1,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<SkillSubcategory, SkillSubcategory, String>
  get type2 => $composableBuilder(
    column: $table.type2,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> armorSetSkillsRefs(
    Expression<bool> Function($$ArmorSetSkillsTableFilterComposer f) f,
  ) {
    final $$ArmorSetSkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.armorSetSkills,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetSkillsTableFilterComposer(
            $db: $db,
            $table: $db.armorSetSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jewelsRefs(
    Expression<bool> Function($$JewelsTableFilterComposer f) f,
  ) {
    final $$JewelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jewels,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JewelsTableFilterComposer(
            $db: $db,
            $table: $db.jewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> skillLevelsRefs(
    Expression<bool> Function($$SkillLevelsTableFilterComposer f) f,
  ) {
    final $$SkillLevelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skillLevels,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillLevelsTableFilterComposer(
            $db: $db,
            $table: $db.skillLevels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> talismanSkill1Refs(
    Expression<bool> Function($$TalismansTableFilterComposer f) f,
  ) {
    final $$TalismansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.talismans,
      getReferencedColumn: (t) => t.skill1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TalismansTableFilterComposer(
            $db: $db,
            $table: $db.talismans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> talismanSkill2Refs(
    Expression<bool> Function($$TalismansTableFilterComposer f) f,
  ) {
    final $$TalismansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.talismans,
      getReferencedColumn: (t) => t.skill2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TalismansTableFilterComposer(
            $db: $db,
            $table: $db.talismans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxLevel => $composableBuilder(
    column: $table.maxLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type1 => $composableBuilder(
    column: $table.type1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type2 => $composableBuilder(
    column: $table.type2,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get maxLevel =>
      $composableBuilder(column: $table.maxLevel, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SkillCategory, String> get type1 =>
      $composableBuilder(column: $table.type1, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SkillSubcategory, String> get type2 =>
      $composableBuilder(column: $table.type2, builder: (column) => column);

  Expression<T> armorSetSkillsRefs<T extends Object>(
    Expression<T> Function($$ArmorSetSkillsTableAnnotationComposer a) f,
  ) {
    final $$ArmorSetSkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.armorSetSkills,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetSkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.armorSetSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jewelsRefs<T extends Object>(
    Expression<T> Function($$JewelsTableAnnotationComposer a) f,
  ) {
    final $$JewelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jewels,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JewelsTableAnnotationComposer(
            $db: $db,
            $table: $db.jewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> skillLevelsRefs<T extends Object>(
    Expression<T> Function($$SkillLevelsTableAnnotationComposer a) f,
  ) {
    final $$SkillLevelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skillLevels,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillLevelsTableAnnotationComposer(
            $db: $db,
            $table: $db.skillLevels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> talismanSkill1Refs<T extends Object>(
    Expression<T> Function($$TalismansTableAnnotationComposer a) f,
  ) {
    final $$TalismansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.talismans,
      getReferencedColumn: (t) => t.skill1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TalismansTableAnnotationComposer(
            $db: $db,
            $table: $db.talismans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> talismanSkill2Refs<T extends Object>(
    Expression<T> Function($$TalismansTableAnnotationComposer a) f,
  ) {
    final $$TalismansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.talismans,
      getReferencedColumn: (t) => t.skill2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TalismansTableAnnotationComposer(
            $db: $db,
            $table: $db.talismans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillsTable,
          Skill,
          $$SkillsTableFilterComposer,
          $$SkillsTableOrderingComposer,
          $$SkillsTableAnnotationComposer,
          $$SkillsTableCreateCompanionBuilder,
          $$SkillsTableUpdateCompanionBuilder,
          (Skill, $$SkillsTableReferences),
          Skill,
          PrefetchHooks Function({
            bool armorSetSkillsRefs,
            bool jewelsRefs,
            bool skillLevelsRefs,
            bool talismanSkill1Refs,
            bool talismanSkill2Refs,
          })
        > {
  $$SkillsTableTableManager(_$AppDatabase db, $SkillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> maxLevel = const Value.absent(),
                Value<SkillCategory> type1 = const Value.absent(),
                Value<SkillSubcategory> type2 = const Value.absent(),
              }) => SkillsCompanion(
                id: id,
                slug: slug,
                name: name,
                maxLevel: maxLevel,
                type1: type1,
                type2: type2,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String name,
                required int maxLevel,
                Value<SkillCategory> type1 = const Value.absent(),
                Value<SkillSubcategory> type2 = const Value.absent(),
              }) => SkillsCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                maxLevel: maxLevel,
                type1: type1,
                type2: type2,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SkillsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                armorSetSkillsRefs = false,
                jewelsRefs = false,
                skillLevelsRefs = false,
                talismanSkill1Refs = false,
                talismanSkill2Refs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (armorSetSkillsRefs) db.armorSetSkills,
                    if (jewelsRefs) db.jewels,
                    if (skillLevelsRefs) db.skillLevels,
                    if (talismanSkill1Refs) db.talismans,
                    if (talismanSkill2Refs) db.talismans,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (armorSetSkillsRefs)
                        await $_getPrefetchedData<
                          Skill,
                          $SkillsTable,
                          ArmorSetSkill
                        >(
                          currentTable: table,
                          referencedTable: $$SkillsTableReferences
                              ._armorSetSkillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillsTableReferences(
                                db,
                                table,
                                p0,
                              ).armorSetSkillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.skillId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (jewelsRefs)
                        await $_getPrefetchedData<Skill, $SkillsTable, Jewel>(
                          currentTable: table,
                          referencedTable: $$SkillsTableReferences
                              ._jewelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillsTableReferences(db, table, p0).jewelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.skillId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (skillLevelsRefs)
                        await $_getPrefetchedData<
                          Skill,
                          $SkillsTable,
                          SkillLevel
                        >(
                          currentTable: table,
                          referencedTable: $$SkillsTableReferences
                              ._skillLevelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillsTableReferences(
                                db,
                                table,
                                p0,
                              ).skillLevelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.skillId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (talismanSkill1Refs)
                        await $_getPrefetchedData<
                          Skill,
                          $SkillsTable,
                          Talisman
                        >(
                          currentTable: table,
                          referencedTable: $$SkillsTableReferences
                              ._talismanSkill1RefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillsTableReferences(
                                db,
                                table,
                                p0,
                              ).talismanSkill1Refs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.skill1Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (talismanSkill2Refs)
                        await $_getPrefetchedData<
                          Skill,
                          $SkillsTable,
                          Talisman
                        >(
                          currentTable: table,
                          referencedTable: $$SkillsTableReferences
                              ._talismanSkill2RefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillsTableReferences(
                                db,
                                table,
                                p0,
                              ).talismanSkill2Refs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.skill2Id == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillsTable,
      Skill,
      $$SkillsTableFilterComposer,
      $$SkillsTableOrderingComposer,
      $$SkillsTableAnnotationComposer,
      $$SkillsTableCreateCompanionBuilder,
      $$SkillsTableUpdateCompanionBuilder,
      (Skill, $$SkillsTableReferences),
      Skill,
      PrefetchHooks Function({
        bool armorSetSkillsRefs,
        bool jewelsRefs,
        bool skillLevelsRefs,
        bool talismanSkill1Refs,
        bool talismanSkill2Refs,
      })
    >;
typedef $$ArmorSetSkillsTableCreateCompanionBuilder =
    ArmorSetSkillsCompanion Function({
      Value<int> id,
      required int setId,
      required int requiredPieces,
      required int skillId,
      required int skillLevel,
      required SetSkillType skillCategory,
    });
typedef $$ArmorSetSkillsTableUpdateCompanionBuilder =
    ArmorSetSkillsCompanion Function({
      Value<int> id,
      Value<int> setId,
      Value<int> requiredPieces,
      Value<int> skillId,
      Value<int> skillLevel,
      Value<SetSkillType> skillCategory,
    });

final class $$ArmorSetSkillsTableReferences
    extends BaseReferences<_$AppDatabase, $ArmorSetSkillsTable, ArmorSetSkill> {
  $$ArmorSetSkillsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ArmorSetsTable _setIdTable(_$AppDatabase db) =>
      db.armorSets.createAlias(
        $_aliasNameGenerator(db.armorSetSkills.setId, db.armorSets.id),
      );

  $$ArmorSetsTableProcessedTableManager get setId {
    final $_column = $_itemColumn<int>('set_id')!;

    final manager = $$ArmorSetsTableTableManager(
      $_db,
      $_db.armorSets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_setIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SkillsTable _skillIdTable(_$AppDatabase db) => db.skills.createAlias(
    $_aliasNameGenerator(db.armorSetSkills.skillId, db.skills.id),
  );

  $$SkillsTableProcessedTableManager get skillId {
    final $_column = $_itemColumn<int>('skill_id')!;

    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ArmorSetSkillsTableFilterComposer
    extends Composer<_$AppDatabase, $ArmorSetSkillsTable> {
  $$ArmorSetSkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get requiredPieces => $composableBuilder(
    column: $table.requiredPieces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SetSkillType, SetSkillType, String>
  get skillCategory => $composableBuilder(
    column: $table.skillCategory,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$ArmorSetsTableFilterComposer get setId {
    final $$ArmorSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.armorSets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetsTableFilterComposer(
            $db: $db,
            $table: $db.armorSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableFilterComposer get skillId {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArmorSetSkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArmorSetSkillsTable> {
  $$ArmorSetSkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get requiredPieces => $composableBuilder(
    column: $table.requiredPieces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skillCategory => $composableBuilder(
    column: $table.skillCategory,
    builder: (column) => ColumnOrderings(column),
  );

  $$ArmorSetsTableOrderingComposer get setId {
    final $$ArmorSetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.armorSets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetsTableOrderingComposer(
            $db: $db,
            $table: $db.armorSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableOrderingComposer get skillId {
    final $$SkillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableOrderingComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArmorSetSkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArmorSetSkillsTable> {
  $$ArmorSetSkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get requiredPieces => $composableBuilder(
    column: $table.requiredPieces,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SetSkillType, String> get skillCategory =>
      $composableBuilder(
        column: $table.skillCategory,
        builder: (column) => column,
      );

  $$ArmorSetsTableAnnotationComposer get setId {
    final $$ArmorSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.armorSets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.armorSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableAnnotationComposer get skillId {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArmorSetSkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArmorSetSkillsTable,
          ArmorSetSkill,
          $$ArmorSetSkillsTableFilterComposer,
          $$ArmorSetSkillsTableOrderingComposer,
          $$ArmorSetSkillsTableAnnotationComposer,
          $$ArmorSetSkillsTableCreateCompanionBuilder,
          $$ArmorSetSkillsTableUpdateCompanionBuilder,
          (ArmorSetSkill, $$ArmorSetSkillsTableReferences),
          ArmorSetSkill,
          PrefetchHooks Function({bool setId, bool skillId})
        > {
  $$ArmorSetSkillsTableTableManager(
    _$AppDatabase db,
    $ArmorSetSkillsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArmorSetSkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArmorSetSkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArmorSetSkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> setId = const Value.absent(),
                Value<int> requiredPieces = const Value.absent(),
                Value<int> skillId = const Value.absent(),
                Value<int> skillLevel = const Value.absent(),
                Value<SetSkillType> skillCategory = const Value.absent(),
              }) => ArmorSetSkillsCompanion(
                id: id,
                setId: setId,
                requiredPieces: requiredPieces,
                skillId: skillId,
                skillLevel: skillLevel,
                skillCategory: skillCategory,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int setId,
                required int requiredPieces,
                required int skillId,
                required int skillLevel,
                required SetSkillType skillCategory,
              }) => ArmorSetSkillsCompanion.insert(
                id: id,
                setId: setId,
                requiredPieces: requiredPieces,
                skillId: skillId,
                skillLevel: skillLevel,
                skillCategory: skillCategory,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArmorSetSkillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({setId = false, skillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (setId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.setId,
                                referencedTable: $$ArmorSetSkillsTableReferences
                                    ._setIdTable(db),
                                referencedColumn:
                                    $$ArmorSetSkillsTableReferences
                                        ._setIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (skillId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.skillId,
                                referencedTable: $$ArmorSetSkillsTableReferences
                                    ._skillIdTable(db),
                                referencedColumn:
                                    $$ArmorSetSkillsTableReferences
                                        ._skillIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ArmorSetSkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArmorSetSkillsTable,
      ArmorSetSkill,
      $$ArmorSetSkillsTableFilterComposer,
      $$ArmorSetSkillsTableOrderingComposer,
      $$ArmorSetSkillsTableAnnotationComposer,
      $$ArmorSetSkillsTableCreateCompanionBuilder,
      $$ArmorSetSkillsTableUpdateCompanionBuilder,
      (ArmorSetSkill, $$ArmorSetSkillsTableReferences),
      ArmorSetSkill,
      PrefetchHooks Function({bool setId, bool skillId})
    >;
typedef $$JewelsTableCreateCompanionBuilder =
    JewelsCompanion Function({
      Value<int> id,
      required String slug,
      required String name,
      Value<int> rarity,
      required int slotSize,
      required int skillId,
      required int skillLevel,
    });
typedef $$JewelsTableUpdateCompanionBuilder =
    JewelsCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> name,
      Value<int> rarity,
      Value<int> slotSize,
      Value<int> skillId,
      Value<int> skillLevel,
    });

final class $$JewelsTableReferences
    extends BaseReferences<_$AppDatabase, $JewelsTable, Jewel> {
  $$JewelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillsTable _skillIdTable(_$AppDatabase db) => db.skills.createAlias(
    $_aliasNameGenerator(db.jewels.skillId, db.skills.id),
  );

  $$SkillsTableProcessedTableManager get skillId {
    final $_column = $_itemColumn<int>('skill_id')!;

    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BuildJewelsTable, List<BuildJewel>>
  _buildJewelsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.buildJewels,
    aliasName: $_aliasNameGenerator(db.jewels.id, db.buildJewels.jewelId),
  );

  $$BuildJewelsTableProcessedTableManager get buildJewelsRefs {
    final manager = $$BuildJewelsTableTableManager(
      $_db,
      $_db.buildJewels,
    ).filter((f) => f.jewelId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildJewelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JewelsTableFilterComposer
    extends Composer<_$AppDatabase, $JewelsTable> {
  $$JewelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slotSize => $composableBuilder(
    column: $table.slotSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillsTableFilterComposer get skillId {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> buildJewelsRefs(
    Expression<bool> Function($$BuildJewelsTableFilterComposer f) f,
  ) {
    final $$BuildJewelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.buildJewels,
      getReferencedColumn: (t) => t.jewelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildJewelsTableFilterComposer(
            $db: $db,
            $table: $db.buildJewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JewelsTableOrderingComposer
    extends Composer<_$AppDatabase, $JewelsTable> {
  $$JewelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotSize => $composableBuilder(
    column: $table.slotSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillsTableOrderingComposer get skillId {
    final $$SkillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableOrderingComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JewelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JewelsTable> {
  $$JewelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<int> get slotSize =>
      $composableBuilder(column: $table.slotSize, builder: (column) => column);

  GeneratedColumn<int> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => column,
  );

  $$SkillsTableAnnotationComposer get skillId {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> buildJewelsRefs<T extends Object>(
    Expression<T> Function($$BuildJewelsTableAnnotationComposer a) f,
  ) {
    final $$BuildJewelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.buildJewels,
      getReferencedColumn: (t) => t.jewelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildJewelsTableAnnotationComposer(
            $db: $db,
            $table: $db.buildJewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JewelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JewelsTable,
          Jewel,
          $$JewelsTableFilterComposer,
          $$JewelsTableOrderingComposer,
          $$JewelsTableAnnotationComposer,
          $$JewelsTableCreateCompanionBuilder,
          $$JewelsTableUpdateCompanionBuilder,
          (Jewel, $$JewelsTableReferences),
          Jewel,
          PrefetchHooks Function({bool skillId, bool buildJewelsRefs})
        > {
  $$JewelsTableTableManager(_$AppDatabase db, $JewelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JewelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JewelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JewelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rarity = const Value.absent(),
                Value<int> slotSize = const Value.absent(),
                Value<int> skillId = const Value.absent(),
                Value<int> skillLevel = const Value.absent(),
              }) => JewelsCompanion(
                id: id,
                slug: slug,
                name: name,
                rarity: rarity,
                slotSize: slotSize,
                skillId: skillId,
                skillLevel: skillLevel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String name,
                Value<int> rarity = const Value.absent(),
                required int slotSize,
                required int skillId,
                required int skillLevel,
              }) => JewelsCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                rarity: rarity,
                slotSize: slotSize,
                skillId: skillId,
                skillLevel: skillLevel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$JewelsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({skillId = false, buildJewelsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (buildJewelsRefs) db.buildJewels],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (skillId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.skillId,
                                referencedTable: $$JewelsTableReferences
                                    ._skillIdTable(db),
                                referencedColumn: $$JewelsTableReferences
                                    ._skillIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (buildJewelsRefs)
                    await $_getPrefetchedData<Jewel, $JewelsTable, BuildJewel>(
                      currentTable: table,
                      referencedTable: $$JewelsTableReferences
                          ._buildJewelsRefsTable(db),
                      managerFromTypedResult: (p0) => $$JewelsTableReferences(
                        db,
                        table,
                        p0,
                      ).buildJewelsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.jewelId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$JewelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JewelsTable,
      Jewel,
      $$JewelsTableFilterComposer,
      $$JewelsTableOrderingComposer,
      $$JewelsTableAnnotationComposer,
      $$JewelsTableCreateCompanionBuilder,
      $$JewelsTableUpdateCompanionBuilder,
      (Jewel, $$JewelsTableReferences),
      Jewel,
      PrefetchHooks Function({bool skillId, bool buildJewelsRefs})
    >;
typedef $$SkillLevelsTableCreateCompanionBuilder =
    SkillLevelsCompanion Function({
      Value<int> id,
      required int skillId,
      required int level,
      Value<int?> piecesRequired,
      Value<double?> bonus1Value,
      Value<String?> bonus1Type,
      Value<double?> bonus2Value,
      Value<String?> bonus2Type,
      Value<double?> bonus3Value,
      Value<String?> bonus3Type,
      Value<double?> durationS,
      Value<double?> cooldownS,
    });
typedef $$SkillLevelsTableUpdateCompanionBuilder =
    SkillLevelsCompanion Function({
      Value<int> id,
      Value<int> skillId,
      Value<int> level,
      Value<int?> piecesRequired,
      Value<double?> bonus1Value,
      Value<String?> bonus1Type,
      Value<double?> bonus2Value,
      Value<String?> bonus2Type,
      Value<double?> bonus3Value,
      Value<String?> bonus3Type,
      Value<double?> durationS,
      Value<double?> cooldownS,
    });

final class $$SkillLevelsTableReferences
    extends BaseReferences<_$AppDatabase, $SkillLevelsTable, SkillLevel> {
  $$SkillLevelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillsTable _skillIdTable(_$AppDatabase db) => db.skills.createAlias(
    $_aliasNameGenerator(db.skillLevels.skillId, db.skills.id),
  );

  $$SkillsTableProcessedTableManager get skillId {
    final $_column = $_itemColumn<int>('skill_id')!;

    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SkillLevelsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillLevelsTable> {
  $$SkillLevelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get piecesRequired => $composableBuilder(
    column: $table.piecesRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bonus1Value => $composableBuilder(
    column: $table.bonus1Value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bonus1Type => $composableBuilder(
    column: $table.bonus1Type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bonus2Value => $composableBuilder(
    column: $table.bonus2Value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bonus2Type => $composableBuilder(
    column: $table.bonus2Type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bonus3Value => $composableBuilder(
    column: $table.bonus3Value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bonus3Type => $composableBuilder(
    column: $table.bonus3Type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cooldownS => $composableBuilder(
    column: $table.cooldownS,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillsTableFilterComposer get skillId {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkillLevelsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillLevelsTable> {
  $$SkillLevelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get piecesRequired => $composableBuilder(
    column: $table.piecesRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bonus1Value => $composableBuilder(
    column: $table.bonus1Value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bonus1Type => $composableBuilder(
    column: $table.bonus1Type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bonus2Value => $composableBuilder(
    column: $table.bonus2Value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bonus2Type => $composableBuilder(
    column: $table.bonus2Type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bonus3Value => $composableBuilder(
    column: $table.bonus3Value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bonus3Type => $composableBuilder(
    column: $table.bonus3Type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cooldownS => $composableBuilder(
    column: $table.cooldownS,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillsTableOrderingComposer get skillId {
    final $$SkillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableOrderingComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkillLevelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillLevelsTable> {
  $$SkillLevelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get piecesRequired => $composableBuilder(
    column: $table.piecesRequired,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bonus1Value => $composableBuilder(
    column: $table.bonus1Value,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bonus1Type => $composableBuilder(
    column: $table.bonus1Type,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bonus2Value => $composableBuilder(
    column: $table.bonus2Value,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bonus2Type => $composableBuilder(
    column: $table.bonus2Type,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bonus3Value => $composableBuilder(
    column: $table.bonus3Value,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bonus3Type => $composableBuilder(
    column: $table.bonus3Type,
    builder: (column) => column,
  );

  GeneratedColumn<double> get durationS =>
      $composableBuilder(column: $table.durationS, builder: (column) => column);

  GeneratedColumn<double> get cooldownS =>
      $composableBuilder(column: $table.cooldownS, builder: (column) => column);

  $$SkillsTableAnnotationComposer get skillId {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkillLevelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillLevelsTable,
          SkillLevel,
          $$SkillLevelsTableFilterComposer,
          $$SkillLevelsTableOrderingComposer,
          $$SkillLevelsTableAnnotationComposer,
          $$SkillLevelsTableCreateCompanionBuilder,
          $$SkillLevelsTableUpdateCompanionBuilder,
          (SkillLevel, $$SkillLevelsTableReferences),
          SkillLevel,
          PrefetchHooks Function({bool skillId})
        > {
  $$SkillLevelsTableTableManager(_$AppDatabase db, $SkillLevelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillLevelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillLevelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillLevelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> skillId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int?> piecesRequired = const Value.absent(),
                Value<double?> bonus1Value = const Value.absent(),
                Value<String?> bonus1Type = const Value.absent(),
                Value<double?> bonus2Value = const Value.absent(),
                Value<String?> bonus2Type = const Value.absent(),
                Value<double?> bonus3Value = const Value.absent(),
                Value<String?> bonus3Type = const Value.absent(),
                Value<double?> durationS = const Value.absent(),
                Value<double?> cooldownS = const Value.absent(),
              }) => SkillLevelsCompanion(
                id: id,
                skillId: skillId,
                level: level,
                piecesRequired: piecesRequired,
                bonus1Value: bonus1Value,
                bonus1Type: bonus1Type,
                bonus2Value: bonus2Value,
                bonus2Type: bonus2Type,
                bonus3Value: bonus3Value,
                bonus3Type: bonus3Type,
                durationS: durationS,
                cooldownS: cooldownS,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int skillId,
                required int level,
                Value<int?> piecesRequired = const Value.absent(),
                Value<double?> bonus1Value = const Value.absent(),
                Value<String?> bonus1Type = const Value.absent(),
                Value<double?> bonus2Value = const Value.absent(),
                Value<String?> bonus2Type = const Value.absent(),
                Value<double?> bonus3Value = const Value.absent(),
                Value<String?> bonus3Type = const Value.absent(),
                Value<double?> durationS = const Value.absent(),
                Value<double?> cooldownS = const Value.absent(),
              }) => SkillLevelsCompanion.insert(
                id: id,
                skillId: skillId,
                level: level,
                piecesRequired: piecesRequired,
                bonus1Value: bonus1Value,
                bonus1Type: bonus1Type,
                bonus2Value: bonus2Value,
                bonus2Type: bonus2Type,
                bonus3Value: bonus3Value,
                bonus3Type: bonus3Type,
                durationS: durationS,
                cooldownS: cooldownS,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkillLevelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({skillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (skillId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.skillId,
                                referencedTable: $$SkillLevelsTableReferences
                                    ._skillIdTable(db),
                                referencedColumn: $$SkillLevelsTableReferences
                                    ._skillIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SkillLevelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillLevelsTable,
      SkillLevel,
      $$SkillLevelsTableFilterComposer,
      $$SkillLevelsTableOrderingComposer,
      $$SkillLevelsTableAnnotationComposer,
      $$SkillLevelsTableCreateCompanionBuilder,
      $$SkillLevelsTableUpdateCompanionBuilder,
      (SkillLevel, $$SkillLevelsTableReferences),
      SkillLevel,
      PrefetchHooks Function({bool skillId})
    >;
typedef $$TalismansTableCreateCompanionBuilder =
    TalismansCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> skill1Id,
      Value<int?> skill1Level,
      Value<int?> skill2Id,
      Value<int?> skill2Level,
      Value<String> slots,
      required int createdAt,
    });
typedef $$TalismansTableUpdateCompanionBuilder =
    TalismansCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> skill1Id,
      Value<int?> skill1Level,
      Value<int?> skill2Id,
      Value<int?> skill2Level,
      Value<String> slots,
      Value<int> createdAt,
    });

final class $$TalismansTableReferences
    extends BaseReferences<_$AppDatabase, $TalismansTable, Talisman> {
  $$TalismansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SkillsTable _skill1IdTable(_$AppDatabase db) => db.skills.createAlias(
    $_aliasNameGenerator(db.talismans.skill1Id, db.skills.id),
  );

  $$SkillsTableProcessedTableManager? get skill1Id {
    final $_column = $_itemColumn<int>('skill1_id');
    if ($_column == null) return null;
    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skill1IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SkillsTable _skill2IdTable(_$AppDatabase db) => db.skills.createAlias(
    $_aliasNameGenerator(db.talismans.skill2Id, db.skills.id),
  );

  $$SkillsTableProcessedTableManager? get skill2Id {
    final $_column = $_itemColumn<int>('skill2_id');
    if ($_column == null) return null;
    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skill2IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BuildsTable, List<Build>> _buildsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.builds,
    aliasName: $_aliasNameGenerator(db.talismans.id, db.builds.talismanId),
  );

  $$BuildsTableProcessedTableManager get buildsRefs {
    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.talismanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TalismansTableFilterComposer
    extends Composer<_$AppDatabase, $TalismansTable> {
  $$TalismansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skill1Level => $composableBuilder(
    column: $table.skill1Level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skill2Level => $composableBuilder(
    column: $table.skill2Level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slots => $composableBuilder(
    column: $table.slots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SkillsTableFilterComposer get skill1Id {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skill1Id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableFilterComposer get skill2Id {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skill2Id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> buildsRefs(
    Expression<bool> Function($$BuildsTableFilterComposer f) f,
  ) {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.talismanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TalismansTableOrderingComposer
    extends Composer<_$AppDatabase, $TalismansTable> {
  $$TalismansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skill1Level => $composableBuilder(
    column: $table.skill1Level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skill2Level => $composableBuilder(
    column: $table.skill2Level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slots => $composableBuilder(
    column: $table.slots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkillsTableOrderingComposer get skill1Id {
    final $$SkillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skill1Id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableOrderingComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableOrderingComposer get skill2Id {
    final $$SkillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skill2Id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableOrderingComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TalismansTableAnnotationComposer
    extends Composer<_$AppDatabase, $TalismansTable> {
  $$TalismansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get skill1Level => $composableBuilder(
    column: $table.skill1Level,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skill2Level => $composableBuilder(
    column: $table.skill2Level,
    builder: (column) => column,
  );

  GeneratedColumn<String> get slots =>
      $composableBuilder(column: $table.slots, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SkillsTableAnnotationComposer get skill1Id {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skill1Id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableAnnotationComposer get skill2Id {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skill2Id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> buildsRefs<T extends Object>(
    Expression<T> Function($$BuildsTableAnnotationComposer a) f,
  ) {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.talismanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TalismansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TalismansTable,
          Talisman,
          $$TalismansTableFilterComposer,
          $$TalismansTableOrderingComposer,
          $$TalismansTableAnnotationComposer,
          $$TalismansTableCreateCompanionBuilder,
          $$TalismansTableUpdateCompanionBuilder,
          (Talisman, $$TalismansTableReferences),
          Talisman,
          PrefetchHooks Function({
            bool skill1Id,
            bool skill2Id,
            bool buildsRefs,
          })
        > {
  $$TalismansTableTableManager(_$AppDatabase db, $TalismansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TalismansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TalismansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TalismansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> skill1Id = const Value.absent(),
                Value<int?> skill1Level = const Value.absent(),
                Value<int?> skill2Id = const Value.absent(),
                Value<int?> skill2Level = const Value.absent(),
                Value<String> slots = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => TalismansCompanion(
                id: id,
                name: name,
                skill1Id: skill1Id,
                skill1Level: skill1Level,
                skill2Id: skill2Id,
                skill2Level: skill2Level,
                slots: slots,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> skill1Id = const Value.absent(),
                Value<int?> skill1Level = const Value.absent(),
                Value<int?> skill2Id = const Value.absent(),
                Value<int?> skill2Level = const Value.absent(),
                Value<String> slots = const Value.absent(),
                required int createdAt,
              }) => TalismansCompanion.insert(
                id: id,
                name: name,
                skill1Id: skill1Id,
                skill1Level: skill1Level,
                skill2Id: skill2Id,
                skill2Level: skill2Level,
                slots: slots,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TalismansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({skill1Id = false, skill2Id = false, buildsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (buildsRefs) db.builds],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (skill1Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.skill1Id,
                                    referencedTable: $$TalismansTableReferences
                                        ._skill1IdTable(db),
                                    referencedColumn: $$TalismansTableReferences
                                        ._skill1IdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (skill2Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.skill2Id,
                                    referencedTable: $$TalismansTableReferences
                                        ._skill2IdTable(db),
                                    referencedColumn: $$TalismansTableReferences
                                        ._skill2IdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (buildsRefs)
                        await $_getPrefetchedData<
                          Talisman,
                          $TalismansTable,
                          Build
                        >(
                          currentTable: table,
                          referencedTable: $$TalismansTableReferences
                              ._buildsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TalismansTableReferences(
                                db,
                                table,
                                p0,
                              ).buildsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.talismanId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TalismansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TalismansTable,
      Talisman,
      $$TalismansTableFilterComposer,
      $$TalismansTableOrderingComposer,
      $$TalismansTableAnnotationComposer,
      $$TalismansTableCreateCompanionBuilder,
      $$TalismansTableUpdateCompanionBuilder,
      (Talisman, $$TalismansTableReferences),
      Talisman,
      PrefetchHooks Function({bool skill1Id, bool skill2Id, bool buildsRefs})
    >;
typedef $$BuildsTableCreateCompanionBuilder =
    BuildsCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> weaponId,
      Value<int?> headId,
      Value<int?> chestId,
      Value<int?> armsId,
      Value<int?> waistId,
      Value<int?> legsId,
      Value<int?> talismanId,
      required int createdAt,
      required int updatedAt,
    });
typedef $$BuildsTableUpdateCompanionBuilder =
    BuildsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> weaponId,
      Value<int?> headId,
      Value<int?> chestId,
      Value<int?> armsId,
      Value<int?> waistId,
      Value<int?> legsId,
      Value<int?> talismanId,
      Value<int> createdAt,
      Value<int> updatedAt,
    });

final class $$BuildsTableReferences
    extends BaseReferences<_$AppDatabase, $BuildsTable, Build> {
  $$BuildsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeaponsTable _weaponIdTable(_$AppDatabase db) => db.weapons
      .createAlias($_aliasNameGenerator(db.builds.weaponId, db.weapons.id));

  $$WeaponsTableProcessedTableManager? get weaponId {
    final $_column = $_itemColumn<int>('weapon_id');
    if ($_column == null) return null;
    final manager = $$WeaponsTableTableManager(
      $_db,
      $_db.weapons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_weaponIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArmorPiecesTable _headIdTable(_$AppDatabase db) => db.armorPieces
      .createAlias($_aliasNameGenerator(db.builds.headId, db.armorPieces.id));

  $$ArmorPiecesTableProcessedTableManager? get headId {
    final $_column = $_itemColumn<int>('head_id');
    if ($_column == null) return null;
    final manager = $$ArmorPiecesTableTableManager(
      $_db,
      $_db.armorPieces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_headIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArmorPiecesTable _chestIdTable(_$AppDatabase db) => db.armorPieces
      .createAlias($_aliasNameGenerator(db.builds.chestId, db.armorPieces.id));

  $$ArmorPiecesTableProcessedTableManager? get chestId {
    final $_column = $_itemColumn<int>('chest_id');
    if ($_column == null) return null;
    final manager = $$ArmorPiecesTableTableManager(
      $_db,
      $_db.armorPieces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chestIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArmorPiecesTable _armsIdTable(_$AppDatabase db) => db.armorPieces
      .createAlias($_aliasNameGenerator(db.builds.armsId, db.armorPieces.id));

  $$ArmorPiecesTableProcessedTableManager? get armsId {
    final $_column = $_itemColumn<int>('arms_id');
    if ($_column == null) return null;
    final manager = $$ArmorPiecesTableTableManager(
      $_db,
      $_db.armorPieces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_armsIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArmorPiecesTable _waistIdTable(_$AppDatabase db) => db.armorPieces
      .createAlias($_aliasNameGenerator(db.builds.waistId, db.armorPieces.id));

  $$ArmorPiecesTableProcessedTableManager? get waistId {
    final $_column = $_itemColumn<int>('waist_id');
    if ($_column == null) return null;
    final manager = $$ArmorPiecesTableTableManager(
      $_db,
      $_db.armorPieces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_waistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArmorPiecesTable _legsIdTable(_$AppDatabase db) => db.armorPieces
      .createAlias($_aliasNameGenerator(db.builds.legsId, db.armorPieces.id));

  $$ArmorPiecesTableProcessedTableManager? get legsId {
    final $_column = $_itemColumn<int>('legs_id');
    if ($_column == null) return null;
    final manager = $$ArmorPiecesTableTableManager(
      $_db,
      $_db.armorPieces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_legsIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TalismansTable _talismanIdTable(_$AppDatabase db) => db.talismans
      .createAlias($_aliasNameGenerator(db.builds.talismanId, db.talismans.id));

  $$TalismansTableProcessedTableManager? get talismanId {
    final $_column = $_itemColumn<int>('talisman_id');
    if ($_column == null) return null;
    final manager = $$TalismansTableTableManager(
      $_db,
      $_db.talismans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_talismanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BuildJewelsTable, List<BuildJewel>>
  _buildJewelsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.buildJewels,
    aliasName: $_aliasNameGenerator(db.builds.id, db.buildJewels.buildId),
  );

  $$BuildJewelsTableProcessedTableManager get buildJewelsRefs {
    final manager = $$BuildJewelsTableTableManager(
      $_db,
      $_db.buildJewels,
    ).filter((f) => f.buildId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildJewelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BuildsTableFilterComposer
    extends Composer<_$AppDatabase, $BuildsTable> {
  $$BuildsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WeaponsTableFilterComposer get weaponId {
    final $$WeaponsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weaponId,
      referencedTable: $db.weapons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeaponsTableFilterComposer(
            $db: $db,
            $table: $db.weapons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableFilterComposer get headId {
    final $$ArmorPiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableFilterComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableFilterComposer get chestId {
    final $$ArmorPiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chestId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableFilterComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableFilterComposer get armsId {
    final $$ArmorPiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.armsId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableFilterComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableFilterComposer get waistId {
    final $$ArmorPiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.waistId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableFilterComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableFilterComposer get legsId {
    final $$ArmorPiecesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.legsId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableFilterComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TalismansTableFilterComposer get talismanId {
    final $$TalismansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.talismanId,
      referencedTable: $db.talismans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TalismansTableFilterComposer(
            $db: $db,
            $table: $db.talismans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> buildJewelsRefs(
    Expression<bool> Function($$BuildJewelsTableFilterComposer f) f,
  ) {
    final $$BuildJewelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.buildJewels,
      getReferencedColumn: (t) => t.buildId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildJewelsTableFilterComposer(
            $db: $db,
            $table: $db.buildJewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BuildsTableOrderingComposer
    extends Composer<_$AppDatabase, $BuildsTable> {
  $$BuildsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeaponsTableOrderingComposer get weaponId {
    final $$WeaponsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weaponId,
      referencedTable: $db.weapons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeaponsTableOrderingComposer(
            $db: $db,
            $table: $db.weapons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableOrderingComposer get headId {
    final $$ArmorPiecesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableOrderingComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableOrderingComposer get chestId {
    final $$ArmorPiecesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chestId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableOrderingComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableOrderingComposer get armsId {
    final $$ArmorPiecesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.armsId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableOrderingComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableOrderingComposer get waistId {
    final $$ArmorPiecesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.waistId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableOrderingComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableOrderingComposer get legsId {
    final $$ArmorPiecesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.legsId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableOrderingComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TalismansTableOrderingComposer get talismanId {
    final $$TalismansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.talismanId,
      referencedTable: $db.talismans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TalismansTableOrderingComposer(
            $db: $db,
            $table: $db.talismans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BuildsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BuildsTable> {
  $$BuildsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WeaponsTableAnnotationComposer get weaponId {
    final $$WeaponsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weaponId,
      referencedTable: $db.weapons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeaponsTableAnnotationComposer(
            $db: $db,
            $table: $db.weapons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableAnnotationComposer get headId {
    final $$ArmorPiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableAnnotationComposer get chestId {
    final $$ArmorPiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chestId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableAnnotationComposer get armsId {
    final $$ArmorPiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.armsId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableAnnotationComposer get waistId {
    final $$ArmorPiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.waistId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArmorPiecesTableAnnotationComposer get legsId {
    final $$ArmorPiecesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.legsId,
      referencedTable: $db.armorPieces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArmorPiecesTableAnnotationComposer(
            $db: $db,
            $table: $db.armorPieces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TalismansTableAnnotationComposer get talismanId {
    final $$TalismansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.talismanId,
      referencedTable: $db.talismans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TalismansTableAnnotationComposer(
            $db: $db,
            $table: $db.talismans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> buildJewelsRefs<T extends Object>(
    Expression<T> Function($$BuildJewelsTableAnnotationComposer a) f,
  ) {
    final $$BuildJewelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.buildJewels,
      getReferencedColumn: (t) => t.buildId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildJewelsTableAnnotationComposer(
            $db: $db,
            $table: $db.buildJewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BuildsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BuildsTable,
          Build,
          $$BuildsTableFilterComposer,
          $$BuildsTableOrderingComposer,
          $$BuildsTableAnnotationComposer,
          $$BuildsTableCreateCompanionBuilder,
          $$BuildsTableUpdateCompanionBuilder,
          (Build, $$BuildsTableReferences),
          Build,
          PrefetchHooks Function({
            bool weaponId,
            bool headId,
            bool chestId,
            bool armsId,
            bool waistId,
            bool legsId,
            bool talismanId,
            bool buildJewelsRefs,
          })
        > {
  $$BuildsTableTableManager(_$AppDatabase db, $BuildsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BuildsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BuildsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BuildsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> weaponId = const Value.absent(),
                Value<int?> headId = const Value.absent(),
                Value<int?> chestId = const Value.absent(),
                Value<int?> armsId = const Value.absent(),
                Value<int?> waistId = const Value.absent(),
                Value<int?> legsId = const Value.absent(),
                Value<int?> talismanId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => BuildsCompanion(
                id: id,
                name: name,
                weaponId: weaponId,
                headId: headId,
                chestId: chestId,
                armsId: armsId,
                waistId: waistId,
                legsId: legsId,
                talismanId: talismanId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> weaponId = const Value.absent(),
                Value<int?> headId = const Value.absent(),
                Value<int?> chestId = const Value.absent(),
                Value<int?> armsId = const Value.absent(),
                Value<int?> waistId = const Value.absent(),
                Value<int?> legsId = const Value.absent(),
                Value<int?> talismanId = const Value.absent(),
                required int createdAt,
                required int updatedAt,
              }) => BuildsCompanion.insert(
                id: id,
                name: name,
                weaponId: weaponId,
                headId: headId,
                chestId: chestId,
                armsId: armsId,
                waistId: waistId,
                legsId: legsId,
                talismanId: talismanId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BuildsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                weaponId = false,
                headId = false,
                chestId = false,
                armsId = false,
                waistId = false,
                legsId = false,
                talismanId = false,
                buildJewelsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (buildJewelsRefs) db.buildJewels,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (weaponId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.weaponId,
                                    referencedTable: $$BuildsTableReferences
                                        ._weaponIdTable(db),
                                    referencedColumn: $$BuildsTableReferences
                                        ._weaponIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (headId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.headId,
                                    referencedTable: $$BuildsTableReferences
                                        ._headIdTable(db),
                                    referencedColumn: $$BuildsTableReferences
                                        ._headIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (chestId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.chestId,
                                    referencedTable: $$BuildsTableReferences
                                        ._chestIdTable(db),
                                    referencedColumn: $$BuildsTableReferences
                                        ._chestIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (armsId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.armsId,
                                    referencedTable: $$BuildsTableReferences
                                        ._armsIdTable(db),
                                    referencedColumn: $$BuildsTableReferences
                                        ._armsIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (waistId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.waistId,
                                    referencedTable: $$BuildsTableReferences
                                        ._waistIdTable(db),
                                    referencedColumn: $$BuildsTableReferences
                                        ._waistIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (legsId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.legsId,
                                    referencedTable: $$BuildsTableReferences
                                        ._legsIdTable(db),
                                    referencedColumn: $$BuildsTableReferences
                                        ._legsIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (talismanId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.talismanId,
                                    referencedTable: $$BuildsTableReferences
                                        ._talismanIdTable(db),
                                    referencedColumn: $$BuildsTableReferences
                                        ._talismanIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (buildJewelsRefs)
                        await $_getPrefetchedData<
                          Build,
                          $BuildsTable,
                          BuildJewel
                        >(
                          currentTable: table,
                          referencedTable: $$BuildsTableReferences
                              ._buildJewelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BuildsTableReferences(
                                db,
                                table,
                                p0,
                              ).buildJewelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.buildId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BuildsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BuildsTable,
      Build,
      $$BuildsTableFilterComposer,
      $$BuildsTableOrderingComposer,
      $$BuildsTableAnnotationComposer,
      $$BuildsTableCreateCompanionBuilder,
      $$BuildsTableUpdateCompanionBuilder,
      (Build, $$BuildsTableReferences),
      Build,
      PrefetchHooks Function({
        bool weaponId,
        bool headId,
        bool chestId,
        bool armsId,
        bool waistId,
        bool legsId,
        bool talismanId,
        bool buildJewelsRefs,
      })
    >;
typedef $$BuildJewelsTableCreateCompanionBuilder =
    BuildJewelsCompanion Function({
      Value<int> id,
      required int buildId,
      required JewelSlotSource slotSource,
      required int slotIndex,
      required int jewelId,
    });
typedef $$BuildJewelsTableUpdateCompanionBuilder =
    BuildJewelsCompanion Function({
      Value<int> id,
      Value<int> buildId,
      Value<JewelSlotSource> slotSource,
      Value<int> slotIndex,
      Value<int> jewelId,
    });

final class $$BuildJewelsTableReferences
    extends BaseReferences<_$AppDatabase, $BuildJewelsTable, BuildJewel> {
  $$BuildJewelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BuildsTable _buildIdTable(_$AppDatabase db) => db.builds.createAlias(
    $_aliasNameGenerator(db.buildJewels.buildId, db.builds.id),
  );

  $$BuildsTableProcessedTableManager get buildId {
    final $_column = $_itemColumn<int>('build_id')!;

    final manager = $$BuildsTableTableManager(
      $_db,
      $_db.builds,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buildIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $JewelsTable _jewelIdTable(_$AppDatabase db) => db.jewels.createAlias(
    $_aliasNameGenerator(db.buildJewels.jewelId, db.jewels.id),
  );

  $$JewelsTableProcessedTableManager get jewelId {
    final $_column = $_itemColumn<int>('jewel_id')!;

    final manager = $$JewelsTableTableManager(
      $_db,
      $_db.jewels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jewelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BuildJewelsTableFilterComposer
    extends Composer<_$AppDatabase, $BuildJewelsTable> {
  $$BuildJewelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<JewelSlotSource, JewelSlotSource, String>
  get slotSource => $composableBuilder(
    column: $table.slotSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$BuildsTableFilterComposer get buildId {
    final $$BuildsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildId,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableFilterComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JewelsTableFilterComposer get jewelId {
    final $$JewelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jewelId,
      referencedTable: $db.jewels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JewelsTableFilterComposer(
            $db: $db,
            $table: $db.jewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BuildJewelsTableOrderingComposer
    extends Composer<_$AppDatabase, $BuildJewelsTable> {
  $$BuildJewelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slotSource => $composableBuilder(
    column: $table.slotSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$BuildsTableOrderingComposer get buildId {
    final $$BuildsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildId,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableOrderingComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JewelsTableOrderingComposer get jewelId {
    final $$JewelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jewelId,
      referencedTable: $db.jewels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JewelsTableOrderingComposer(
            $db: $db,
            $table: $db.jewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BuildJewelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BuildJewelsTable> {
  $$BuildJewelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<JewelSlotSource, String> get slotSource =>
      $composableBuilder(
        column: $table.slotSource,
        builder: (column) => column,
      );

  GeneratedColumn<int> get slotIndex =>
      $composableBuilder(column: $table.slotIndex, builder: (column) => column);

  $$BuildsTableAnnotationComposer get buildId {
    final $$BuildsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildId,
      referencedTable: $db.builds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildsTableAnnotationComposer(
            $db: $db,
            $table: $db.builds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JewelsTableAnnotationComposer get jewelId {
    final $$JewelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jewelId,
      referencedTable: $db.jewels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JewelsTableAnnotationComposer(
            $db: $db,
            $table: $db.jewels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BuildJewelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BuildJewelsTable,
          BuildJewel,
          $$BuildJewelsTableFilterComposer,
          $$BuildJewelsTableOrderingComposer,
          $$BuildJewelsTableAnnotationComposer,
          $$BuildJewelsTableCreateCompanionBuilder,
          $$BuildJewelsTableUpdateCompanionBuilder,
          (BuildJewel, $$BuildJewelsTableReferences),
          BuildJewel,
          PrefetchHooks Function({bool buildId, bool jewelId})
        > {
  $$BuildJewelsTableTableManager(_$AppDatabase db, $BuildJewelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BuildJewelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BuildJewelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BuildJewelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> buildId = const Value.absent(),
                Value<JewelSlotSource> slotSource = const Value.absent(),
                Value<int> slotIndex = const Value.absent(),
                Value<int> jewelId = const Value.absent(),
              }) => BuildJewelsCompanion(
                id: id,
                buildId: buildId,
                slotSource: slotSource,
                slotIndex: slotIndex,
                jewelId: jewelId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int buildId,
                required JewelSlotSource slotSource,
                required int slotIndex,
                required int jewelId,
              }) => BuildJewelsCompanion.insert(
                id: id,
                buildId: buildId,
                slotSource: slotSource,
                slotIndex: slotIndex,
                jewelId: jewelId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BuildJewelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({buildId = false, jewelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (buildId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.buildId,
                                referencedTable: $$BuildJewelsTableReferences
                                    ._buildIdTable(db),
                                referencedColumn: $$BuildJewelsTableReferences
                                    ._buildIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (jewelId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.jewelId,
                                referencedTable: $$BuildJewelsTableReferences
                                    ._jewelIdTable(db),
                                referencedColumn: $$BuildJewelsTableReferences
                                    ._jewelIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BuildJewelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BuildJewelsTable,
      BuildJewel,
      $$BuildJewelsTableFilterComposer,
      $$BuildJewelsTableOrderingComposer,
      $$BuildJewelsTableAnnotationComposer,
      $$BuildJewelsTableCreateCompanionBuilder,
      $$BuildJewelsTableUpdateCompanionBuilder,
      (BuildJewel, $$BuildJewelsTableReferences),
      BuildJewel,
      PrefetchHooks Function({bool buildId, bool jewelId})
    >;
typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String tableNameCol,
      Value<int> lastVersion,
      Value<int?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> tableNameCol,
      Value<int> lastVersion,
      Value<int?> lastSyncedAt,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tableNameCol => $composableBuilder(
    column: $table.tableNameCol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastVersion => $composableBuilder(
    column: $table.lastVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tableNameCol => $composableBuilder(
    column: $table.tableNameCol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastVersion => $composableBuilder(
    column: $table.lastVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tableNameCol => $composableBuilder(
    column: $table.tableNameCol,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastVersion => $composableBuilder(
    column: $table.lastVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTable,
          SyncMetadataData,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataData,
            BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
          ),
          SyncMetadataData,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tableNameCol = const Value.absent(),
                Value<int> lastVersion = const Value.absent(),
                Value<int?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(
                tableNameCol: tableNameCol,
                lastVersion: lastVersion,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tableNameCol,
                Value<int> lastVersion = const Value.absent(),
                Value<int?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                tableNameCol: tableNameCol,
                lastVersion: lastVersion,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTable,
      SyncMetadataData,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataData,
        BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
      ),
      SyncMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WeaponsTableTableManager get weapons =>
      $$WeaponsTableTableManager(_db, _db.weapons);
  $$ArmorSetsTableTableManager get armorSets =>
      $$ArmorSetsTableTableManager(_db, _db.armorSets);
  $$ArmorPiecesTableTableManager get armorPieces =>
      $$ArmorPiecesTableTableManager(_db, _db.armorPieces);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db, _db.skills);
  $$ArmorSetSkillsTableTableManager get armorSetSkills =>
      $$ArmorSetSkillsTableTableManager(_db, _db.armorSetSkills);
  $$JewelsTableTableManager get jewels =>
      $$JewelsTableTableManager(_db, _db.jewels);
  $$SkillLevelsTableTableManager get skillLevels =>
      $$SkillLevelsTableTableManager(_db, _db.skillLevels);
  $$TalismansTableTableManager get talismans =>
      $$TalismansTableTableManager(_db, _db.talismans);
  $$BuildsTableTableManager get builds =>
      $$BuildsTableTableManager(_db, _db.builds);
  $$BuildJewelsTableTableManager get buildJewels =>
      $$BuildJewelsTableTableManager(_db, _db.buildJewels);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
}
