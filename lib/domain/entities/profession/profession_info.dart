class ProfessionInfo {
  String shortName = "";
  String longName = "";
  String id = "";

//1. Khai báo các biến cần thiết cho ProfessionInfo
// Info class này được dùng để chứa dữ liệu mà usecase cần để xử lý
//Nó khác với Response class là nó không chứa dữ liệu trả về từ API
//vì nó không phải là một data transfer object
//Nó sẽ dc dùng với reponse như là một dạng chuyển đổi từ dữ liệu nhận được từ API (ProfessionResponse)
//sau đó đươc chuyển thành một ProfessionInfo object để sử dụng trong usecase
//Cách này giúp secure hơn vì không truyền dữ liệu trực tiếp từ API vào usecase

  ProfessionInfo(this.longName, this.shortName, this.id);
  ProfessionInfo.buildDefault();
}
