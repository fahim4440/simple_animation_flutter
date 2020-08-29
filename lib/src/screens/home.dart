import 'package:flutter/material.dart';
import '../widget/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catAnimationController;

  Animation<double> boxAnimation;
  AnimationController boxAnimationController;

  Animation<double> leftFlapAnimation;
  AnimationController leftFlapAnimationController;

  Animation<double> rightFlapAnimation;
  AnimationController rightFlapAnimationController;

  @override
  void initState() {
    super.initState();

    catAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    boxAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    leftFlapAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    rightFlapAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    rightFlapAnimation = Tween(begin: -0.5235988, end: -0.5585054).animate(
        CurvedAnimation(
            parent: rightFlapAnimationController, curve: Curves.easeInOut));

    leftFlapAnimation = Tween(begin: 0.5235988, end: 0.5585054).animate(
        CurvedAnimation(
            parent: leftFlapAnimationController, curve: Curves.easeInOut));

    boxAnimation = Tween(begin: 0.0100, end: -0.0100).animate(CurvedAnimation(
        parent: boxAnimationController, curve: Curves.easeInOut));

    catAnimation = Tween(begin: 105.0, end: 180.0).animate(
        CurvedAnimation(parent: catAnimationController, curve: Curves.easeIn));

    boxAnimationController.forward();
    leftFlapAnimationController.forward();
    rightFlapAnimationController.forward();
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxAnimationController.reverse();
        leftFlapAnimationController.reverse();
        rightFlapAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxAnimationController.forward();
        leftFlapAnimationController.forward();
        rightFlapAnimationController.forward();
      }
    });
  }

  onTap() {
    if (catAnimation.status == AnimationStatus.completed) {
      catAnimationController.reverse();
      boxAnimationController.forward();
    } else if (catAnimation.status == AnimationStatus.dismissed) {
      catAnimationController.forward();
      boxAnimationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            buildCatAnimation(),
            buildBoxAnimation(),
            buildLeftFlapAnimation(),
            buildRightFlapAnimation(),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget buildBoxAnimation() {
    return AnimatedBuilder(
      animation: boxAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: boxAnimation.value,
          child: child,
        );
      },
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.brown,
        child: Center(
          child: Text(
            "DON'T DISTURB ME!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        )
      ),
     );
  }

  Widget buildLeftFlapAnimation() {
    return Positioned(
      top: 3.5,
      child: AnimatedBuilder(
        animation: leftFlapAnimation,
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: leftFlapAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 5.0,
          height: 100.0,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget buildRightFlapAnimation() {
    return Positioned(
      top: 3.5,
      right: 0.0,
      child: AnimatedBuilder(
        animation: rightFlapAnimation,
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: rightFlapAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 5.0,
          height: 100.0,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          left: 35,
          right: 35,
          bottom: catAnimation.value,
          child: child,
        );
      },
      child: Cat(),
    );
  }
}
