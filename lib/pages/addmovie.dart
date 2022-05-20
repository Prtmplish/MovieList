import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(
                      Icons.arrow_back_ios
                      , color: Colors.grey,
                    )),
                    //
                    ElevatedButton(
                      onPressed: add,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: 12.0,
                ),
                //
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Name of the Movie",
                        ),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        onChanged: (_val) {
                          title = _val;
                        },
                      ),
                      //
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Description for the Movie",
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                          onChanged: (_val) {
                            des = _val;
                          },
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);

    //

    Navigator.pop(context);
  }
}
