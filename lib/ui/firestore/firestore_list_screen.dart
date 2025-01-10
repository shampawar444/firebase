import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/ui/auth/login_screen.dart';
import 'package:firebase_app/ui/firestore/add_firestore_data.dart';
import 'package:firebase_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference ref =
      FirebaseFirestore.instance.collection('users'); // collection ref
  // final ref1 = FirebaseFirestore.instance.collection('users');           // collection ref

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Firestore',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: $error")),
                );
              });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Some Error");
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        final title =
                            snapshot.data!.docs[index]['title'].toString();
                        return ListTile(
                          title: Text(
                              snapshot.data!.docs[index]['title'].toString()),
                          trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 1,
                                        child: ListTile(
                                          leading: Icon(Icons.edit),
                                          title: Text("Edit"),
                                          onTap: () {
                                            Navigator.pop(context);
                                            showDialogue(
                                                title,
                                                snapshot.data!.docs[index]['id']
                                                    .toString());
                                          },
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: ListTile(
                                          leading: Icon(Icons.delete_outline),
                                          title: Text("Delete"),
                                          onTap: () {
                                            Navigator.pop(context);
                                            ref
                                                .doc(snapshot
                                                    .data!.docs[index]['id']
                                                    .toString())
                                                .delete();
                                          },
                                        )),
                                  ]),
                        );
                      }),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddFirestoreDataScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showDialogue(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update"),
          content: TextFormField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Edit"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (editController.text.trim().isNotEmpty) {
                  ref.doc(id).update({
                    'title': editController.text.trim(),
                  }).then((value) {
                    Utils.toastMessage("Updated");
                    Navigator.pop(context); // Close dialog on successful update
                  }).onError((error, stackTrace) {
                    Utils.toastMessage(error.toString());
                  });
                } else {
                  Utils.toastMessage("Title cannot be empty.");
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
