import 'package:med_voice/domain/entities/nurse/nurse_login_request.dart';

import '../../entities/nurse/nurse_info.dart';
import '../../entities/nurse/nurse_login_info.dart';
import '../../entities/nurse/nurse_register_request.dart';

abstract class NurseDataControlRepository {
  Future<NurseInfo> registerNurse(NurseRegisterRequest param);
  Future<NurseInfo> getNurseInfo(NurseRegisterRequest param);
  Future<bool> deleteNurseAccount(NurseRegisterRequest param);
  Future<NurseInfo> editNurseInformation(NurseRegisterRequest param);
  Future<NurseLoginInfo> loginNurse(NurseLoginRequest param);
}