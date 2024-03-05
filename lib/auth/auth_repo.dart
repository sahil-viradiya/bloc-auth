import 'package:auth1/contant.dart';
import 'package:auth1/utils.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  Future<dynamic> userDetails() async {
    var response = await DIO.get("$BASE_URL/api/userdetails/",
        options: Options(headers: {"Authorization": TOKEN}));
  }
}
