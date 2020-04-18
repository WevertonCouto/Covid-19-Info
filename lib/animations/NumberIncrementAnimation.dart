import 'package:flutter/cupertino.dart';

/// Create animation
class IncrementNumber extends StatefulWidget {
  final int number;
  final Color color;
  
  IncrementNumber(this.number, this.color);
  @override
  _IncrementNumberState createState() => _IncrementNumberState();
}

class _IncrementNumberState extends State<IncrementNumber>
    with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController _controller;
  String i = '...';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration:const Duration(seconds: 10), vsync: this);

    animation =Tween<double>(begin: 0, end: widget.number.toDouble()).animate(_controller);
    animation.addListener((){
      setState((){
        i = animation.value.toStringAsFixed(0);
      });
    });

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text('$i', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 30, color: widget.color, fontFamily: 'Jennifer'),),
      ),
    );
  }
}