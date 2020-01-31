import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

 final String contactTable = "contactTable";
  final String idColumn = "idColumn";
  final String nameColumn = "nameColumn";
  final String emailColumn = "emailColumn";
  final String phoneColumn = "phoneColumn";
  final String imageColumn = "imageColumn";

class ContactHelper {

  static final _databaseName = "contacts.db";
  static final _databaseVersion = 1;
   
  // torna a classe singleton
  ContactHelper._privateConstructor();
  static final ContactHelper instance = ContactHelper._privateConstructor();

  // tem somente uma referencia ao banco de dados;    
  static Database _db;

  Future<Database> get db async {    
    if (_db != null)
      return _db;
    
    _db = await _initDb();
    return _db;    
  }

  _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);   
  }

  Future _onCreate(Database db, int version) async {
     await db.execute('''
         CREATE TABLE $contactTable 
        (
          $idColumn INTEGER PRIMARY KEY, 
          $nameColumn TEXT, 
          $emailColumn TEXT,
          $phoneColumn TEXT,
          $imageColumn TEXT
        )
        '''
      );
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await instance.db;    
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await instance.db;

    List<Map> maps = await dbContact.query(
      contactTable, 
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imageColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );

    if (maps.length > 0) 
      return Contact.fromMap(maps.first);
    
    return null;
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await instance.db;
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await instance.db;
    return await dbContact.update(contactTable, contact.toMap(), where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await instance.db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();

    for(Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }

    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await instance.db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT count(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await instance.db;
    dbContact.close();
  }
}

class Contact {

  int id;
  String name;
  String email;
  String phone;
  String image;

  Contact();

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    image = map[imageColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imageColumn: image
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
  
  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, image: $image)";
  }

}