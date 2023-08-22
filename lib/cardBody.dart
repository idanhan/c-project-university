import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'dart:io';

import './cards/project1back.dart';

String pro1name = 'pro1';

class project1 extends StatefulWidget {
  String backName1;
  project1({required this.backName1});
  @override
  State<project1> createState() => _project1State(backName: backName1);
}

class _project1State extends State<project1> {
  String backName;
  _project1State({required this.backName});
  File? _selectedImage;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  String? inputText;
  String? inputText2;
  double? d1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  Future<void> _selecteImage() async {
    final picker = ImagePicker();
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    File? image1 = File(PickedFile!.path);
    image1 = await _cropImage(imageFile: image1);
    setState(() {
      _selectedImage = image1;
    });
  }

  Widget decide() {
    if (_selectedImage != null) {
      return Card(
        child: Image.file(_selectedImage!),
      );
    } else if (myController1.text.isNotEmpty) {
      return Card(
        child: Card(
          child: Text(myController1.text),
        ),
      );
    } else {
      return Card(
        color: Colors.blueAccent,
        child: Text(
          'no text or image was selected',
          textAlign: TextAlign.center,
        ),
      );
    }
    ;
  }

  void isLeft() {
    if (_selectedImage == null) {
      setState(() {
        d1 = 40;
      });
    } else {
      setState(() {
        d1 = 0;
      });
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        backgroundColor: Colors.black12,
        body: Container(
          color: Colors.grey,
          height: (height1 - MediaQuery.of(context).viewInsets.top),
          width: width1,
          alignment: Alignment.center,
          child: Column(
            children: [
              Card(
                elevation: 10,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  height: height1 * 0.5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: width1 * 0.8,
                  child: Stack(children: [
                    Container(
                        height: height1 * 0.5,
                        width: width1 * 0.8,
                        child: Card(
                          shadowColor: Colors.black,
                          elevation: 10,
                          color: Colors.blue,
                        )),
                    Positioned(
                        top: 50,
                        child: Column(
                          children: [
                            Container(
                              width: width1 * 0.75,
                              margin: EdgeInsets.all(10),
                              child: TextFormField(
                                minLines: 1,
                                maxLines: 5,
                                controller: myController1,
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.black,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.black,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    inputText = myController1.text;
                                  });
                                },
                                child: Text('Save')),
                          ],
                        )),
                    Positioned(
                      left: d1,
                      child: decide(),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 110,
                      child: ElevatedButton(
                          style: ButtonStyle(alignment: Alignment.bottomCenter),
                          onPressed: _selecteImage,
                          child: Column(
                            children: [
                              Icon(
                                Icons.add_a_photo,
                              ),
                              Text(
                                'add image',
                              ),
                            ],
                          )),
                    ),
                  ]),
                ),
              ),
              Container(
                width: width1 * 0.8,
                height: height1 * 0.2,
                margin: const EdgeInsets.all(10),
                color: Colors.blue,
                child: Column(
                  children: [
                    Text('add a description'),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextFormField(
                          controller: myController2,
                          decoration: InputDecoration(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          inputText2 = myController2.text;
                        },
                        child: Text('Save')),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context,backName);
                            },
                            child: Text('Answer')),
                        ElevatedButton(
                            onPressed: () {
                              if (inputText == null) {
                                inputText = '';
                              }
                              if (inputText2 == null) {
                                inputText2 = '';
                              }
                              Navigator.of(context).pop(<String, Object>{
                                'textInput': inputText!,
                                'Image': (_selectedImage) != null
                                    ? Image.file(_selectedImage!)
                                    : 'no image chosen',
                                'textDescription': inputText2!,
                              });
                            },
                            child: Text('main screen'))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
