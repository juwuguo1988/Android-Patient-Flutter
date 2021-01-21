import 'package:patient/model/health_message_new_bean.dart';
import 'package:patient/services/api/health_message.dart';
import 'package:patient/ui/page_index.dart';

class HealthMessageProvider with ChangeNotifier {
  bool loaded = false;
  List<HealthNewBean> healthNewsBean = [];

  void setHealthMessageInfo(List<HealthNewBean> beans) {
    healthNewsBean.addAll(beans);
    loaded = true;
    notifyListeners();
  }

  void removeAll() {
    healthNewsBean.clear();
    loaded = false;
    notifyListeners();
  }

  getHealthMessageInfo() async {
    HealthNewsBean res = await HealthMessageApi().getHealthMessageInfo();
    setHealthMessageInfo(res.news);
  }
}
