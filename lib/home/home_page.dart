import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/home/PracticePage.dart';
import 'package:player_pro_final/home/bloc/home_bloc.dart';
import 'package:player_pro_final/home/bloc/home_event.dart';
import 'package:player_pro_final/home/bloc/home_state.dart';
import 'package:user_repository/user_repository.dart';

import 'ContactUs.dart';
import 'ReportProbPage.dart';

class HomePage extends StatelessWidget {
  final UserRepository userRepository;
  HomePage(this.userModel, this.userRepository);
  final UserModel userModel;
  String _contactEmail;
  List<String> optionStr = ["My Points", "Shop", "My Target", "Practice"];
  List<String> optionImg = [
    "assets/mypointsIcon.png",
    "assets/shopIcon.png",
    "assets/mytargetIcon.png",
    "assets/practiceIcon.png"
  ];

  final double circleRadius = 100.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> IndList = [
    "TARGET",
    "TECHNICAL",
    "PHYSICAL",
    "PSYCHOLOGICAL",
    "SOCIAL",
    "TACTICAL",
    "ADDITIONAL INFORMATION",
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildInd(String title, String desc) {
      return Container(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(211, 172, 43, 1), width: 0.5)),
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(211, 172, 43, 1),
                            width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Color.fromRGBO(211, 172, 43, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: "MontserratRegular",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFF3a3a3f)),
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "MontserratRegular",
                  ),
                ),
              )
            ],
          ));
    }

    Widget buildInputs(String title) {
      return Container(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(211, 172, 43, 1), width: 0.5)),
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(211, 172, 43, 1),
                            width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Color.fromRGBO(211, 172, 43, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: "MontserratRegular",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFF3a3a3f)),
                child: TextFormField(
                  onSaved: (val) => _contactEmail = val,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "MontserratRegular",
                  ),
                ),
              )
            ],
          ));
    }

    return BlocProvider(
        create: (context) {
          return HomeBloc(
            userModel: userModel,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
          child: SafeArea(
              child: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: SafeArea(
                  right: false,
                  child: Container(
                    color: Color(0xFF3a3a3a),
                    child: ListView(
                      children: [
                        Container(
                          height: 130,
                          color: Color.fromRGBO(43, 43, 43, 1),
                          child: Center(
                              child:
                                  Image.asset("assets/logo.png", height: 100)),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Color(0xFFbf2431),
                          )),
                          child: ListTile(
                            leading: Text(
                              "Contact Us",
                              style: TextStyle(
                                  color: Color.fromRGBO(211, 172, 43, 1),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MontserratRegular"),
                            ),
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (_) => ContactUsPage(
                                      userModel, userRepository)));
                              //  BlocProvider.of(context).add(ContactUsEvent());
                              // BlocProvider.of<HomeBloc>(context).add(ContactUsEvent());
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Color(0xFFbf2431),
                          )),
                          child: ListTile(
                            leading: Text("Report Problem",
                                style: TextStyle(
                                    color: Color.fromRGBO(211, 172, 43, 1),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MontserratRegular")),
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (_) => ReportProbPage(
                                      userModel, userRepository)));
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            body: BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error Loading Home'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if(state is ItemPurchasedLoaded) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Your Purchase for Item '+ state.purchasedItem.goodiesName.toUpperCase() + ' is Successful'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if(state is ItemPurchasedError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

              },
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeInProgress)
                    return LoadingIndicator();
                  else if (state is HomeInitial) {
                    return Stack(
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
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                        ),

                        //The Sections.
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(FetchPoints(userModels: userModel));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                    child: Image.asset("assets/myPoints.png")),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(ShopEvent());
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                    child: Image.asset("assets/myShop.png")),
                              ),
                              InkWell(
                                onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(builder: (_) => PracticePage(userModel)));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                    child: Image.asset("assets/practiceHome.png")),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(IndividualLearningPlan());
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                    child:
                                        Image.asset("assets/myIndividual.png")),
                              ),
                            ],
                          ),
                        ),
                        //footer
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(GetCoachEvent());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFbf2431),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: Text(
                                          "MY COACH",
                                          style: TextStyle(
                                              color: Color(0xFF0f3a3f),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "MontserratRegular"),
                                        )),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(GetHighScoreEvent());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(211, 172, 43, 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Text(
                                          "HIGHSCORES",
                                          style: TextStyle(
                                              color: Color(0xFF0f3a3f),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "MontserratRegular"),
                                        )),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthenticationLoggedOut());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration:
                                      BoxDecoration(color: Color(0xFFbf2431)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07),
                                        child: Text(
                                          "LOGOUT",
                                          style: TextStyle(
                                              color: Color(0xFF0f3a3f),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "MontserratRegular"),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  else if (state is HomePointsLoading)
                    return Center(
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
                          Center(
                            child: Image.asset(
                              "assets/loadingGif.gif",
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                    );
                  else if (state is HomePointsLoaded) {
                    return WillPopScope(
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
                                    border: Border.all(
                                        color: Color.fromRGBO(211, 172, 43, 1),
                                        width: 0.5),
                                    color: Color(0xFF3a3a3a),
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
                                          color: Color(0xFFbf2431),
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.yellow)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          state.userModels.points,
                                          style: TextStyle(
                                              letterSpacing: 3,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: "MontserratRegular"),
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
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 0.5),
                                    color: Color(0xFF3a3a3a),
                                  ),
                                  child: Center(
                                      child: Text(
                                    state.userModels.weekPoints,
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Color(0xFFbf2431),
                                        fontFamily: "MontserratRegular"),
                                  )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "POINTS",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
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
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<HomeBloc>(context).add(ShopEvent());
                                        },
                                        child: Image.asset(
                                          "assets/shopSec.png",
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.035,
                                        ),
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
                                            MediaQuery.of(context).size.width / 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            "MY COACH",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "MontserratRegular"),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(211, 172, 43, 1)),
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
                                            MediaQuery.of(context).size.width / 3,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFbf2431)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text("LOGOUT",
                                                  style: TextStyle(
                                                      color: Color(0xFF0f3a3f),
                                                      fontWeight: FontWeight.bold,
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
                    );
                  } else if (state is IndLearningLoading) {
                    return LoadingIndicator();
                  } else if (state is IndLearningLoaded) {
                    return WillPopScope(
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
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.18),
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                                itemCount: IndList.length,
                                itemBuilder: (context, index) {
                                  String desc="";
                                  if(IndList[index].contains("TARGET"))
                                    desc = state.indiLearnList[0].target;
                                  else if(IndList[index].contains("TECHNICAL"))
                                    desc = state.indiLearnList[0].technical;
                                  else if(IndList[index].contains("PHYSICAL"))
                                    desc = state.indiLearnList[0].physical;
                                  else if(IndList[index].contains("PSYCHOLOGICAL"))
                                    desc = state.indiLearnList[0].psychology;
                                  else if(IndList[index].contains("SOCIAL"))
                                    desc = state.indiLearnList[0].social;
                                  else if(IndList[index].contains("TACTICAL"))
                                    desc = state.indiLearnList[0].tactical;
                                  else
                                    desc = state.indiLearnList[0].information;
                                  return buildInd(IndList[index],desc);
                                }),
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(new MaterialPageRoute(builder: (_) => PracticePage(userModel)));
                                        },
                                        child: Image.asset(
                                          "assets/myPractice.png",
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.035,
                                        ),
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
                                            MediaQuery.of(context).size.width / 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            "MY COACH",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "MontserratRegular"),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(211, 172, 43, 1)),
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
                                            MediaQuery.of(context).size.width / 3,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFbf2431)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text("LOGOUT",
                                                  style: TextStyle(
                                                      color: Color(0xFF0f3a3f),
                                                      fontWeight: FontWeight.bold,
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
                    );
                  } else if (state is GetCoachLoading)
                    return LoadingIndicator();
                  else if (state is GetCoachLoaded) {
                    return Stack(
                      children: [
                        WillPopScope(
                          onWillPop: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(HomeInitEvent());
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
                                      padding: EdgeInsets.only(
                                          top: circleRadius / 2.0),
                                      child: Wrap(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                                padding:
                                                    const EdgeInsets.all(15.0),
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                          top:
                                              MediaQuery.of(context).size.height *
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
                                                    "https://i.ibb.co/WgWqxhj/shridhar-1.png",
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(GetCoachEvent());
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 3,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFbf2431),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.05),
                                              child: Text(
                                                "MY COACH",
                                                style: TextStyle(
                                                    color: Color(0xFF0f3a3f),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "MontserratRegular"),
                                              )),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(GetHighScoreEvent());
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 3,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(211, 172, 43, 1)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.03),
                                              child: Text(
                                                "HIGHSCORES",
                                                style: TextStyle(
                                                    color: Color(0xFF0f3a3f),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "MontserratRegular"),
                                              )),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<AuthenticationBloc>(context)
                                            .add(AuthenticationLoggedOut());
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 3,
                                        decoration:
                                        BoxDecoration(color: Color(0xFFbf2431)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.07),
                                              child: Text(
                                                "LOGOUT",
                                                style: TextStyle(
                                                    color: Color(0xFF0f3a3f),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "MontserratRegular"),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (state is GetHighScoresLoading) {
                    return LoadingIndicator();
                  } else if (state is GetHighScoresLoaded) {
                    List<PlayerPoints> playerPoints = state.userModels;
                    return WillPopScope(
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

                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.15),
                            height: MediaQuery.of(context).size.height * 0.6,
                            padding: EdgeInsets.all(30),
                            child: ListView.builder(
                                itemCount: playerPoints.length,
                                itemBuilder: (context, index) {
                                  return Wrap(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: (index % 2 == 0)
                                                      ? Color.fromRGBO(
                                                          211, 172, 43, 1)
                                                      : Color(0xFFbf2431))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    playerPoints[index]
                                                        .fields
                                                        .name
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: (index % 2 == 0)
                                                            ? Color.fromRGBO(
                                                                211, 172, 43, 1)
                                                            : Color(0xFFbf2431),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "MontserratRegular")),
                                              ),
                                              Container(
                                                  height: 50,
                                                  width: 80,
                                                  color: (index % 2 == 0)
                                                      ? Color.fromRGBO(
                                                          211, 172, 43, 1)
                                                      : Color(0xFFbf2431),
                                                  child: Center(
                                                      child: Text(
                                                          playerPoints[index]
                                                              .fields
                                                              .points,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "MontserratRegular")))),
                                            ],
                                          )),
                                    ],
                                  );
                                }),
                          ),

                          //footer
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(new MaterialPageRoute(builder: (_) => PracticePage(userModel)));
                                        },
                                        child: Image.asset(
                                          "assets/myPractice.png",
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.035,
                                        ),
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
                                            MediaQuery.of(context).size.width / 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            "MY COACH",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "MontserratRegular"),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(211, 172, 43, 1)),
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
                                            MediaQuery.of(context).size.width / 3,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFbf2431)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text("LOGOUT",
                                                  style: TextStyle(
                                                      color: Color(0xFF0f3a3f),
                                                      fontWeight: FontWeight.bold,
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
                    );
                  } else if (state is ContactUsLoading) {
                    return LoadingIndicator();
                  } else if (state is ContactUsLoaded) {
                    return WillPopScope(
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
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.15),
                            height: MediaQuery.of(context).size.height * 0.6,
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                buildInputs("NAME"),
                                buildInputs("E-MAIL"),
                                buildInputs("MESSAGE")
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if(state is ShopLoading) {
                    return LoadingIndicator();
                  } else if (state is ShopLoaded) {
                    return WillPopScope(
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
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back,color: Colors.white,),
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(context).add(HomeInitEvent());
                                },
                              ),
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.17),
                            height: MediaQuery.of(context).size.height * 0.70,
                            child: ListView.builder(
                                itemCount: state.shoppingItemsList.length,
                                itemBuilder: (context,index) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFbf2431))
                                    ),
                                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030),
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      children: [
                                        Image.network(state.shoppingItemsList[index].image,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        width: MediaQuery.of(context).size.height * 0.6,
                                        fit: BoxFit.fill,),
                                        Container(
                                          width: MediaQuery.of(context).size.height * 0.6,
                                          decoration: BoxDecoration(
                                             color: Color.fromRGBO(211, 172, 43, 1)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(child: Text(state.shoppingItemsList[index].name,style: TextStyle(color: Color(0xFF0f3a3f), fontWeight: FontWeight.bold, fontSize : 18,fontFamily: "MontserratRegular"),)),
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(58, 58, 58, 1)
                                              ),
                                              padding: EdgeInsets.all(15),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Text(state.shoppingItemsList[index].pointsRequired.toString(),style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize : 18,fontFamily: "MontserratRegular"),),
                                                    SizedBox(width: 10,),
                                                    Text("POINTS",style: TextStyle(color: Color.fromRGBO(211, 172, 43, 1),fontSize : 18,fontFamily: "MontserratRegular",fontWeight: FontWeight.bold,)),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              child: InkWell(
                                                onTap : () {
                                                  BlocProvider.of<HomeBloc>(context).add(ItemConfirmationEvent(state.shoppingItemsList[index],userModel));
                                                  },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFbf2431),
                                                  ),
                                                  padding: EdgeInsets.all(15),
                                                  child: Center(
                                                    child: Text("BUY IT",style: TextStyle(color: Color.fromRGBO(211, 172, 43, 1),fontSize : 16,fontFamily: "MontserratRegular",fontWeight: FontWeight.bold,)),
                                                  ),
                                                ),
                                              ),
                                            )


                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                            }),
                          ),

                          //footer
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(GetCoachEvent());
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFbf2431),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.05),
                                          child: Text(
                                            "MY COACH",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "MontserratRegular"),
                                          )),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(GetHighScoreEvent());
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(211, 172, 43, 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.03),
                                          child: Text(
                                            "HIGHSCORES",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "MontserratRegular"),
                                          )),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(AuthenticationLoggedOut());
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 3,
                                    decoration:
                                    BoxDecoration(color: Color(0xFFbf2431)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.07),
                                          child: Text(
                                            "LOGOUT",
                                            style: TextStyle(
                                                color: Color(0xFF0f3a3f),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "MontserratRegular"),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  } else if(state is ItemPurchasedLoading) {
                    return LoadingIndicator();
                  } else if(state is ItemConfirmationLoading)
                    return LoadingIndicator();
                  else if(state is ItemConfirmationLoaded) {
                    return WillPopScope(
                      onWillPop: () {
                        BlocProvider.of<HomeBloc>(context).add(ShopEvent());
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
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back,color: Colors.white,),
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(context).add(ShopEvent());
                                },
                              ),
                            ),
                          ),

                          Center(
                            child: Container(
                              child: Wrap(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xFFbf2431))
                                    ),
                                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030),
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context).size.height * 0.6,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(211, 172, 43, 1)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text(state.shoppingItem.name,style: TextStyle(color: Color(0xFF0f3a3f), fontWeight: FontWeight.bold, fontSize : 18,fontFamily: "MontserratRegular"),),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(state.shoppingItem.pointsRequired.toString(),style: TextStyle(color: Colors.white,fontSize : 18,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular"),),
                                                      SizedBox(width: 10,),
                                                      Text("POINTS",style: TextStyle(color: Color(0xFF0f3a3f),fontWeight: FontWeight.bold, fontSize : 16,fontFamily: "MontserratRegular"),)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                        ),

                                        Image.network(state.shoppingItem.image,
                                          height: MediaQuery.of(context).size.height * 0.3,
                                          width: MediaQuery.of(context).size.height * 0.6,
                                          fit: BoxFit.fill,),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                        Text("ARE YOU SURE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize : 16,fontFamily: "MontserratRegular")),
                                        Text("YOU WANT TO BUY THIS ITEM",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize : 16,fontFamily: "MontserratRegular")),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap:  () {
                                                  BlocProvider.of<HomeBloc>(context).add(ItemPurchasedEvent(state.shoppingItem,state.currentPlayer));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(211, 172, 43, 1)
                                                  ),
                                                  padding: EdgeInsets.all(15),
                                                  child: Center(
                                                    child: Text("YES",style: TextStyle(color: Color(0xFF0f3a3f), fontWeight: FontWeight.bold, fontSize : 18,fontFamily: "MontserratRegular"),),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              child: InkWell(
                                                onTap : () {
                                                  BlocProvider.of<HomeBloc>(context).add(ShopEvent());
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFbf2431),
                                                  ),
                                                  padding: EdgeInsets.all(15),
                                                  child: Center(
                                                    child: Text("NO",style: TextStyle(color: Color.fromRGBO(211, 172, 43, 1),fontSize : 18,fontFamily: "MontserratRegular",fontWeight: FontWeight.bold,)),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    );
                  } else
                    return Stack(
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
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                        ),

                        //The Sections.
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(FetchPoints(userModels: userModel));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                    child: Image.asset("assets/myPoints.png")),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                  child: Image.asset("assets/myShop.png")),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (_) => PracticePage(userModel)));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                    child: Image.asset("assets/practiceHome.png")),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(IndividualLearningPlan());
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                                    child:
                                    Image.asset("assets/myIndividual.png")),
                              ),
                            ],
                          ),
                        ),
                        //footer
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(GetCoachEvent());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFbf2431),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.05),
                                        child: Text(
                                          "MY COACH",
                                          style: TextStyle(
                                              color: Color(0xFF0f3a3f),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "MontserratRegular"),
                                        )),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(GetHighScoreEvent());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(211, 172, 43, 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        child: Text(
                                          "HIGHSCORES",
                                          style: TextStyle(
                                              color: Color(0xFF0f3a3f),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "MontserratRegular"),
                                        )),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthenticationLoggedOut());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration:
                                  BoxDecoration(color: Color(0xFFbf2431)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.07),
                                        child: Text(
                                          "LOGOUT",
                                          style: TextStyle(
                                              color: Color(0xFF0f3a3f),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "MontserratRegular"),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                },
              ),
            ),
          )),
        );
  }
}
