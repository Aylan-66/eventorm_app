import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:eventorm_app/models/cart.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'eventcart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE eventcart(
          id INTEGER PRIMARY KEY,
          event_id INTEGER,
          ticket_name VARCHAR(50),
          ticket_qty INTEGER
      )
      ''');
  }

  /*
  * ,
      CREATE TABLE Ticket(
          Id INTEGER PRIMARY KEY,
          CartId INTEGER,
          name VARCHAR(50),
    	  qty INTEGER,
     FOREIGN KEY (CartId) REFERENCES Cart(Id)
      )
  * */

  Future<List<Cart>> getGroceries() async {
    Database db = await instance.database;
    var cart = await db.query('eventcart', orderBy: 'id');
    List<Cart> groceryList = cart.isNotEmpty
        ? cart.map((c) => Cart.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<List<Cart>> getByCartId(id) async {
    Database db = await instance.database;
    var cart = await db.query('eventcart', where: 'id', whereArgs: [id]);
    List<Cart> groceryList = cart.isNotEmpty
        ? cart.map((c) => Cart.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<List<Cart>> getByEventId(id) async {
    Database db = await instance.database;
    var cart = await db.query('eventcart', where: 'event_id = $id');
    List<Cart> groceryList = cart.isNotEmpty
        ? cart.map((c) => Cart.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<List<dynamic>> getDistincEvent() async {
    Database db = await instance.database;
    var count = [];
    count = await db.rawQuery("SELECT DISTINCT event_id FROM `eventcart`");
    return count;
  }

  Future<int> add(Cart cart) async {
    Database db = await instance.database;
    return await db.insert('eventcart', cart.toMap());
  }

  Future<int> MultipleAdd(Map<dynamic, dynamic> pro) async {
    Database db = await instance.database;
    for(var i = 0; i < pro.length; i++) {
      Cart cart = Cart.fromMap(pro[i]);
      var cartindex = await db.rawQuery(
          "SELECT * FROM `eventcart`" +
          " WHERE event_id = " + cart.eventId.toString() +
          " AND ticket_name = '" + cart.ticketName.toString() + "'"
      );
      if(cartindex.length == 0 && cart.ticketQty > 0)  {
        await DatabaseHelper.instance.add(cart);
        print("added");
      }
    }
    return 0;

  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('eventcart', where: 'event_id = ?', whereArgs: [id]);
  }

  Future<int> update(Cart grocery) async {
    Database db = await instance.database;
    return await db.update('eventcart', grocery.toMap(),
        where: "id = ?", whereArgs: [grocery.eventId]);
  }
}