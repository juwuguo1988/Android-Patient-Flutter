import 'package:flutter/material.dart';
import 'package:patient/provider/provider_index.dart';
import 'package:provider/provider.dart';

abstract class ProviderHelper {
  HealthProvider healthProviderHelper(BuildContext context) {
    return Provider.of<HealthProvider>(context, listen: false);
  }

  DatetimeProvider datetimeProviderHelper(BuildContext context) {
    return Provider.of<DatetimeProvider>(context, listen: false);
  }
}