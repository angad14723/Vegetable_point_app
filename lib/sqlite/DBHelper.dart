import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vegetable_point/podo/AddressData.dart';

class DBHelper {

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'address.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE address (id INTEGER PRIMARY KEY, houseNo TEXT, locality TEXT, areaName TEXT, city TEXT, state TEXT, pinCode TEXT,homeOffice TEXT,isSelected INTEGER)');
  }

  Future<AddressData> add(AddressData addressData) async {
    var dbClient = await db;
    addressData.id = await dbClient.insert('address', addressData.toMap());

    print("entrySuccess");

    return addressData;
  }

  Future<List<AddressData>> getAddress() async {

    var dbClient = await db;

    List<Map> maps = await dbClient.query('address', columns: [
      'id',
      'houseNo',
      'locality',
      'areaName',
      'city',
      'state',
      'pinCode',
      'homeOffice',
      'isSelected'
    ]);

    List<AddressData> address = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        address.add(AddressData.fromMap(maps[i]));

        print("addressMap ${maps[i]}");
      }
    }
    return address;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'address',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(AddressData addressData) async {
    var dbClient = await db;
    return await dbClient.update(
      'address',
      addressData.toMap(),
      where: 'id = ?',
      whereArgs: [addressData.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
