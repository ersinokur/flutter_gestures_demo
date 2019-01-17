import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int tabsCount = 0;
  int doubleTabsCount = 0;
  int longPressCount = 0;
  double positionX = 0.0;
  double positionY = 0.0;
  double boxSizeX = 0.0;
  double boxSizeY = 0.0;
  double fullBoxSquareSize = 150.0;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 20000), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);

    animation.addListener(() {
      setState(() {
        boxSizeX = fullBoxSquareSize * animation.value;
        boxSizeY = fullBoxSquareSize * animation.value;
      });
      locateCenterBox(context);
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (positionX == 0.0) {
    //   locateCenterBox(context);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Gestures Demo"),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            tabsCount++;
          });
        },
        onDoubleTap: () {
          setState(() {
            doubleTabsCount++;
          });
        },
        onLongPress: () {
          setState(() {
            longPressCount++;
          });
        },
        //vertical drag
        onVerticalDragUpdate: (DragUpdateDetails value) {
          setState(() {
            positionY += value.delta.dy;
          });
        },
        //vertical drag
        onHorizontalDragUpdate: (DragUpdateDetails value) {
          setState(() {
            positionX += value.delta.dx;
          });
        },

        child: Stack(
          children: <Widget>[
            Positioned(
              left: positionX,
              top: positionY,
              child: Container(
                width: boxSizeX,
                height: boxSizeY,
                decoration: BoxDecoration(color: Colors.greenAccent),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "Tab: $tabsCount, double tap: $doubleTabsCount, long press: $longPressCount, x: $positionX, y:$positionY",
        ),
      )),
    );
  }

  void locateCenterBox(BuildContext context) {
    //to locate box to the center
//get screen sizeX
    positionX = MediaQuery.of(context).size.width / 2.0 - boxSizeX / 2.0;
    positionY =
        MediaQuery.of(context).size.height / 2.0 - boxSizeY / 2.0 - 30.0;

    setState(() {
      this.positionX = positionX;
      this.positionY = positionY;
    });
  }
}
