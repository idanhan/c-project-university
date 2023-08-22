import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cards/project1front.dart' as pro1;
import './cards/project2.dart' as pro2;
import './cards/project3.dart' as pro3;
import './cards/project4.dart' as pro4;
import './actuallCards.dart/acCard1Front.dart' as pro1Real;

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreentate();
}

class _NewScreentate extends State<NewScreen> {
  void initState() {
    super.initState();
  }

  List<Widget> list1 = [];
  List<String> list2 = [
    pro1.pro1name,
    pro2.pro2name,
    pro3.pro3name,
    pro4.pro4name
  ];
  List<String> listNamesBack = [
    'pro1',
    'pro2',
    'pro3',
    'pro4',
  ];
  List<Map<String, dynamic>> listdata = [];

  List<Map<String, Object>> list3 = [];
  List<String> list4 = [pro1Real.frontReal().proName1];
  int count = 0;
  var data2;

  void _loadScreen() async {
    final url = Uri.https('cards1-33dbf-default-rtdb.firebaseio.com', '');

    final response = await http.get(url);
    print(response);
  }

  Future<void> _loaditems(String id, int ind) async {
    final url = Uri.https('cards1-33dbf-default-rtdb.firebaseio.com',
        listNamesBack[ind] + '.json');

    final response = await http.get(url);
    print(response);

    final Map<String, dynamic> listitems = json.decode(response.body);
    var data_back;

    for (final item in listitems.entries) {
      if (item.value['id'] == id) {
        data_back = item.value;
      }
    }
    print("this is " + "${data_back}");
    setState(() {
      listdata.add(data_back);
      print(listdata.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width1 = MediaQuery.of(context).size.width;
    var height1 = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 26, 2, 80),
              Color.fromARGB(255, 39, 6, 114),
              Color.fromARGB(255, 64, 18, 169)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset('assets/images/menu.png'),
                onPressed: () {},
              );
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 26, 2, 80),
            Color.fromARGB(255, 39, 6, 114),
            Color.fromARGB(255, 64, 18, 169)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 3 / 4, maxCrossAxisExtent: 200),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 2, 5, 37)),
                      height: 30,
                      margin: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          print(index);
                          await _loaditems(listNamesBack[index], index);
                          Navigator.pushNamed(context, list4[index],
                              arguments: listdata[index]);
                        },
                        child: Card(
                          child: list1[index],
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(255, 2, 5, 37)),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    );
                  },
                  itemCount: list1.length,
                ),
              ),
              Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 165, 167, 186)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: () async {
                      final data1 = await Navigator.pushNamed(
                          context, list2[count],
                          arguments: listNamesBack[count]);
                      if (data1 != null) {
                        list3.add(data1 as Map<String, Object>);

                        count++;

                        setState(() {
                          list1.add(Card(
                            color: Colors.blueGrey,
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(children: [
                                Text(list3[count - 1]['backDescription']
                                    as String)
                              ]),
                            ),
                          ));
                        });
                      }
                    },
                    child: Text(
                      'add a project',
                      style: TextStyle(
                          fontSize: 25, color: Color.fromARGB(255, 22, 27, 31)),
                    )),
              )
            ],
          ),
        ));
  }
}
