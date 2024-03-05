import 'package:auth1/auth/auth_repo.dart';
import 'package:auth1/auth/auth_state.dart';
import 'package:auth1/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Init());
  AuthRepo repo = AuthRepo();

  Future<void> laoduserDetails() async {
    emit(Authenticating());
    try {
      var response = await repo.userDetails();
      emit(Authenticated());
    } catch (value) {
      DioError error = value as DioError;
      if (error.response != null) {
        if (error.response!.statusCode == 401 ||
            error.response!.statusCode == 403) {
          emit(UnAuthenticated());
          deletToken();
        } else {
          try {
            emit(Failed(error.response!.data));
          } catch (e) {
            emit(Failed(error.response!.data['detail']));
          }
        }
      } else {
        if (error.type == DioErrorType.unknown) {
          emit(Failed("please check your internate Connection"));
        } else {
          emit(Failed(error.message!));
        }
      }
    }
  }
}
