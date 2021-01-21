import 'dart:convert' show json;


class InitInfoBean {
  DoctorBean doctor;
  List<RecordOperationsBean> recordOperations;
  List<PlanBean> plans;
  AdviceBean advice;
  Object assistant;
  UserBean user;

  InitInfoBean({
    this.doctor,
    this.recordOperations,
    this.plans,
    this.advice,
    this.assistant,
    this.user,
  });

  static InitInfoBean fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<RecordOperationsBean> recordOperations =
        jsonRes['recordOperations'] is List ? [] : null;
    if (recordOperations != null) {
      for (var item in jsonRes['recordOperations']) {
        if (item != null) {
          recordOperations.add(RecordOperationsBean.fromJson(item));
        }
      }
    }

    List<PlanBean> plans = jsonRes['plans'] is List ? [] : null;
    if (plans != null) {
      for (var item in jsonRes['plans']) {
        if (item != null) {
          plans.add(PlanBean.fromJson(item));
        }
      }
    }
    return InitInfoBean(
      doctor: DoctorBean.fromJson(jsonRes['doctor']),
      recordOperations: recordOperations,
      plans: plans,
      advice: AdviceBean.fromJson(jsonRes['advice']),
      assistant: jsonRes['assistant'],
      user: UserBean.fromJson(jsonRes['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'doctor': doctor,
        'recordOperations': recordOperations,
        'plans': plans,
        'advice': advice,
        'assistant': assistant,
        'user': user,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DoctorBean {
  String organizationId;
  String organizationShowId;
  String organizationName;
  String departmentId;
  String departmentName;
  String id;
  String showId;
  String name;
  String title;
  String avatar;

  DoctorBean({
    this.organizationId,
    this.organizationShowId,
    this.organizationName,
    this.departmentId,
    this.departmentName,
    this.id,
    this.showId,
    this.name,
    this.title,
    this.avatar,
  });

  static DoctorBean fromJson(jsonRes) => jsonRes == null
      ? null
      : DoctorBean(
          organizationId: jsonRes['organizationId'],
          organizationShowId: jsonRes['organizationShowId'],
          organizationName: jsonRes['organizationName'],
          departmentId: jsonRes['departmentId'],
          departmentName: jsonRes['departmentName'],
          id: jsonRes['id'],
          showId: jsonRes['showId'],
          name: jsonRes['name'],
          title: jsonRes['title'],
          avatar: jsonRes['avatar'],
        );

  Map<String, dynamic> toJson() => {
        'organizationId': organizationId,
        'organizationShowId': organizationShowId,
        'organizationName': organizationName,
        'departmentId': departmentId,
        'departmentName': departmentName,
        'id': id,
        'showId': showId,
        'name': name,
        'title': title,
        'avatar': avatar,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class RecordOperationsBean {
  String medicineId;
  String medicineName;
  String planId;
  int takeTime;
  int count;
  int dosage;
  int status;
  int source;
  int confirmedAt;

  RecordOperationsBean({
    this.medicineId,
    this.medicineName,
    this.planId,
    this.takeTime,
    this.count,
    this.dosage,
    this.status,
    this.source,
    this.confirmedAt,
  });

  static RecordOperationsBean fromJson(jsonRes) => jsonRes == null
      ? null
      : RecordOperationsBean(
          medicineId: jsonRes['medicineId'],
          medicineName: jsonRes['medicineName'],
          planId: jsonRes['planId'],
          takeTime: jsonRes['takeTime'],
          count: jsonRes['count'],
          dosage: jsonRes['dosage'],
          status: jsonRes['status'],
          source: jsonRes['source'],
          confirmedAt: jsonRes['confirmedAt'],
        );

  Map<String, dynamic> toJson() => {
        'medicineId': medicineId,
        'medicineName': medicineName,
        'planId': planId,
        'takeTime': takeTime,
        'count': count,
        'dosage': dosage,
        'status': status,
        'source': source,
        'confirmedAt': confirmedAt,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class PlanBean {
  String id;
  int takeAt;
  String medicineId;
  String medicineName;
  String category;
  String medicineHash;
  int medicineVia;
  int count;
  int dosage;
  int cycleDays;
  int zone;
  int positionNo;
  String dosageUnit;
  int started;
  Object ended;
  int remindFirstAt;
  Object clinicalProjectId;
  Object boxUuid;
  int planSeqWithBox;
  String dosageFormUnit;
  String commodityName;
  String ingredient;
  String isUnknown;
  Object imageId;

  PlanBean({
    this.id,
    this.takeAt,
    this.medicineId,
    this.medicineName,
    this.category,
    this.medicineHash,
    this.medicineVia,
    this.count,
    this.dosage,
    this.cycleDays,
    this.zone,
    this.positionNo,
    this.dosageUnit,
    this.started,
    this.ended,
    this.remindFirstAt,
    this.clinicalProjectId,
    this.boxUuid,
    this.planSeqWithBox,
    this.dosageFormUnit,
    this.commodityName,
    this.ingredient,
    this.isUnknown,
    this.imageId,
  });

  static PlanBean fromJson(jsonRes) => jsonRes == null
      ? null
      : PlanBean(
          id: jsonRes['id'],
          takeAt: jsonRes['takeAt'],
          medicineId: jsonRes['medicineId'],
          medicineName: jsonRes['medicineName'],
          category: jsonRes['category'],
          medicineHash: jsonRes['medicineHash'],
          medicineVia: jsonRes['medicineVia'],
          count: jsonRes['count'],
          dosage: jsonRes['dosage'],
          cycleDays: jsonRes['cycleDays'],
          zone: jsonRes['zone'],
          positionNo: jsonRes['positionNo'],
          dosageUnit: jsonRes['dosageUnit'],
          started: jsonRes['started'],
          ended: jsonRes['ended'],
          remindFirstAt: jsonRes['remindFirstAt'],
          clinicalProjectId: jsonRes['clinicalProjectId'],
          boxUuid: jsonRes['boxUuid'],
          planSeqWithBox: jsonRes['planSeqWithBox'],
          dosageFormUnit: jsonRes['dosageFormUnit'],
          commodityName: jsonRes['commodityName'],
          ingredient: jsonRes['ingredient'],
          isUnknown: jsonRes['isUnknown'],
          imageId: jsonRes['imageId'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'takeAt': takeAt,
        'medicineId': medicineId,
        'medicineName': medicineName,
        'category': category,
        'medicineHash': medicineHash,
        'medicineVia': medicineVia,
        'count': count,
        'dosage': dosage,
        'cycleDays': cycleDays,
        'zone': zone,
        'positionNo': positionNo,
        'dosageUnit': dosageUnit,
        'started': started,
        'ended': ended,
        'remindFirstAt': remindFirstAt,
        'clinicalProjectId': clinicalProjectId,
        'boxUuid': boxUuid,
        'planSeqWithBox': planSeqWithBox,
        'dosageFormUnit': dosageFormUnit,
        'commodityName': commodityName,
        'ingredient': ingredient,
        'isUnknown': isUnknown,
        'imageId': imageId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class AdviceBean {
  String id;
  int createdAt;
  String sender;
  String receiver;
  ContentBean content;
  Object status;
  DoctorInfoBean doctorInfo;

  AdviceBean({
    this.id,
    this.createdAt,
    this.sender,
    this.receiver,
    this.content,
    this.status,
    this.doctorInfo,
  });

  static AdviceBean fromJson(jsonRes) => jsonRes == null
      ? null
      : AdviceBean(
          id: jsonRes['id'],
          createdAt: jsonRes['createdAt'],
          sender: jsonRes['sender'],
          receiver: jsonRes['receiver'],
          content: ContentBean.fromJson(jsonRes['content']),
          status: jsonRes['status'],
          doctorInfo: DoctorInfoBean.fromJson(jsonRes['doctorInfo']),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'sender': sender,
        'receiver': receiver,
        'content': content,
        'status': status,
        'doctorInfo': doctorInfo,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ContentBean {
  int type;
  DataBean data;

  ContentBean({
    this.type,
    this.data,
  });

  static ContentBean fromJson(jsonRes) => jsonRes == null
      ? null
      : ContentBean(
          type: jsonRes['type'],
          data: DataBean.fromJson(jsonRes['data']),
        );

  Map<String, dynamic> toJson() => {
        'type': type,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DataBean {
  int type;
  String content;
  Object entrustment;
  Object medicineSupplement;
  Object inspectionStandards;

  DataBean({
    this.type,
    this.content,
    this.entrustment,
    this.medicineSupplement,
    this.inspectionStandards,
  });

  static DataBean fromJson(jsonRes) => jsonRes == null
      ? null
      : DataBean(
          type: jsonRes['type'],
          content: jsonRes['content'],
          entrustment: jsonRes['entrustment'],
          medicineSupplement: jsonRes['medicineSupplement'],
          inspectionStandards: jsonRes['inspectionStandards'],
        );

  Map<String, dynamic> toJson() => {
        'type': type,
        'content': content,
        'entrustment': entrustment,
        'medicineSupplement': medicineSupplement,
        'inspectionStandards': inspectionStandards,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DoctorInfoBean {
  String organizationId;
  Object organizationShowId;
  Object organizationName;
  Object departmentId;
  Object departmentName;
  String id;
  Object showId;
  String name;
  String title;
  String avatar;

  DoctorInfoBean({
    this.organizationId,
    this.organizationShowId,
    this.organizationName,
    this.departmentId,
    this.departmentName,
    this.id,
    this.showId,
    this.name,
    this.title,
    this.avatar,
  });

  static DoctorInfoBean fromJson(jsonRes) => jsonRes == null
      ? null
      : DoctorInfoBean(
          organizationId: jsonRes['organizationId'],
          organizationShowId: jsonRes['organizationShowId'],
          organizationName: jsonRes['organizationName'],
          departmentId: jsonRes['departmentId'],
          departmentName: jsonRes['departmentName'],
          id: jsonRes['id'],
          showId: jsonRes['showId'],
          name: jsonRes['name'],
          title: jsonRes['title'],
          avatar: jsonRes['avatar'],
        );

  Map<String, dynamic> toJson() => {
        'organizationId': organizationId,
        'organizationShowId': organizationShowId,
        'organizationName': organizationName,
        'departmentId': departmentId,
        'departmentName': departmentName,
        'id': id,
        'showId': showId,
        'name': name,
        'title': title,
        'avatar': avatar,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class UserBean {
  String name;
  String area;
  String address;
  String avatar;
  String tel;
  int birthday;
  int sex;
  int status;
  int type;
  String height;
  String weight;
  String waistline;
  int marriage;
  int education;
  int showId;
  String expireTimeType;
  String qrCodeUrl;
  List<BindingDoctorBean> bindingDoctor;
  Object bank;
  Object bankCardNumber;
  String idCard;
  String ethnicity;
  String realName;
  String idCardUrl;
  List<String> photo;
  String realStatus;
  String wechatBindStatus;

  UserBean({
    this.name,
    this.area,
    this.address,
    this.avatar,
    this.tel,
    this.birthday,
    this.sex,
    this.status,
    this.type,
    this.height,
    this.weight,
    this.waistline,
    this.marriage,
    this.education,
    this.showId,
    this.expireTimeType,
    this.qrCodeUrl,
    this.bindingDoctor,
    this.bank,
    this.bankCardNumber,
    this.idCard,
    this.ethnicity,
    this.realName,
    this.idCardUrl,
    this.photo,
    this.realStatus,
    this.wechatBindStatus,
  });

  static UserBean fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<BindingDoctorBean> bindingDoctor =
        jsonRes['bindingDoctor'] is List ? [] : null;
    if (bindingDoctor != null) {
      for (var item in jsonRes['bindingDoctor']) {
        if (item != null) {
          bindingDoctor.add(BindingDoctorBean.fromJson(item));
        }
      }
    }

    List<String> photo = jsonRes['photo'] is List ? [] : null;
    if (photo != null) {
      for (var item in jsonRes['photo']) {
        if (item != null) {
          photo.add(item);
        }
      }
    }
    return UserBean(
      name: jsonRes['name'],
      area: jsonRes['area'],
      address: jsonRes['address'],
      avatar: jsonRes['avatar'],
      tel: jsonRes['tel'],
      birthday: jsonRes['birthday'],
      sex: jsonRes['sex'],
      status: jsonRes['status'],
      type: jsonRes['type'],
      height: jsonRes['height'],
      weight: jsonRes['weight'],
      waistline: jsonRes['waistline'],
      marriage: jsonRes['marriage'],
      education: jsonRes['education'],
      showId: jsonRes['showId'],
      expireTimeType: jsonRes['expireTimeType'],
      qrCodeUrl: jsonRes['qrCodeUrl'],
      bindingDoctor: bindingDoctor,
      bank: jsonRes['bank'],
      bankCardNumber: jsonRes['bankCardNumber'],
      idCard: jsonRes['idCard'],
      ethnicity: jsonRes['ethnicity'],
      realName: jsonRes['realName'],
      idCardUrl: jsonRes['idCardUrl'],
      photo: photo,
      realStatus: jsonRes['realStatus'],
      wechatBindStatus: jsonRes['wechatBindStatus'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'area': area,
        'address': address,
        'avatar': avatar,
        'tel': tel,
        'birthday': birthday,
        'sex': sex,
        'status': status,
        'type': type,
        'height': height,
        'weight': weight,
        'waistline': waistline,
        'marriage': marriage,
        'education': education,
        'showId': showId,
        'expireTimeType': expireTimeType,
        'qrCodeUrl': qrCodeUrl,
        'bindingDoctor': bindingDoctor,
        'bank': bank,
        'bankCardNumber': bankCardNumber,
        'idCard': idCard,
        'ethnicity': ethnicity,
        'realName': realName,
        'idCardUrl': idCardUrl,
        'photo': photo,
        'realStatus': realStatus,
        'wechatBindStatus': wechatBindStatus,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class BindingDoctorBean {
  String doctorId;

  BindingDoctorBean({
    this.doctorId,
  });

  static BindingDoctorBean fromJson(jsonRes) => jsonRes == null
      ? null
      : BindingDoctorBean(
          doctorId: jsonRes['doctorId'],
        );

  Map<String, dynamic> toJson() => {
        'doctorId': doctorId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
