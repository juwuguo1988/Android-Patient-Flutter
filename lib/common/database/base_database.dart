import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';
import 'package:patient/common/database/base_database.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' show json;


class BaseDataBaseHelper {


  final XZL_APP_USER_DB = "XZL_APP_USER_DB";
  final updateId = "id";
  final updateObject = "json";
  final updateJsonClassName = "jsonClassName";
  final updateCreatedTime = "createdTime";
  final updateType = "type";
  final updatePosition = "position";
  final updateText1  = "text1";
  final updateText2  = "text2";
  final updateText3  = "text3";


  //region 所有SQL语句
  /// 创建一个可以存储json字符串的通用型表的SQL
  static final CREATE_A_UNIVERSAL_DATA_STORE_TABLE_SQL =
      "CREATE TABLE IF NOT EXISTS %s (id TEXT NOT NULL PRIMARY KEY UNIQUE ON CONFLICT REPLACE, json TEXT , jsonClassName TEXT , createdTime Text, type TEXT, position TEXT, text1 TEXT, text2 TEXT, text3 TEXT)";

  ///  插入 (直接覆盖)一个通用型数据
  static final INSERT_A_UNIVERSAL_DATA_SQL =
      'INSERT INTO %s(id, json, jsonClassName, createdTime, type, position, text1, text2, text3) VALUES(?,?,?,?,?,?,?,?,?)';


  ///  按照条件删除
  static final DELETE_UNIVERSAL_ITEMS_CONDITION_SQL =
      "DELETE from %s where %s";

  ///  删除一个
  static final DELETE_UNIVERSAL_ITEM_SQL =
      "DELETE from %s where id = ?";

  ///  删除一组
  static final DELETE_UNIVERSAL_ITEMS_SQL =
      "DELETE from %s where id in ( %s )";

  ///  删除时间最早的一条数据
  static final DELETE_LAST_UNIVERSAL_ITEM_SQL =
      "DELETE from %@ where id = (select id from %@ order by createdTime) ";

  ///  清空表
  static final CLEAR_ALL_UNIVERSA_TABLE_SQL =
      "DELETE from %s";

  ///  修改和更新
  static final UPDATE_ONE_UNIVERSA_ITEM_CONDITON_SQL =
      "UPDATE %s set %s = ? WHERE id = ?";

  ///  查询
  static final SELECT_WITH_SEARCH_CONDITION_SQL = "SELECT * from ";

  ///  统计和条件
  static final SELECT_ID_DEFINED_COUNT_SQL =
      "SELECT count(id) as count from %s";

  ///  拼接时间的sql
  static final SELECT_MOSAIC_TIME_SQL =
      "order by createdTime desc, position  desc";

  ///  拼接降序sql
  static final ORDER_BY_DESC = "order by %s desc";

  ///  升序排列
  static final SORT_ASC = "ASC";

  ///  降序排列
  static final SORT_DESC = "DESC";

  //endregion

  static Database database;


  //region 数据库表格方法

  static void openDatabaseWithUserName(String userId, List<String> tableNames) async {
//    if // 如果是已经登录的
    String userdb = userId + ".db";
    String path = join(await getDatabasesPath(), userdb);

    database = await openDatabase(

      path,
      onCreate: (db, version) async {
        database = db;
        for (var tablename in tableNames) {
          _createCustomTableWithName(tablename);
        }
      },
      version: 1,
    );
  }

  static Future<List<DQUniversalDBDataModel>> earchAllUniversalDataModelFromTable(String tableName) {

    String sql = SELECT_WITH_SEARCH_CONDITION_SQL + tableName;
    return searchUniversalDataModels(sql, tableName);
  }

  static Future<List<DQUniversalDBDataModel>> searchUniversalDataModels(String sql,String tableName) async {

    if (!_isExistTableName(tableName)) {

      _createTable(sql,tableName);
    }
    // 执行查询语句

    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return DQUniversalDBDataModel(
        itemId: maps[i]['itemId'],
        json: maps[i]['json'],
        jsonClassName: maps[i]['jsonClassName'],
        createdTime: maps[i]['createdTime'],
        type: maps[i]['type'],
        position: maps[i]['position'],
        text1: maps[i]['text1'],
        text2: maps[i]['text2'],
        text3: maps[i]['text3'],
      );
    });
  }

  static void _createCustomTableWithName(String tableName) {

    String sql = sprintf(CREATE_A_UNIVERSAL_DATA_STORE_TABLE_SQL,[tableName]);
    _createTable(sql, tableName);
  }

  static bool _isExistTableName(String tableName) {

    return false;
  }

  static void _createTable(String sql,String tableName) async {

    database.execute(sql);
  }

  static void clearTable(String tableName) {

    String sql = sprintf(CLEAR_ALL_UNIVERSA_TABLE_SQL,[tableName]);
    database.execute(sql);
  }

//endregion

  //region 通用模型增删改查

  static void insertUniversalDataModel(DQUniversalDBDataModel universalData,String tableName) async {

    await _insertUniversalData(universalData.itemId, universalData.json,
        universalData.jsonClassName, universalData.createdTime, universalData.type,
        universalData.position, universalData.text1, universalData.text2,universalData. text3,
        0, tableName);
  }

  static void _insertUniversalData(String itemId,String jsonStr,String jsonClassName,String createdTime,
      String type,String position,String text1,String text2,String text3, int maxCount,String tableName) async {

    String sql = sprintf(INSERT_A_UNIVERSAL_DATA_SQL,[tableName]);
    int id = await database.rawInsert(sql,[itemId,jsonStr,jsonClassName,createdTime,type,position,text1,text2,text3]);
  }

  static DQUniversalDBDataModel getOneUniversalDBDataModel(String dataId,Object dataObj,Type dataObjClass,String time,
      String type, String position, String text1, String text2, String text3) {

    String planStr = json.encode(dataObj);

    DQUniversalDBDataModel model = DQUniversalDBDataModel(itemId: dataId, json: planStr,jsonClassName: dataObjClass.toString(),
        createdTime: DateTime.now().toString(),type: type,text1: text1,text2: text2,text3: text3);
    return model;
  }

  static bool deleteUniversalDatasByIds(List<String> idList, String tableName) {

    String stringBuilder = "";
    idList.forEach((val) {

      if(stringBuilder.length == 0) {

        stringBuilder += " '${val}' ";
      } else {

        stringBuilder += ", '${val}' ";
      }
    });

    String sql = sprintf(DELETE_UNIVERSAL_ITEMS_SQL,[tableName,stringBuilder]);
    database.execute(sql);
  }
//endregion
}


class FMDatabase {


}

class DQUniversalDBDataModel {

  String itemId;//注意当status为success和fail时，都是在请求响应成功的回调中
  String json;//

  String jsonClassName;//
  String createdTime;//
  String type;//
  String position;//
  String text1;//
  String text2;//
  String text3;//

  DQUniversalDBDataModel({this.itemId, this.json, this.jsonClassName, this.createdTime,
    this.type, this.position, this.text1, this.text2, this.text3});
}

