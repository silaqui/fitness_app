import 'package:flutter/material.dart';

import 'fitness_data.dart';
import 'graph.dart';

class ShowGraph extends StatefulWidget {
  @override
  _ShowGraphState createState() => _ShowGraphState();
}

class _ShowGraphState extends State<ShowGraph>  with SingleTickerProviderStateMixin{

  AnimationController _graphAnimationController;

  @override
  void initState() {
    super.initState();
    _graphAnimationController = AnimationController(vsync: this,duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _graphAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: InkWell(
            onTap: (){_graphAnimationController.forward();},
            child: Graph(graphAnimationController: _graphAnimationController,
            values: dayData),
          ),
        ),
      ),
    );
  }
}
