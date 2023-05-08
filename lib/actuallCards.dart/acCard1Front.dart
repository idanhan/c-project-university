import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class frontReal extends StatelessWidget {
  String proName1 = 'pro1Real';
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final width1 = MediaQuery.of(context).size.width;
    final height1 = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.top;

    return Scaffold(
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 26, 2, 80),
            Color.fromARGB(255, 39, 6, 114),
            Color.fromARGB(255, 64, 18, 169)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
      ),
      body: FlipCard(
        fill: Fill.fillBack,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          width: width1,
          height: height1 * 0.7,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 50.0,
            shadowColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                        'assets/images/Screenshot 2023-04-17 124148.png')),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    height: height1 * 0.6,
                    width: width1 * 0.7,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Text(
                              args["textDescription"],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            args["Image"] != 'no image chosen'
                                ? Expanded(
                                    child: Image.file(File(args["Image"])))
                                : Text(""),
                            Container(
                              width: 100,
                              height: 100,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        back: Container(
          child: Text('back'),
        ),
      ),
    );
  }
}
