import 'package:firebase_app/utils/utils.dart';
import 'package:firebase_app/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool isLoading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
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
                      databaseRef.child(id).set({
                        "title": postController.text.toString(),
                        "id": id,
                      }).then((value) {
                        setState(() {
                          isLoading = false;
                        });
                        Utils.toastMessage("Post added");
                      }).onError((error, stackTrace) {
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
