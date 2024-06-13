import 'package:med_voice/domain/entities/profession/profession_info.dart';

abstract class ProfessionRepository {
  Future<List<ProfessionInfo>> getProfessionList();
//3. Khai báo một abstract class ProfessionRepository
// cái này sẽ trả về một list các ProfessionInfo object
//và sẽ dc dùng trong usecase để xử lý
}
// cái class này sẽ dùng để chứa các phương thức để lấy dữ liệu từ API
