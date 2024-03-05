import 'package:auth1/auth/auth_cubit.dart';
import 'package:auth1/auth/auth_state.dart';
import 'package:auth1/contant.dart';
import 'package:auth1/home/home_screen.dart';
import 'package:auth1/otp/otp_screen.dart';
import 'package:auth1/phone/phone_cubit.dart';
import 'package:auth1/phone/phone_screen.dart';
import 'package:auth1/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await getToken();
  } catch (e) {
    print(e);
  }
  if (TOKEN != null) {
    deletToken();
    await authCubit.laoduserDetails();
  }
  runApp(BlocProvider(create: (context) => authCubit, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          //todo
        },
        builder: (context, state) {
          if (state is Authenticated) {
            return HomeScreen();
          }
          if (state is Failed) {
            return Scaffold(
              body: Center(
                child: Text("oops............"),
              ),
            );
          }
          return BlocProvider(
              create: (context) => PhoneCubit(), child: PhoneScreen());
        },
      ),
      // BlocProvider(create: (context) => PhoneCubit(), child: PhoneScreen()),
    );
  }
}
