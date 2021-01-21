import 'package:patient/ui/page_index.dart';
import 'package:patient/components/flutter_picker/flutter_picker.dart';

class DatetimePicker {
  BuildContext context;
  DatetimePicker(
    this.context,
  );
  void showPickerDateTime() {
    Picker picker = Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kYMDHM,
          isNumberMonth: true,
          yearSuffix: "年",
          monthSuffix: "月",
          daySuffix: "日",
          maxValue: DateTime.now(),
          value: Provider.of<DatetimeProvider>(context, listen: false).datetime,
          minuteInterval: 1,
          minHour: 0,
          maxHour: 23,
          // twoDigitYear: true,
        ),
        height: 180.h,
        itemExtent: 60.h,
        cancel: Container(),
        confirm: Container(
          height: 50.h,
          margin: EdgeInsets.only(right: 15.w),
          width: 22.w,
          child: InkWell(
              onTap: () {
                _resetDatetimeProvider(context);
                Navigator.pop<List<int>>(context, null);
              },
              child: Icon(
                Icons.close,
                size: 22.w,
                color: Color(0xff666666),
              )),
        ),
        title: Container(
            padding: EdgeInsets.only(bottom: 5.h),
            margin: EdgeInsets.only(top: 5.h),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1.h, color: AppColors.themeColor),
            )),
            child: _datetimeConsumerProvider((datetime, datetimeStr) {
              return Text(datetimeStr,
                  style: TextStyle(
                    color: AppColors.themeColor,
                    fontSize: 18.sp,
                    height: 1,
                  ));
            })),
        textAlign: TextAlign.right,
        selectedTextStyle: TextStyle(color: Colors.blue),
        delimiter: [
          PickerDelimiter(
              column: 4,
              child: Container(
                width: 16.0,
                alignment: Alignment.center,
                child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
                color: Colors.white,
              ))
        ],
        footer: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _resetDatetimeProvider(context);
                  Navigator.pop<List<int>>(context, null);
                },
                child: Container(
                    width: 188.w,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text("取消",
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 16.sp,
                          height: 1,
                        ))),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop<List<int>>(context, null);
                },
                child: Container(
                    width: 187.w,
                    color: AppColors.themeColor,
                    alignment: Alignment.center,
                    child: Text("确定",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          height: 1,
                        ))),
              ),
            ],
          ),
        ),
        onSelect: (Picker picker, int index, List<int> selecteds) {
          Provider.of<DatetimeProvider>(context, listen: false)
              .setDatetime(DateTime.parse(picker.adapter.toString()));
        });
    picker.showModal(context);
  }

  _datetimeConsumerProvider<T>(widgetCallback) {
    return Consumer<DatetimeProvider>(builder: (context, datetimeProvider, _) {
      DateTime datetime = datetimeProvider.datetime ?? DateTime.now();
      String datetimeStr = DateUtil.formatDateStr(datetime.toString(),
          format: DataFormats.zh_y_mo_d_hm);
      return widgetCallback(datetime, datetimeStr);
    });
  }

  void _resetDatetimeProvider(BuildContext context) {
    Provider.of<DatetimeProvider>(context, listen: false)
        .setDatetime(DateTime.now());
  }
}
