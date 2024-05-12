import 'package:med_voice/domain/entities/baseball/baseball_info.dart';

abstract class SampleRepository {
  Future<List<BaseballInfo>> getBaseballList();
}