import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/home/bloc/home_event.dart';
import 'package:user_repository/user_repository.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class MyCoach extends StatelessWidget {
  final UserRepository userRepository;
  MyCoach(this.userModel, this.userRepository);
  final UserModel userModel;
  final double circleRadius = 100.0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc(
          userModel: userModel,
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: userRepository,
        )..add(GetCoachEvent());
      },

      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state) {
          if(state is GetCoachLoading)
            return LoadingIndicator();
          else if(state is GetCoachLoaded) {
            return Stack(
              children: [
                WillPopScope(
                  onWillPop: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeInitEvent());
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/homeBack.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(top: circleRadius / 2.0),
                              child: Wrap(
                                children: [
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.75,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3a3a3c),
                                        border: Border(
                                            top: BorderSide(
                                                color: Color.fromRGBO(
                                                    211, 172, 43, 1)),
                                            left: BorderSide(
                                                color: Color.fromRGBO(
                                                    211, 172, 43, 1)),
                                            right: BorderSide(
                                                color: Color.fromRGBO(
                                                    211, 172, 43, 1)),
                                            bottom: BorderSide(
                                                color: Color(0xFFbf2431),
                                                width: 10.0))),

                                    // Description of Coach.
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.08),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              userModel.adminName,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      211, 172, 43, 1),
                                                  fontSize: 23,
                                                  fontFamily:
                                                  "MontserratRegular",
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              userModel.designation,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  "MontserratRegular",
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              userModel.level,
                                              style: TextStyle(
                                                color: Color(0xFFbf2431),
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                "MontserratRegular",
                                                fontSize: 19,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              userModel.experience,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      211, 172, 43, 1),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  "MontserratRegular",
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                userModel.adminDetails,
                                                style: TextStyle(
                                                    wordSpacing: 2,
                                                    letterSpacing: 1,
                                                    color: Colors.white,
                                                    fontFamily:
                                                    "MontserratRegular",
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Container for Image of the Coach.
                            Container(
                              width: circleRadius,
                              height: circleRadius,
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.02),
                              decoration: ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.all(1),
                                child: DecoratedBox(
                                  decoration: ShapeDecoration(
                                      shape: CircleBorder(),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            userModel.image,
                                          ))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //Footers.
                      //footer
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(HomeInitEvent());
                                      },
                                      child: Image.asset(
                                        "assets/homeSec.png",
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.3,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.035,
                                      )),
                                  Image.asset(
                                    "assets/myPractice.png",
                                    fit: BoxFit.fill,
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.3,
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.035,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(GetCoachEvent());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFbf2431),
                                    ),
                                    width:
                                    MediaQuery.of(context).size.width /
                                        3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                            "MY COACH",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                "MontserratRegular"),
                                          )),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                      color:
                                      Color.fromRGBO(211, 172, 43, 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text("HIGHSCORES",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                "MontserratRegular"))),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<AuthenticationBloc>(
                                        context)
                                        .add(AuthenticationLoggedOut());
                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width /
                                        3,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFbf2431)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text("LOGOUT",
                                              style: TextStyle(
                                                  color: Color(0xFF0f3a3f),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  "MontserratRegular"))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
