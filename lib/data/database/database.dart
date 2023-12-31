import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Places extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text()();

  TextColumn get name => text()();

  TextColumn get latitude => text()();

  TextColumn get longitude => text()();

  TextColumn get description => text()();
}

class Images extends Table {
  IntColumn get id => integer().autoIncrement()();

  BlobColumn get data => blob()();

  IntColumn get placeId => integer().references(Places, #id)();
}

@DriftDatabase(
  tables: [Places, Images],
)
class PlacesDatabase extends _$PlacesDatabase {
  PlacesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase.createInBackground(file);
    },
  );
}
