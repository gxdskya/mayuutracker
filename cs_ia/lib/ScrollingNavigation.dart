import 'package:flutter/material.dart';
import 'package:csia/Welcome/Welcomepage.dart';
import 'package:csia/FoodSearch/foodSearch.dart';
import 'package:flutter/rendering.dart';



class PageViewScroll extends StatefulWidget {//reusable code
  final List<Widget> list;
  final direction;

  PageViewScroll(this.list, this.direction);

  @override
  _PageViewScrollState createState() => _PageViewScrollState();
}

class _PageViewScrollState extends State<PageViewScroll> {
  PageController _controller = PageController(//define controller as private variable
    initialPage: 0,
  );
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return PageView(// apply controller
      controller: _controller,
      children: widget.list,

    );
  }
}
//unused scrolling
class Scrolling extends StatefulWidget {
  final List<Widget> child;

  Scrolling(this.child);

  @override
  _ScrollingState createState() => _ScrollingState();
}

class _ScrollingState extends State<Scrolling> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: widget.child,
    );
  }
}
