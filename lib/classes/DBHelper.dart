import 'package:contactsapp/classes/Contact.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  String dbname;
  String tableName;

  Database database;

  DBHelper() {
    this.dbname = "mycontacts.db";
    this.tableName = "contacts";
  }

  Future openConnection() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath + this.dbname;

    await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) {
        this.database = db;
        print("Database already open!");
      },
      onCreate: (Database db, int version) async {
        String sql = "CREATE TABLE " + this.tableName + "(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phoneno TEXT)";
        await db.execute(sql);

        this.database = db;

        print('New database and table were created!');
      },
    );
  }

  Future endConnection() async {
    await this.database.close().then((value) {
      print("Connection with database closed!");
    });
  }

  Future addNewContact(Contact contact) async {
    var database = this.database;

    int id = contact.id;
    String fullname = contact.fullname.toString();
    String email = contact.email.toString();
    String phoneno = contact.phoneno.toString();

    await database.transaction((txn) async {
      await txn.insert(this.tableName, {
        'id': id,
        'name': fullname,
        'email': email,
        'phoneno': phoneno,
      }).then((value) {
        print('Contact successfully saved!');
      });
    });
  }

  Future fetchAllContacts() async {
    Database database = this.database;

    await database.query(
      this.tableName,
      columns: ['id', 'name', 'email', 'phoneno'],
    ).then((value) {
      print(value.toString());
    });
  }

  Future deleteContact(Contact contact) async {
    Database database = this.database;

    await database.delete(
      this.tableName,
      where: 'id = ' + contact.id.toString(),
    ).then((value) {
      print('Record Deleted!');
    });
  }

}