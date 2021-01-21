import 'package:flutter/widgets.dart';
import 'package:patient/config/custom_localizations.dart';
import 'package:patient/utils/LogUtils.dart';

class IntlUtil {

  static String getString(BuildContext context, String id, {String languageCode, String countryCode, List<Object> params}) {

    LogUtils.d("0000"+id+"languageCode"+languageCode+"countryCode"+countryCode);
    return CustomLocalizations.of(context).getString(id, languageCode: languageCode, countryCode: countryCode, params: params);
  }
}