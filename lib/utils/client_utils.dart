import 'index.dart';

class ClientUltis {
  static String convertStatus(int status) {
    String message = "";
    switch (status) {
      // case Configs.LOGIN_SUCCESS:
      //   {
      //     message = "Đăng nhập thành công";
      //     break;
      //   }
      case Configs.LOGIN_FAILED:
        {
          message = "Đăng nhập thất bại";
          break;
        }
      case Configs.LOGIN_WRONG_PASSWORD:
        {
          message = "Sai mật khẩu";
          break;
        }
      case Configs.LOGIN_ACCOUNT_IS_USED:
        {
          message = "Tài khoản đã được sử dụng";
          break;
        }
      case Configs.TOKEN_VALID:
        {
          message = "Phiên đăng nhập hết hạn";
          break;
        }
      case Configs.LOGIN_ACCOUNT_NOT_EXIST:
        {
          message = "Tài khoản không tồn tại";
          break;
        }
      case Configs.LOGIN_NOT_EXISTED:
        {
          message = "${Configs.LOGIN_NOT_EXISTED}";
          break;
        }
    }
    return message;
  }

  static String getIdsFromList(List<dynamic> list) {
    String data = '';
    int index = 0;
    for (var q in list) {
      if (index > 0) {
        data += ',';
      }
      data += "${q}";
      index++;
    }
    data += '';
    print(":xxxxxx $data");
    return data;
  }
}
