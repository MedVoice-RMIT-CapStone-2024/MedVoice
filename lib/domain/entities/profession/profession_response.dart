class ProfessionResponse {
  String? mLongName = "";
  String? mShortName = "";
  String? mId = "";

  //2. Khai báo các biến cần thiết cho ProfessionResponse
// Response class acts as a wrapper for the data we receive from the API
//A data transfer object that represents the structure of the data received from an external source (e.g., an API).
//Response được dùng để chứa dữ liệu trả về từ API
//sau đó nó sẽ được chuyển thành một ProfessionInfo object để sử dung trong usecase

  ProfessionResponse(this.mLongName, this.mShortName, this.mId);
  factory ProfessionResponse.fromJson(Map<String, dynamic> json) {
    return ProfessionResponse(
        json['long_name'], json['short_name'], json['id']);
  }

// cái factory này sẽ giúp tạo ra một instance của ProfessionResponse từ một map json
//bằng cách truyền vào các giá trị (value) của map json vào các parameter của class ProfessionResponse

// factory là một phương thức được sử dụng để tạo ra một instance của class
//mà không cần phải gọi constructor của nó
}
