import 'package:auth1/contant.dart';

class PhoneRepo {
  Future<dynamic> getOtp(String phone) async {
    var response =
        await DIO.post("$BASE_URL/api/getotp/", data: {"phone": phone});
    return response;
  }
}
