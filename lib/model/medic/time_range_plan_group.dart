
import 'package:patient/http/entity/medic/medic_plan_model.dart';

// 在startTime和endTime内有效的所有计划
class TimeRangePlanGroup {

  final int startTime;
  final int endTime;

  List<Plans> plans;

  TimeRangePlanGroup(this.startTime, this.endTime, this.plans);
}

// 有time时间点吃药的所有计划
class TimePlanGroup {

  final String time;

  List<Plans> plans;

  TimePlanGroup(this.time, this.plans);
}

// 有time时间点还未吃药的所有计划
class TimeUnTakePlanGroup {

  final int time;

  List<Plans> plans;

  TimeUnTakePlanGroup(this.time, this.plans);
}
