import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDbHelepr {
  var Noted_Table = "Noted";
  var Colum_Note_Id = "Noted_id";
  var Colum_Note_Title = "title";
  var Colum_Note_Desc = "desc";

  Future<Database> openDb() async {
    var mDircetory = await getApplicationDocumentsDirectory();
    await mDircetory.create(recursive: true);

    var dbPath = "$mDircetory/notedb.db";

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        var createTableQuery =
            "Create Table $Noted_Table($Colum_Note_Id integer Primart key, $Colum_Note_Title text, $Colum_Note_Desc text)";
        db.execute(createTableQuery);
      },
    );
  }

  Future<bool> AddData(String title, String desc, String date, String time) async {
    var db = await openDb();
    var check = await db
        .insert(Noted_Table, {Colum_Note_Title: title, Colum_Note_Desc: desc});
    return check > 0;
  }

  Future<List<Map<String, dynamic>>> feacthAllNoteData()async{
    var db = await openDb();
   List<Map<String, dynamic>> notes = await db.query(Noted_Table);
    return notes;
  }

  Future<bool> UpdateData(int id, String title, String desc) async {
    var db = await openDb();
    var check = await db.update(
        Noted_Table, {Colum_Note_Title: title, Colum_Note_Desc: desc},
        where: "$Colum_Note_Desc= '$id'");
    return check > 0;
  }

  Future<bool> deletData(int id) async {
    var db = await openDb();
    var check = await db
        .delete(Noted_Table, where: "$Colum_Note_Id= ?", whereArgs: ["$id"]);
    return check > 0;
  }
}
