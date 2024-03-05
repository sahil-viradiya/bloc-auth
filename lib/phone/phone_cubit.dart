import 'package:auth1/phone/phone_repo.dart';
import 'package:auth1/phone/phone_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit() : super(Init());
  PhoneRepo repo = PhoneRepo();

  void getOtp(String phone) {
    emit(Loading());
    repo.getOtp(phone).then((response) {
      emit(Loaded());
    }).catchError((value) {
      print(value);
      DioError error = value;
      if (error.response != null) {
        try {
          emit(Failed(error.response!.data));
        } catch (e) {
          emit(Failed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioErrorType.unknown) {
          Failed("Please check ypur internate");
        } else {
          Failed(error.message!);
        }
      }
    });
  }
}
