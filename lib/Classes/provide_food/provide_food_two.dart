// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aashray/Classes/provide_food/provide_food_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProvideFoodTwo extends StatefulWidget {
  const ProvideFoodTwo({super.key});

  @override
  State<ProvideFoodTwo> createState() => _ProvideFoodTwoState();
}

class _ProvideFoodTwoState extends State<ProvideFoodTwo> {
  String _selectedMeal = "";
  late bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text("Volunteer for Food"),
        actions: [
          // settings
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: GestureDetector(
              child: const Tooltip(
                triggerMode: TooltipTriggerMode.longPress,
                message: "Help",
                child: Icon(
                  Icons.help,
                  size: 25.0,
                ),
              ),
              onTap: () {
                Fluttertoast.showToast(
                  msg: "Helping...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Select type of Meal",
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: 20.0,
              ),
              child: Text(
                "You can opt for only one meal option.",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'Breakfast',
                groupValue: _selectedMeal,
                onChanged: (value) {
                  setState(() {
                    _selectedMeal = value!;
                  });
                },
              ),
              onTap: (() {
                setState(() {
                  _selectedMeal = "Breakfast";
                });
              }),
              title: const Text(
                'Breakfast',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'Lunch',
                groupValue: _selectedMeal,
                onChanged: (value) {
                  setState(() {
                    _selectedMeal = value!;
                  });
                },
              ),
              onTap: (() {
                setState(() {
                  _selectedMeal = "Lunch";
                });
              }),
              title: const Text(
                'Lunch',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'Dinner',
                groupValue: _selectedMeal,
                onChanged: (value) {
                  setState(() {
                    _selectedMeal = value!;
                  });
                },
              ),
              onTap: (() {
                setState(() {
                  _selectedMeal = "Dinner";
                });
              }),
              title: const Text(
                'Dinner',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                ),
                child: ElevatedButton(
                  onPressed: (() {
                    saveandnext();
                  }),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            if (!_loading)
                              Text(
                                "Save and Next",
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),

                            // Circular progress bar
                            if (_loading)
                              Center(
                                child: SizedBox(
                                  height: 28.0,
                                  width: 28.0,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.8,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveandnext() {
    String userId;
    final User? user = FirebaseAuth.instance.currentUser;

    userId = user!.uid;

    if (_selectedMeal.isNotEmpty) {
      setState(() {
        _loading = !_loading;
      });

      FirebaseFirestore.instance
          .collection("Food Providers")
          .doc(userId)
          .update({
        "Meal Type": _selectedMeal,
      }).whenComplete(() {
        Fluttertoast.showToast(
          msg: "Uploaded Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          _loading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProvideFoodThree(),
          ),
        );
      }).onError((error, stackTrace) => null);
    } else {
      Fluttertoast.showToast(
        msg: "Select any one option",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
