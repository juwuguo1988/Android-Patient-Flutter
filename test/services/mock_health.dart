import 'package:patient/http/entity/graph_bp_model.dart';
import 'package:patient/services/api/health.dart';
import 'package:mockito/mockito.dart';


class MockHealthAPI extends Mock implements HealthApi {}

final healthApi = MockHealthAPI();