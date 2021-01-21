import 'package:flui/flui.dart';
import 'package:patient/model/health_message_new_bean.dart';
import 'package:patient/provider/health_message.dart';
import 'package:patient/ui/page_index.dart';

class HealthMessageUI extends StatefulWidget {
  _HealthMessageUIState createState() => _HealthMessageUIState();
}

class _HealthMessageUIState extends State<HealthMessageUI>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
  }

  Future _getHealthMessageInfo(context) async {
    bool loaded = Provider.of<HealthMessageProvider>(context).loaded;
    if (!loaded) {
      try {
        await Provider.of<HealthMessageProvider>(context, listen: false)
            .getHealthMessageInfo();
      } catch (e) {
        print(e);
      }
    }
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getHealthMessageInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            HealthMessageProvider provider =
                Provider.of<HealthMessageProvider>(context);
            List<HealthNewBean> healthNewsBeans = provider.healthNewsBean;
            return Container(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: healthNewsBeans.length,
                itemBuilder: (context, index) {
                  return _healthMessageListWidget(healthNewsBeans, index);
                },
              ),
            );
          } else {
            return FLEmptyContainer(
              showLoading: true,
              title: '健康资讯加载中...',
            );
          }
        },
      ),
    );
  }

  Widget _healthMessageListWidget(List newList, int index) {
    return Container(
      width: 375.w,
      height: 138.h,
      padding: EdgeInsets.only(left: 15.w, top: 5.w, right: 15.w, bottom: 5.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      //垂直方向
      child: new GestureDetector(
        onTap: () {
          Application.navigateToWithParams(
            context,
            "/web_view",
            params: {
              'title': "健康资讯",
              'url': newList[index].url,
            },
          );
        },
        child: Column(
          children: <Widget>[
            Container(
              child: _centerArea(newList, index),
            ),
            Container(
              padding: EdgeInsets.only(top: 12.w),
              child: _bottomArea(newList, index),
            )
          ],
        ),
      ),
    );
  }

  Widget _centerArea(List newList, int index) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 12,
          child: Column(
            children: <Widget>[
              Text(
                newList[index].title,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.only(top: 8.w),
                child: Text(
                  newList[index].digest,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.network(
                newList[index].imageThumbUrl,
                height: 87.h,
                width: 105.w,
                fit: BoxFit.fitWidth,
              )),
        ),
      ],
    );
  }

  Widget _bottomArea(List newList, int index) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 12,
          child: Text(
            DateUtil.formatDateMs(newList[index].updateTime,
                format: DataFormats.full),
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "查看",
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ),
      ],
    );
  }
}
