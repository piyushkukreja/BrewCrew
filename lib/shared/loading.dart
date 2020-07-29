import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],//background color for the loader
      child: Center(//for the loader to be in the center of the screen
        child: SpinKitChasingDots(//choose spinner from provided spinners from the documentation
          color: Colors.pink,
          size: 50.0
        )
      )
    );
  }
}