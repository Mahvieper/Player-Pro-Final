import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/adminHome/bloc/admin_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/home/ContactUs.dart';
import 'package:player_pro_final/home/ReportProbPage.dart';
import 'package:user_repository/user_repository.dart';

import 'bloc/admin_event.dart';
import 'bloc/admin_state.dart';

class AdminHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserRepository userRepository;
  AdminHomePage(this.userModel, this.userRepository);
  final UserModel userModel;
  List<String> pointsAssigned = new List<String>();
  List<TextEditingController> textFieldControllers = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return AdminHomeBloc(
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
            body: BlocListener<AdminHomeBloc, AdminHomeState>(
              listener: (context, state) {
                if (state is AdminHomeError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error Loading Home'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                else if (state is AssignPointsToPlayerError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is AssignPointsToPlayerLoaded) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Points Assigned"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: BlocBuilder<AdminHomeBloc, AdminHomeState>(
                builder: (context, state) {
                  if (state is AdminHomeInProgress) {
                    return LoadingIndicator();
                  } else if (state is AdminHomeInitial) {
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
                                  BlocProvider.of<AdminHomeBloc>(context)
                                      .add(FetchPlayers(userModel));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        10,
                                        MediaQuery.of(context).size.width * 0.1,
                                        0),
                                    child: Image.asset(
                                        "assets/AdminMyPlayers.png")),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<AdminHomeBloc>(context)
                                      .add(AssignPointsEvent(userModel));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        10,
                                        MediaQuery.of(context).size.width * 0.1,
                                        0),
                                    child: Image.asset(
                                        "assets/AdminMyPoints.png")),
                              ),
                              InkWell(
                                onTap: () {
                                  //   Navigator.of(context).push(new MaterialPageRoute(builder: (_) => PracticePage(userModel)));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        10,
                                        MediaQuery.of(context).size.width * 0.1,
                                        0),
                                    child: Image.asset(
                                        "assets/AdminMyPractice.png")),
                              ),
                              InkWell(
                                onTap: () {
                                  //   BlocProvider.of<HomeBloc>(context)
                                  //     .add(IndividualLearningPlan());
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        10,
                                        MediaQuery.of(context).size.width * 0.1,
                                        0),
                                    child:
                                        Image.asset("assets/AdminMyIndi.png")),
                              ),
                            ],
                          ),
                        ),
                        //footer
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  //    BlocProvider.of<HomeBloc>(context)
                                  //     .add(GetHighScoreEvent());
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
                  } else if (state is FetchPlayersLoading) {
                    return LoadingIndicator();
                  } else if (state is FetchPlayersLoaded) {
                    return WillPopScope(
                      onWillPop: () {
                        BlocProvider.of<AdminHomeBloc>(context)
                            .add(AdminHomeInitEvent());
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
                              //  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.1,
                                  MediaQuery.of(context).size.height * 0.2,
                                  MediaQuery.of(context).size.width * 0.1,
                                  0),
                              child: Image.asset("assets/MyPlayersTitle.png")),
                          //Show List of Players Under the Admin.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.1,
                                MediaQuery.of(context).size.height * 0.28,
                                MediaQuery.of(context).size.width * 0.1,
                                0),
                            child: ListView.builder(
                                itemCount: state.fetchPlayers.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        border: (index % 2 == 0)
                                            ? Border.all(
                                                color: Color(0xFFbf2431))
                                            : Border.all(
                                                color: Color.fromRGBO(
                                                    211, 172, 43, 1)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Center(
                                          child: (index % 2 == 0)
                                              ? Text(
                                                  state.fetchPlayers[index]
                                                      .fields.name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          "MontserratRegular",
                                                      fontSize: 18,
                                                      color: Color.fromRGBO(
                                                          211, 172, 43, 1)),
                                                )
                                              : Text(
                                                  state.fetchPlayers[index]
                                                      .fields.name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          "MontserratRegular",
                                                      fontSize: 18,
                                                      color: Color(0xFFbf2431)),
                                                ),
                                        ),
                                      ));
                                }),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<AdminHomeBloc>(context)
                                    .add(AdminHomeInitEvent());
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
                                              0.08),
                                      child: Text(
                                        "HOME",
                                        style: TextStyle(
                                            color: Color(0xFF0f3a3f),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "MontserratRegular"),
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is AssignPointsLoading) {
                    return LoadingIndicator();
                  } else if (state is AssignPointsLoaded) {
                    return WillPopScope(
                      onWillPop: () {
                        BlocProvider.of<AdminHomeBloc>(context)
                            .add(AdminHomeInitEvent());
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
                              //  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.1,
                                  MediaQuery.of(context).size.height * 0.2,
                                  MediaQuery.of(context).size.width * 0.1,
                                  0),
                              child: Image.asset("assets/MyPointsTitle.png")),
                          //Show List of Players Under the Admin.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.1,
                                MediaQuery.of(context).size.height * 0.28,
                                MediaQuery.of(context).size.width * 0.1,
                                0),
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: ListView.builder(
                                itemCount: state.fetchPlayers.length,
                                itemBuilder: (context, index) {
                                  for (var i = 0;
                                      i < state.fetchPlayers.length;
                                      i++) {
                                    textFieldControllers
                                        .add(TextEditingController());
                                  }
                                  return Column(
                                    children: [
                                      //Players Name
                                      Container(
                                          margin: EdgeInsets.only(top: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    211, 172, 43, 1)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                                child: Text(
                                              state.fetchPlayers[index].fields
                                                  .name
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      "MontserratRegular",
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      211, 172, 43, 1)),
                                            )),
                                          )),
                                      //Box to enter Points to player.
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                211, 172, 43, 1)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      3, 1, 3, 2),
                                                  //  width : MediaQuery.of(context).size.width / 3,
                                                  child: TextField(
                                                    controller:
                                                        textFieldControllers[
                                                            index],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "MontserratRegular",
                                                    ),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.black38),
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              20.0,
                                                              15.0,
                                                              20.0,
                                                              15.0),
                                                      hintText:
                                                          "POINTS TO BE ASSIGNED",
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              ButtonTheme(
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06, //height
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.052,

                                                child: RaisedButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                AdminHomeBloc>(
                                                            context)
                                                        .add(
                                                            AssignPointsToPlayerEvent(
                                                      state.fetchPlayers[index]
                                                          .fields.id
                                                          .toString(),
                                                      textFieldControllers[
                                                              index]
                                                          .text,
                                                    ));
                                                  },
                                                  child: Text(
                                                    "ASSIGN",
                                                    style: TextStyle(
                                                      color: Color(0xFF0f3a3f),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          "MontserratRegular",
                                                    ),
                                                  ),
                                                  color: Color(0xFFbf2431),
                                                  disabledColor: Color.fromARGB(
                                                      191, 36, 49, 1),
                                                ), // : 100.// 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<AdminHomeBloc>(context)
                                    .add(AdminHomeInitEvent());
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
                                              0.08),
                                      child: Text(
                                        "HOME",
                                        style: TextStyle(
                                            color: Color(0xFF0f3a3f),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "MontserratRegular"),
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is AssignPointsToPlayerLoading) {
                    return LoadingIndicator();
                  } else if (state is AssignPointsToPlayerLoaded) {
                    return LoadingIndicator();
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
                                  BlocProvider.of<AdminHomeBloc>(context)
                                      .add(FetchPlayers(userModel));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        10,
                                        MediaQuery.of(context).size.width * 0.1,
                                        0),
                                    child: Image.asset(
                                        "assets/AdminMyPlayers.png")),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.1,
                                      10,
                                      MediaQuery.of(context).size.width * 0.1,
                                      0),
                                  child:
                                      Image.asset("assets/AdminMyPoints.png")),
                              InkWell(
                                onTap: () {
                                  //   Navigator.of(context).push(new MaterialPageRoute(builder: (_) => PracticePage(userModel)));
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        10,
                                        MediaQuery.of(context).size.width * 0.1,
                                        0),
                                    child: Image.asset(
                                        "assets/AdminMyPractice.png")),
                              ),
                              InkWell(
                                onTap: () {
                                  //   BlocProvider.of<HomeBloc>(context)
                                  //     .add(IndividualLearningPlan());
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        10,
                                        MediaQuery.of(context).size.width * 0.1,
                                        0),
                                    child:
                                        Image.asset("assets/AdminMyIndi.png")),
                              ),
                            ],
                          ),
                        ),
                        //footer
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  //    BlocProvider.of<HomeBloc>(context)
                                  //     .add(GetHighScoreEvent());
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
          ),
        ));
  }
}
