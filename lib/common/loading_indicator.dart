import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Stack(
      children: [
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/loading.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(child: Image.asset("assets/loadingGif.gif",height: 60,width: 60,),),
      ],
    ),
  );
}