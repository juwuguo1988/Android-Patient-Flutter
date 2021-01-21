
import 'package:patient/http/entity/medic/medic_plan_model.dart';
import 'package:patient/components/business/medic_business.dart';

import 'package:patient/model/medic/medic_list_cell_model.dart';

enum XZLTakeMedicineListCellStyle {
  XZLTakeMedicineListCellListStyle, // 服药单列表
  XZLTakeMedicineListCellHistoryListStyle, // 历史记录
  XZLTakeMedicineListCellDoctorMessageListStyle, //医生调药单
  XZLTakeMedicineListCellAdjustTreatmentStyle //调整治疗方案
}

class XZLTakeMedicineListGroupModel {

  XZLTakeMedicineListCellStyle cellStyle;
  double currentWidthScale;
  int groupIndex;
  String medicineName;
  String strength;//单位规格 xxmg
  String footerContent;//

  int pillBoxPostionIndex;
  List cellModelsArray = List();
  List medicineInfoModelArr = List();

  double _header_footer_h;  // readonly
  XZLTakeMedicineListFooterModel footerModel;


  double get header_footer_h{
    return _header_footer_h;
  }

  void addAPlanDataItem(Plans originalDataModel) {

    List arr = [originalDataModel];

    for (Plans plan in arr) {

      String unit;
      if (originalDataModel.dosageUnit == "other") {

        unit = "";
      } else {

        unit = originalDataModel.dosageUnit;
      }

      var planDosage = MedicBusiness().getPlanDosage(plan);

      medicineInfoModelArr.add(plan);

      strength = originalDataModel.count.toString();

      footerContent = originalDataModel.commodityName.isNotEmpty ? originalDataModel.commodityName : originalDataModel.medicineName;

      // 识别仓号
      String positionNo;
      if(originalDataModel.isPillBoxTakeMedicinePlan()) {

        pillBoxPostionIndex = 1000;
        positionNo = "仓外";
      } else {

        pillBoxPostionIndex = originalDataModel.positionNo.toInt();
        positionNo = originalDataModel.positionNo.toString();
      }

      // 相同药物，需要按照不同剂量进行分行显示，开始处理按剂量分类
      XZLTakeMedicineListCellModel cellModel;
      if (cellStyle == XZLTakeMedicineListCellStyle.XZLTakeMedicineListCellHistoryListStyle) {


      } else {

        cellModel = isHadSameRecordItem(planDosage);
      }


    }


  }

  /// 判断是否已经有相同的剂量的记录添加到分组模型中
  XZLTakeMedicineListCellModel isHadSameRecordItem(String dosage) {

    if(cellModelsArray.isNotEmpty) {

      XZLTakeMedicineListCellModel targetCellModel;
      for(XZLTakeMedicineListCellModel eachCellModel in cellModelsArray) {
        
        if(eachCellModel.dosage == dosage) {
          targetCellModel = eachCellModel;
          break;
        }
      }
      return targetCellModel;
    } else {
      
      return null;
    }
  }

}

class XZLTakeMedicineListFooterModel {

  String displayContent;
  double contentF;
  double footerH;

  void layoutDisplaySubviewsWithModel(XZLTakeMedicineListGroupModel groupModel) {


  }
}