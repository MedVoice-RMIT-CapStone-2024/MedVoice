import 'package:flutter/material.dart';
import 'package:med_voice/data/network/constants.dart';
import 'package:med_voice/data/network/http_helper.dart';
import 'package:med_voice/domain/entities/profession/profession_info.dart';
import 'package:med_voice/domain/entities/profession/profession_response.dart';
import 'package:med_voice/domain/repositories/profession_repository/professsion_repository.dart';

// cái class này sẽ là implementation các method dc khai báo trong ProfessionRepository
//và sẽ là nơi lấy dữ liệu từ API về và chuyển thành ProfessionInfo object
class ProfessionRepositoryImpl extends ProfessionRepository {
//4. Khai báo một instance của ProfessionRepositoryImpl
//để sử dụng trong cả project
  static final ProfessionRepositoryImpl _instance =
      ProfessionRepositoryImpl._internal();
// dòng code này có nghiã là tạo ra một instance của ProfessionRepositoryImpl
//và gán nó vào biến _instance

  ProfessionRepositoryImpl._internal() {}
//constructor của class ProfessionRepositoryImpl

  factory ProfessionRepositoryImpl() => _instance;
//factory method sẽ trả về một instance của ProfessionRepositoryImpl

//5. Implement method getProfessionList từ ProfessionRepository
// //Phải override vì nó là một method của abstract class ProfessionRepository
  @override
  Future<List<ProfessionInfo>> getProfessionList() async {
    List<ProfessionResponse> professionResponseList = [];
    List<ProfessionInfo> professionInfoList = [];
    List<dynamic>? body;
    //Cho cái body dynamic vì cái dữ liệu trả về từ API có thể là bất kỳ kiểu dữ liệu nào
    try {
      body = await HttpHelper.invokeHttpList(
          Uri.parse(Constants.getProfessionList), RequestType.get,
          headers: null, body: null);
    } catch (error) {
      debugPrint("Fail to get profession list");
      rethrow;
    }
    //5. Lấy dữ liệu từ API
    // Chỗ này sẽ gọi method invokeHttpList từ HttpHelper để lấy dữ liệu từ link API
    //trong folder Constants và trả về một list các dynamic object vào trong cái List "body"
    //nếu không lấy được dữ liệu thì sẽ throw ra một exception

    if (body == null) return [];
    // nếu body rỗng thì trả về một list rỗng, cách này sẽ giúp tránh lỗi null pointer

    if (body != null) {
      professionResponseList = body
          .map((dynamic i) =>
              ProfessionResponse.fromJson(i as Map<String, dynamic>))
          .toList();
    }
    //nếu body không rỗng thì sẽ chuyển các dynamic object trong body thành ProfessionResponse object
    //Map sẽ chuyển một dynamic object thành một Map<String, dynamic> object
    //ví dụ như {key: value} trong json => Map<String, dynamic> object
    //sau đó chuyển thành một list các ProfessionResponse object bằng method toList()

//6. Chuyển dữ liệu từ ProfessionResponse object thành ProfessionInfo object
    for (var i = 0; i < professionResponseList.length; i++) {
      ProfessionResponse professionResponseItem = professionResponseList[i];
      // duyệt qua từng phần tử trong professionResponseList
      // sau đó gán từng phần tử vào professionResponseItem
      professionInfoList.add(ProfessionInfo(
          professionResponseItem.mLongName ?? "",
          professionResponseItem.mShortName ?? "",
          professionResponseItem.mId ?? ""));
    }
    //ví dụ như dưới đây là một method lấy danh sách các nghề nghiệp
    // từ API về và chuyển thành ProfessionInfo object
    // sau đó trả về một list các ProfessionInfo object
    return professionInfoList;
  }
}
