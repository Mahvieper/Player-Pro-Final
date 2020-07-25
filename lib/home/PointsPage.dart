import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';

class PointsPage extends StatelessWidget {
  String userPoints;

  PointsPage(this.userPoints);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/homeBack.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //The Sections.
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Showing Users Points.
                Container(
                  margin: EdgeInsets.all(40),
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.yellow)),
                    color: Colors.black12,
                    // Colors.black12,
                    //Color.fromARGB(1, 58, 58, 58)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/cup.png",
                          fit: BoxFit.fill,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        "assets/stars.png",
                        width: 60,
                        height: 20,
                      ),
                      Image.asset(
                        "assets/point_score.png",
                        width: 100,
                        height: 40,
                      ),
                      //Actual Score.
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: Center(
                            child: Text(
                              userPoints,
                              style: TextStyle(
                                  fontSize: 50, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),

                // Showing Weekly Points
                Image.asset(
                  'assets/thisWeek.png',
                  width: 140,
                  height: 50,
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    border:
                    Border(right: BorderSide(color: Colors.red)),
                    color: Colors.black12,
                  ),
                  child: Center(
                      child: Text(
                        "85",
                        style: TextStyle(fontSize: 40, color: Colors.red),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "POINTS",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          //footer
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(HomeInitEvent());
                          },
                          child: Image.asset(
                            "assets/homeSec.png",
                            fit: BoxFit.fill,
                            width: 100,
                            height: 30,
                          )),
                      Image.asset(
                        "assets/shopSec.png",
                        fit: BoxFit.fill,
                        width: 100,
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text("MY COACH"),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      decoration: BoxDecoration(color: Colors.yellow),
                      child: Text("HIGHSCORES"),
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AuthenticationLoggedOut());
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(color: Colors.red),
                        child: Text("LOGOUT"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
