import 'package:auth1/auth/auth_cubit.dart';
import 'package:auth1/otp/otp_cubit.dart';
import 'package:auth1/otp/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  String phoneNo;

  OtpScreen(this.phoneNo);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";

  bool enableButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) async {
          if (state is Verifyed) {
            await BlocProvider.of<AuthCubit>(context).laoduserDetails();
          }
          if (state is Failed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.messaage)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    "Enter Otp",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                OtpTextField(
                  onSubmit: (value) {
                    setState(() {
                      enableButton = true;
                    });
                    otp = value;
                  },
                  onCodeChanged: (value) {
                    setState(() {
                      enableButton = false;
                    });
                  },
                  numberOfFields: 4,
                ),
                SizedBox(
                  height: 120,
                ),
                state is Submitting ? CircularProgressIndicator() : SizedBox(),
                SizedBox(
                  height: 120,
                ),
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: !enableButton || state is Submitting
                        ? null
                        : () {
                            BlocProvider.of<OtpCubit>(context)
                                .verifyOtp(otp, widget.phoneNo);
                          },
                    child: Text("Verify"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
