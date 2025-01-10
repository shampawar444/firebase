import 'package:firebase_app/ui/posts/post_screen.dart';
import 'package:firebase_app/utils/utils.dart';
import 'package:firebase_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  final otpNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: otpNumberController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Verify",
                loading: isLoading,
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: otpNumberController.text.toString());

                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostScreen()));
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    Utils.toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
