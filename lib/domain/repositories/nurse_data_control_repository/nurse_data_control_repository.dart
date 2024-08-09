import '../../entities/nurse/nurse_info.dart';
import '../../entities/nurse/nurse_register_request.dart';

abstract class NurseDataControlRepository {
  Future<NurseInfo> registerNurse(NurseRegisterRequest param);
}