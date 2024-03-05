
import 'package:auth1/auth/auth_cubit.dart';
import 'package:dio/dio.dart';

Dio DIO = Dio();

const String BASE_URL = 'http://192.168.1.12:8000';

AuthCubit authCubit = AuthCubit();
