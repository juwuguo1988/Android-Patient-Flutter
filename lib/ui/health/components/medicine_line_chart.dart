import 'package:patient/ui/page_index.dart';
import 'package:fl_chart/fl_chart.dart';

class MedicineLineChart extends StatefulWidget {
  final List<List<FlSpot>> spotsArray;
  final List<String> xAxis;
  final List<String> status;
  final List<int> extraLines;
  MedicineLineChart({
    @required this.spotsArray,
    @required this.xAxis,
    @required this.status,
    @required this.extraLines,
  });
  _MedicineLineChartState createState() => _MedicineLineChartState();
}

class _MedicineLineChartState extends State<MedicineLineChart> {

  var lineChartColor = Color(0xfff1f1f1);

  var chartTitleStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColors.helpText,
    height: 1,
  );


  HorizontalLine _createExternalHLine(double lineNum) {
    return HorizontalLine(
      y: lineNum,
      color: Color.fromRGBO(197, 210, 214, 1),
      strokeWidth: 1,
      dashArray: [5, 5],
      label: HorizontalLineLabel(
        show: true,
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(left: -(35.w), bottom: -(8.h)),
        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        labelResolver: (line) => '${line.y.toInt()}',
      ),
    );
  }

  LineChartBarData _createLineChatBarData(List<FlSpot> spots, List<int> xAxisIndex) {
    return LineChartBarData(
      showingIndicators: xAxisIndex,
      barWidth: 2, // 折线图折线宽度
      spots: spots,
      colors: [lineChartColor], //多个颜色会有渐变效果
      isCurved: true, //平滑曲线，一般配合curveSmoothness使用
      curveSmoothness: 0,
      isStepLineChart: false,
      dotData: FlDotData(
          show: true,
          dotSize: 3,
          strokeWidth: 0,
          showText: true,
          getTextStyle: (FlSpot spot) {
            return TextStyle(color: Colors.green);
          },
          getStrokeColor: (FlSpot spot, double xPercentage, LineChartBarData bar) {
            return Colors.red;
          },
          getDotColor: (FlSpot _, double xPercentage, LineChartBarData bar) {
            return Colors.red;
          }
        ),
    );
  }

  LineChart _chartChild() {
    List<int> spotsNum = [];
    widget.spotsArray.forEach((item) {
      item.forEach((spot) {
        spotsNum.add(spot.y.toInt());
      });
    });
    spotsNum.addAll(widget.extraLines);
    int yAxisMax = ArrayUtil.getArrMaxNum(spotsNum);
    int yAxisMin = ArrayUtil.getArrMinNum(spotsNum);
    List<int> xAxisIndex = widget.xAxis.asMap().keys.toList();
    List<LineChartBarData> lineBarsData = widget.spotsArray.asMap().keys.map((index) {
      return _createLineChatBarData(widget.spotsArray[index], xAxisIndex);
    }).toList();

    return LineChart(LineChartData(
      maxY: yAxisMax.toDouble(),
      minY: yAxisMin.toDouble(),
      titlesData: FlTitlesData(
        //标题
        // Y轴
        leftTitles: SideTitles(
          //左侧标题
            margin: 15.w,
            showTitles: true, //展示标题
            reservedSize: 15, //标题宽度（不足会换行）
            textStyle: chartTitleStyle, //标题样式
//            interval: 7,
            getTitles: (val) {
              return null;
            }
        ),
        // X轴
        bottomTitles: SideTitles(
          //底部标题
          margin: 20.h,
          showTitles: true, //展示标题
          textStyle: chartTitleStyle,
          getTitles: (val) {
//            print("val $val");
            var dateString = widget.xAxis[val.toInt() - 1];
            return dateString;
          },
        ),
      ),
      lineBarsData: lineBarsData,
      borderData: FlBorderData(
        show: false,
      ),
      extraLinesData: ExtraLinesData(
        extraLinesOnTop: true,
        horizontalLines: widget.extraLines.map((line) {
          return _createExternalHLine(line.toDouble());
        }).toList(),
        verticalLines: [],
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
        verticalInterval: 3
      ),
//      showingTooltipIndicators: xAxisIndex.map((index) {
//        return ShowingTooltipIndicators(index, lineBarsData.asMap().keys.map((idx) {
//          return LineBarSpot(
//              lineBarsData[idx], idx, lineBarsData[idx].spots[index]
//            );
//        }).toList());
//      }).toList(),
//      lineTouchData: LineTouchData(
//        enabled: false,
////        fullHeightTouchLine: true,
//        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
//          return spotIndexes.map((index) {
//            return TouchedSpotIndicatorData(
//              FlLine(
//                color: Colors.transparent,
//              ),
//              FlDotData(
//                show: true,
//                dotSize: 0,
//                strokeWidth: 3,
//                getStrokeColor: (spot, percent, barData) => _getCurColorByIndex(widget.status, index),
////                getDotColor: (spot, percent, barData) {
////                  return lerpGradient(barData.colors, barData.colorStops, percent / 100);
////                },
//              ),
//            );
//          }).toList();
//        },
//        touchTooltipData: LineTouchTooltipData(
//            tooltipBgColor: Colors.transparent,
//            tooltipRoundedRadius: 0,
//            tooltipBottomMargin: 0,
//            getTooltipItems: (List<LineBarSpot> touchedSpots) {
////              if (touchedSpots == null) {
////                return null;
////              }
//              return touchedSpots.map((LineBarSpot touchedSpot) {
////                if (touchedSpot == null) {
////                  return null;
////                }
//                final TextStyle textStyle = TextStyle(
//                  color: Colors.red,
//                  fontWeight: FontWeight.bold,
//                  fontSize: 10,
//                );
//                return LineTooltipItem(touchedSpot.y.toString(), textStyle);
//              }).toList();
//            }
//        ),
//      ),
    ), swapAnimationDuration: Duration(milliseconds: 1000),);
  }

  Widget build(BuildContext context) {
    return _chartChild();
  }
}


/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (stops == null || stops.length != colors.length) {
    stops = [];
    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / colors.length;
      stops.add(percent * (index + 1));
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT);
    }
  }
  return colors.last;
}

