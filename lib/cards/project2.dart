import 'package:cards/moduls/cardModule.dart';
import 'package:flutter/material.dart';

import 'project2Back.dart';

String pro2name = 'pro2';

class project2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return projectModule(pro2Back().proBack2Name, pro2Back().proBack2Name);
  }
}
