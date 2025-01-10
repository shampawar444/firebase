import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/utils/utils.dart';
import 'package:firebase_app/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final postController = TextEditingController();
  bool isLoading = false;
  final firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Firestore Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter your post",
              ),
            ),
            const SizedBox(height: 50),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : RoundButton(
                    loading: isLoading,
                    title: "Add",
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });

                      String id =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      firestore.doc(id).set({
                        'title': postController.text.toString(),
                        'id': id,
                      }).then((value) {
                        setState(() {
                          isLoading = false;
                        });
                        Utils.toastMessage("Post Added");
                      }).onError((error, stakeTrace) {
                        setState(() {
                          isLoading = false;
                        });
                        Utils.toastMessage(error.toString());
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }
}
