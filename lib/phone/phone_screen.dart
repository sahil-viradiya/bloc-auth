import 'package:auth1/otp/otp_cubit.dart';
import 'package:auth1/otp/otp_screen.dart';
import 'package:auth1/phone/phone_cubit.dart';
import 'package:auth1/phone/phone_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneScreen extends StatefulWidget {
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  bool enableButton = false;

  String phoneNo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhoneCubit, PhoneState>(
        listener: (context, state) {
          if (state is Loaded) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                      create: (context) => OtpCubit(), child: OtpScreen(phoneNo)),
                ));
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      enableButton = value.length == 10;
                      phoneNo = value;
                    });
                  },
                  enabled: !(state is Loading),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: "Enter PhoneNo",
                    labelText: "Phone",
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              state is Loading ? CircularProgressIndicator() : SizedBox(),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<PhoneCubit>(context).getOtp(phoneNo);
                    },
                    child: Text("GetOtp")),
              )
            ],
          );
        },
      ),
    );
  }
}
