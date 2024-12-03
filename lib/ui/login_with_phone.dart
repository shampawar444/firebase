import 'package:firebase_app/ui/verify_code.dart';
import 'package:firebase_app/utils/utils.dart';
import 'package:firebase_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "+1 345 4545 576"),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Send code",
                loading: isLoading,
                onTap: () {
                  setState(() {
                    isLoading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                      verificationFailed: (e) {
                        setState(() {
                          isLoading = false;
                        });
                        Utils.toastMessage(e.toString());
                        print("################${e}");
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCode(
                                      verificationId: verificationId,
                                    )));
                        setState(() {
                          isLoading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils.toastMessage(e.toString());
                        setState(() {
                          isLoading = false;
                        });
                      });
                })
          ],
        ),
      ),
    );
  }
}
