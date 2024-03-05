import '../contant.dart';

class OtpRepo {
  Future<dynamic> verifyOtp(String phone, String otp) async {
    var response = await DIO
        .post("$BASE_URL/api/verifyotp", data: {"phone": phone, "otp": otp});
    return response;
  }
}
