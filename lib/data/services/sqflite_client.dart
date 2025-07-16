import 'dart:io';

import 'package:ngsfer_wishlist/data/dtos/item_dto.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite/sqflite.dart';

const dbName = 'ngsfer_wishlist.db';

class SqfliteClient {
  static final SqfliteClient _sqfliteClient = SqfliteClient._internal();

  SqfliteClient._internal();
  factory SqfliteClient() => _sqfliteClient;

  // Não consumir _dbConnection diretamente. Em vez disso, obter conexão
  // a partir de _getDbConnection, que garante que a conexão foi inicializada.
  Database? _dbConnection;

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE item (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, notes TEXT, price INTEGER);',
    );
  }

  Future<void> _init() async {
    try {
      await Directory(await getDatabasesPath()).create(recursive: true);
    } catch (_) {}
    _dbConnection = await openDatabase(
      dbName,
      version: 1,
      onCreate: _onCreate,
      onDowngrade: onDatabaseDowngradeDelete,
      singleInstance: true,
    );
  }

  Future<Database> _getDbConnection() async {
    if (_dbConnection == null) {
      await _init();
    }
    return _dbConnection!;
  }

  Future<Result<List<ItemDto>>> getItems() async {
    try {
      final itemsMap = await (await _getDbConnection()).query(
        'item',
        columns: ['id', 'name', 'notes', 'price'],
      );
      return Success(
        itemsMap.map((itemMap) => ItemDto.fromMap(itemMap)).toList(),
      );
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Unit>> addItem(ItemDto itemDto) async {
    try {
      await (await _getDbConnection()).insert('item', itemDto.toMap());
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Unit>> deleteItem(int id) async {
    try {
      await (await _getDbConnection()).delete(
        'item',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<ItemDto>> getItemById(int id) async {
    try {
      final itemMap = await (await _getDbConnection()).query(
        'item',
        columns: ['id', 'name', 'notes', 'price'],
        where: 'id = ?',
        whereArgs: [id],
      );
      if (itemMap.isEmpty) {
        return Failure(Exception('Item não encontrado'));
      }
      return Success(ItemDto.fromMap(itemMap.first));
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
