

import 'dart:convert' show json;

import 'package:sprintf/sprintf.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' show json;
import 'package:path/path.dart';

import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/http/entity/medic/medic_record_operation.dart';
import 'package:patient/common/database/base_database.dart';

class DataBaseHelper {


  //region 所有表格定义在此处

  ///  服药计划表名
  final XZL_TAKE_MEDICINE_PLAN_TABLE_NAME =
      "xzl_take_medicine_plan";

  ///  服药记录表名
  final XZL_TAKE_MEDICINE_RECORD_TABLE_NAME =
      "xzl_take_medicine_record";

  //endregion


  ///  初始化用户 相关的的所有表
  initUserDBTableWithUserId(String userId) async {
    if (userId.isNotEmpty) {
      List<String> tableList = List();
      tableList.add(XZL_TAKE_MEDICINE_PLAN_TABLE_NAME);
      tableList.add(XZL_TAKE_MEDICINE_RECORD_TABLE_NAME);

      BaseDataBaseHelper.openDatabaseWithUserName(userId, tableList);
    }
  }


  ///  清空 所有数据库保存信息
  void clearUserDBTable() {


  }


  //region 服药计划业务处理

  /// 添加一条服药计划 [Plans].
  void insertOneTakeMedicinePlanModel(Plans takeMedicinePlanModel) async {
    DQUniversalDBDataModel model = BaseDataBaseHelper
        .getOneUniversalDBDataModel(
        takeMedicinePlanModel.id,
        takeMedicinePlanModel,
        takeMedicinePlanModel.runtimeType,
        takeMedicinePlanModel.started.toString(),
        "",
        "",
        takeMedicinePlanModel.takeAt.toString(),
        takeMedicinePlanModel.planSeqWithBox,
        "");

    BaseDataBaseHelper.insertUniversalDataModel(
        model, XZL_TAKE_MEDICINE_PLAN_TABLE_NAME);
  }

  /// 查询所有服药计划
  Future<List<Plans>> queryAllTakeMedicinePlanModels() async {
    List<Plans> planList = List();

    List resultList = await BaseDataBaseHelper
        .earchAllUniversalDataModelFromTable(XZL_TAKE_MEDICINE_PLAN_TABLE_NAME);
    resultList.forEach((val) {
      DQUniversalDBDataModel model = val;
      Map map = json.decode(model.json);
      Plans plan = Plans.fromJson(map);
      planList.add(plan);
    });
    return planList;
  }

  /// 清空所有服药计划
  void clearAllTakeMedicinePlanModels() {
    BaseDataBaseHelper.clearTable(XZL_TAKE_MEDICINE_PLAN_TABLE_NAME);
  }

  /// 清空所有药盒的服药数据
  void clearAllPillBoxTakeMedicinePlans() async {
    List<Plans> planList = await queryAllTakeMedicinePlanModels();
    List<Plans> deleteList = List();
    planList.forEach((val) {
      if (val.isPillBoxTakeMedicinePlan()) {
        deleteList.add(val);
      }
    });

    _deleteMultipleTakePlanMedicineModels(deleteList);
  }

  void _deleteMultipleTakePlanMedicineModels(List<Plans> planModels) {
    if (planModels.isEmpty) {
      return;
    }

    List<String> idList = List();
    planModels.forEach((val) {
      idList.add(val.id);
    });
    BaseDataBaseHelper.deleteUniversalDatasByIds(
        idList, XZL_TAKE_MEDICINE_PLAN_TABLE_NAME);
  }

  //endregion


  //region 服药记录业务处理

  /// 添加一条服药记录 [Operations].
  void insertTakeMedicineRecordModel(Operations operations) {
    DQUniversalDBDataModel model = BaseDataBaseHelper
        .getOneUniversalDBDataModel(
        "${operations.planId} + ${operations.takeTime.toString()}",
        operations,
        operations.runtimeType,
        operations.takeTime.toString(),
        "",
        "",
        "",
        "",
        "");

    BaseDataBaseHelper.insertUniversalDataModel(
        model, XZL_TAKE_MEDICINE_RECORD_TABLE_NAME);
  }

  /// 清空所有服药记录.
  void clearAllTakeMedicineRecordModels() {
    BaseDataBaseHelper.clearTable(XZL_TAKE_MEDICINE_RECORD_TABLE_NAME);
  }

  /// 查询所有服药记录.
  Future<List<Operations>> queryAllTakeMedicineRecordModels() async {
    List<Operations> operationsList = List();

    List resultList = await BaseDataBaseHelper
        .earchAllUniversalDataModelFromTable(
        XZL_TAKE_MEDICINE_RECORD_TABLE_NAME);
    resultList.forEach((val) {
      DQUniversalDBDataModel model = val;
      Map map = json.decode(model.json);
      Operations operations = Operations.fromJson(map);
      operationsList.add(operations);
    });
    return operationsList;
  }

//endregion



}


