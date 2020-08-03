import 'package:fitness_app/fitness_data.dart';
import 'package:fitness_app/theme/colors.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final double height;
  final AnimationController graphAnimationController;
  final List<GraphData> values;

  Graph(
      {@required this.graphAnimationController,
      @required this.values,
      this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[..._buildBars()],
      ),
    );
  }

  List<Widget> _buildBars() {
    List<GraphBar> bars = List();

    GraphData max = values.reduce(
        (current, next) => (next.compareTo(current)) >= 1 ? next : current);

    for (GraphData graphData in values) {
      double percent = graphData.value / max.value;
      bars.add(GraphBar(height, percent, graphAnimationController));
    }
    return bars;
  }
}

class GraphBar extends StatefulWidget {
  final double height;
  final double percentage;
  final AnimationController _graphAnimationController;

  GraphBar(this.height, this.percentage, this._graphAnimationController);

  @override
  _GraphBarState createState() => _GraphBarState();
}

class _GraphBarState extends State<GraphBar> {
  Animation<double> _percentageAnimation;

  @override
  void initState() {
    super.initState();
    _percentageAnimation = Tween<double>(begin: 0, end: widget.percentage)
        .animate(widget._graphAnimationController);
    _percentageAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BarPainter(_percentageAnimation.value),
      child: Container(
        height: widget.height,
        width: 10,
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double percentage;

  BarPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Offset top = Offset(0, 0);
    Offset bottom = Offset(0, size.height + 20);
    Offset middle = Offset(0, (size.height + 20) / 2);

    Paint greyPaint = Paint()
      ..color = greyColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    canvas.drawLine(top, bottom, greyPaint);

    Paint fillPaint = Paint()
      ..shader = LinearGradient(
              colors: [Colors.pink.shade500, Colors.blue.shade500],
              begin: Alignment.topCenter)
          .createShader(Rect.fromPoints(top, bottom))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    double filledHeight = percentage * size.height;
    double filledHalfHeight = filledHeight / 2;

    canvas.drawLine(middle, Offset(0, middle.dy - filledHalfHeight), fillPaint);
    canvas.drawLine(middle, Offset(0, middle.dy + filledHalfHeight), fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
