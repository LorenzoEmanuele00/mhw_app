import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database.dart';
import '../../../core/database/tables/enums.dart';
import '../../../core/providers/database_provider.dart';

class ArmorRepository {
  final AppDatabase _db;
  ArmorRepository(this._db);

  Stream<List<ArmorPiece>> watchAll() => _db.armorDao.watchAll();

  Stream<List<ArmorPiece>> watchBySlot(ArmorSlotType slotType) =>
      _db.armorDao.watchBySlot(slotType);

  Future<ArmorPiece?> getById(int id) => _db.armorDao.getById(id);

  Future<ArmorPiece?> getBySlug(String slug) => _db.armorDao.getBySlug(slug);

  Future<List<ArmorSetSkill>> getSetSkills(int setId) =>
      _db.armorDao.getSetSkills(setId);

  Future<List<({Skill skill, int level})>> getPieceSkills(int armorPieceId) =>
      _db.armorDao.getPieceSkills(armorPieceId);
}

final armorRepositoryProvider = Provider<ArmorRepository>((ref) {
  return ArmorRepository(ref.watch(databaseProvider));
});

final allArmorProvider = StreamProvider<List<ArmorPiece>>((ref) {
  return ref.watch(armorRepositoryProvider).watchAll();
});

final armorBySlotProvider =
    StreamProvider.family<List<ArmorPiece>, ArmorSlotType>((ref, slot) {
  return ref.watch(armorRepositoryProvider).watchBySlot(slot);
});

final armorPieceSkillsProvider =
    FutureProvider.family<List<({Skill skill, int level})>, int>((ref, pieceId) {
  return ref.watch(armorRepositoryProvider).getPieceSkills(pieceId);
});
