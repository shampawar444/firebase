import 'package:firebase_app/utils/utils.dart';
import 'package:firebase_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(
                title: "Forgot",
                loading: isLoading,
                onTap: () {
                  setState(() {
                    isLoading = true;
                  });
                  auth
                      .sendPasswordResetEmail(
                          email: emailController.text.toString())
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Utils.toastMessage(
                        "We have sent you email to recover password, please check email");
                    Navigator.pop(context);
                  }).onError((error, stakeTrace) {
                    setState(() {
                      isLoading = false;
                    });
                    Utils.toastMessage(error.toString());
                    Navigator.pop(context);
                  });
                })
          ],
        ),
      ),
    );
  }
}
