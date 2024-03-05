import 'package:auth1/otp/otp_state.dart';
import 'package:auth1/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_repo.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(Init());
  OtpRepo repo = OtpRepo();

  verifyOtp(String otp, String phone) {
    emit(Submitting());
    repo.verifyOtp(phone, otp).then((response) {
      String token = response.data['token'];
      storeToken(token).then((value) {
        emit(Verifyed());
      });
    }).catchError((value) {
      DioError error = value;
      if (error.response != null) {
        try {
          emit(Failed(error.response!.data));
        } catch (e) {
          emit(Failed(error.response!.data['deatil']));
        }
      } else {
        if (error.type == DioErrorType.unknown) {
          emit(Failed("please check your internate"));
        } else {
          emit(Failed(error.message!));
        }
      }
    });
  }
}
