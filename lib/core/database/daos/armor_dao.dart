import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/game_tables.dart';
import '../tables/enums.dart';

part 'armor_dao.g.dart';

@DriftAccessor(tables: [ArmorPieces, ArmorSets, ArmorSetSkills])
class ArmorDao extends DatabaseAccessor<AppDatabase> with _$ArmorDaoMixin {
  ArmorDao(super.db);

  Stream<List<ArmorPiece>> watchBySlot(ArmorSlotType slotType) =>
      (select(armorPieces)
            ..where((a) => a.slotType.equals(slotType.name)))
          .watch();

  Stream<List<ArmorPiece>> watchAll() => select(armorPieces).watch();

  Future<ArmorPiece?> getById(String id) =>
      (select(armorPieces)..where((a) => a.id.equals(id))).getSingleOrNull();

  Future<List<ArmorSetSkill>> getSetSkills(String setId) =>
      (select(armorSetSkills)..where((s) => s.setId.equals(setId))).get();

  Future<void> replaceAllPieces(List<ArmorPiecesCompanion> rows) =>
      transaction(() async {
        await delete(armorPieces).go();
        await batch((b) => b.insertAll(armorPieces, rows));
      });

  Future<void> replaceAllSets(List<ArmorSetsCompanion> rows) =>
      transaction(() async {
        await delete(armorSets).go();
        await batch((b) => b.insertAll(armorSets, rows));
      });
}
