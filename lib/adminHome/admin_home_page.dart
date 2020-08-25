import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/adminHome/bloc/admin_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/home/ContactUs.dart';
import 'package:player_pro_final/home/ReportProbPage.dart';
import 'package:player_pro_final/home/bloc/home_bloc.dart';
import 'package:player_pro_final/home/update_password.dart';
import 'package:user_repository/fetchPlayersModel.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/IndividualPlayersModel.dart';
import 'assign_videos.dart';
import 'bloc/admin_event.dart';
import 'bloc/admin_state.dart';
import 'package:intl/intl.dart';
class AdminHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserRepository userRepository;
  IndividualLearningModel newIndiPlan;
  bool isSelected = false;
  AdminHomePage(this.userModel, this.userRepository);
  final UserModel userModel;
  List<String> pointsAssigned = new List<String>();
  List<TextEditingController> textFieldControllers = [];

  List<String> IndList = [
    "TARGET",
    "TECHNICAL",
    "PHYSICAL",
    "PSYCHOLOGICAL",
    "SOCIAL",
    "TACTICAL",
    "ADDITIONAL INFORMATION",
  ];

  String _target,_technical,_physical,_psychological,_social,_tactical,_additionalInfo;
  IndividualLearningModel indModel = new IndividualLearningModel();
  List<Map<String, Object>> _indiMapList;

  @override
  Widget build(BuildContext context) {

    Widget buildInd(String title, String desc,IndividualLearningModel indiModel) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
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
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFF3a3a3f)),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: title.contains("MESSAGE") ? 5 : 1,
                  maxLines: 8,
                  onChanged: (val) {
                    if(title.contains("TARGET")) {
                      _target = val;
                     // indModel.fields.target = val;
                      indiModel.fields.target = val;
                    }
                    else if(title.contains("TECHNICAL")) {
                      _technical = val;
                     // indModel.fields.technical = val;
                      indiModel.fields.technical = val;
                    }

                    else if(title.contains("PHYSICAL")) {
                      indModel.fields.physical = val;
                      _physical = val;
                      indiModel.fields.physical = val;
                    }
                    else if(title.contains("PSYCHOLOGICAL")) {
                      _psychological = val;
                     // indModel.fields.psychology = val;
                      indiModel.fields.psychology = val;
                    }

                    else if(title.contains("SOCIAL")) {
                     // indModel.fields.social = val;
                      _social = val;
                      indiModel.fields.social = val;
                    }

                    else if(title.contains("TACTICAL")) {
                    //  indModel.fields.tactical = val;
                      _tactical = val;
                      indiModel.fields.tactical = val;
                    }

                    else if(title.contains("ADDITIONAL INFORMATION")) {
                     // indModel.fields.information = val;
                      _additionalInfo = val;
                      indiModel.fields.information = val;
                    }
                  },
                  onSaved: (val) {
                    if(title.contains("TARGET")) {
                      _target = val;
                     // indModel.fields.target = val;
                      indiModel.fields.target = val;
                    }
                    else if(title.contains("TECHNICAL")) {
                      _technical = val;
                     // indModel.fields.technical = val;
                      indiModel.fields.technical = val;
                    }

                    else if(title.contains("PHYSICAL")) {
                     // indModel.fields.physical = val;
                      _physical = val;
                      indiModel.fields.physical = val;
                    }
                    else if(title.contains("PSYCHOLOGICAL")) {
                      _psychological = val;
                    //  indModel.fields.psychology = val;
                      indiModel.fields.psychology = val;
                    }

                    else if(title.contains("SOCIAL")) {
                    //  indModel.fields.social = val;
                      _social = val;
                      indiModel.fields.social = val;
                    }

                    else if(title.contains("TACTICAL")) {
                     // indModel.fields.tactical = val;
                      _tactical = val;
                      indiModel.fields.tactical = val;
                    }

                    else if(title.contains("ADDITIONAL INFORMATION")) {
                    //  indModel.fields.information = val;
                      _additionalInfo = val;
                      indiModel.fields.information = val;
                    }

                  },
                  initialValue: desc,
                  enabled: formattedDate.contains(indiModel.fields.date) ? true : false,
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
                        ),

                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFbf2431),
                              )),
                          child: ListTile(
                            leading: Text("Update Password",
                                style: TextStyle(
                                    color: Color.fromRGBO(211, 172, 43, 1),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MontserratRegular")),
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (_) => UpdatePasswordPage(
                                      userModel, userRepository)));
                            },
                          ),
                        ),
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
                } else if (state is SnackBarLoaded) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
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
                } else if(state is IndLearningDetailLSendLoaded) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Details Added"),
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
                                   //BlocProvider.of<AdminHomeBloc>(context).add(AssignVideosEvent());
                                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AssignVideoPage(userModel,userRepository)));
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
                                     BlocProvider.of<AdminHomeBloc>(context)
                                      .add(IndividualLearningPlan());
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
                                     BlocProvider.of<AdminHomeBloc>(context)
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
                                                    BlocProvider.of<AdminHomeBloc>(context).add(AssignPointsToPlayerEvent(state.fetchPlayers[index]
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
                  }  else if (state is IndLearningLoading) {
                    return LoadingIndicator();
                  } else if (state is IndLearningLoaded) {
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
                                  return InkWell(
                                    onTap: () {
                                      // BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanDetail(state.fetchPlayers[index]));
                                      BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanSavedList(state.fetchPlayers[index]));
                                    },
                                    child: Container(
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
                                        )),
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
                  }  else if (state is IndividualLearningPlanSavedListLoading) {
                    return LoadingIndicator();
                  } else if(state is IndividualLearningPlanSavedListLoaded) {
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

                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back,color: Colors.white,),
                                onPressed: () {
                                  BlocProvider.of<AdminHomeBloc>(context).add(AdminHomeInitEvent());
                                },
                              ),
                            ),
                          ),

                          Container(
                              padding: EdgeInsets.all(20),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    newIndiPlan = new IndividualLearningModel(model: "individualLearning.individuallearning",pk: -1);
                                    newIndiPlan.fields.target = "";
                                    newIndiPlan.fields.technical = "";
                                    newIndiPlan.fields.physical = "";
                                    newIndiPlan.fields.psychology = "";
                                    newIndiPlan.fields.social = "";
                                    newIndiPlan.fields.tactical = "";
                                    newIndiPlan.fields.information = "";
                                    newIndiPlan.fields.playerId = state.clickedPlayer.fields.id;
                                    newIndiPlan.fields.name = state.clickedPlayer.fields.name;
                                    newIndiPlan.fields.date = "";
                                    DateTime now = DateTime.now();
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                                    bool checkIfDateAlreadyPresent = false;
                                    for(IndividualLearningModel indCheck in state.indiPlanForPlayerList) {
                                      if(formattedDate.contains(indCheck.fields.date)) {
                                        BlocProvider.of<AdminHomeBloc>(context).add(SnackBarEvent("Learning Plan for Today already created..!"));
                                       // BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanSavedList(state.clickedPlayer));
                                        checkIfDateAlreadyPresent = true;
                                      }
                                    }
                                    if(checkIfDateAlreadyPresent == false)
                                    BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanDetail(state.clickedPlayer,newIndiPlan));
                                  },
                                  child: Icon(Icons.add),
                                ),
                              )),

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
                                itemCount: state.indiPlanForPlayerList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanDetail(state.fetchPlayers[index]));
                                      BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanDetail(state.clickedPlayer,state.indiPlanForPlayerList[index]));
                                    },
                                    child: Container(
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
                                              state.indiPlanForPlayerList[index]
                                                  .fields.date
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
                                              state.indiPlanForPlayerList[index]
                                                  .fields.date
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
                                        )),
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
                  }
                  else if (state is IndLearningDetailLoading) {
                    return LoadingIndicator();
                  } else if (state is IndLearningDetailLLoaded) {
                    return WillPopScope(
                      onWillPop: () {
                        BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlan());
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
                                  if(IndList[index].contains("TARGET")) {
                                   // indModel.fields.target = state.indiPlanForPlayer.fields.target;
                                    desc = state.indiPlanForPlayer.fields.target;
                                  }

                                  else if(IndList[index].contains("TECHNICAL")) {
                                   // indModel.fields.technical = state.indiPlanForPlayer.fields.technical;
                                    desc = state.indiPlanForPlayer.fields.technical;
                                  }

                                  else if(IndList[index].contains("PHYSICAL")) {
                                  //  indModel.fields.physical = state.indiPlanForPlayer.fields.physical;
                                    desc = state.indiPlanForPlayer.fields.physical;
                                  }

                                  else if(IndList[index].contains("PSYCHOLOGICAL")) {
                                   // indModel.fields.psychology = state.indiPlanForPlayer.fields.psychology;
                                    desc = state.indiPlanForPlayer.fields.psychology;
                                  }

                                  else if(IndList[index].contains("SOCIAL")) {
                                   // indModel.fields.social = state.indiPlanForPlayer.fields.social;
                                    desc = state.indiPlanForPlayer.fields.social;
                                  }

                                  else if(IndList[index].contains("TACTICAL")) {
                                   // indModel.fields.tactical = state.indiPlanForPlayer.fields.tactical;
                                    desc = state.indiPlanForPlayer.fields.tactical;
                                  }

                                  else {
                                   // indModel.fields.information = state.indiPlanForPlayer.fields.information;
                                    desc = state.indiPlanForPlayer.fields.information;
                                  }

                                  return buildInd(IndList[index],desc,state.indiPlanForPlayer);
                                }),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back,color: Colors.white,),
                                onPressed: () {
                                  BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanSavedList(state.clickedPlayer));
                                },
                              ),
                            ),
                          ),


                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width *
                                    0.60, //height
                                height:MediaQuery.of(context).size.height *
                                    0.045 ,//
                                child: RaisedButton(
                                  child: Text("SEND",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                  letterSpacing: 3),

                                ),
                                    color: Color(0xFFbf2431),
                                    disabledColor:
                                    Color.fromARGB(191, 36, 49, 1),
                                    shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                    onPressed: () {
                                     // indModel.fields.playerId = state.clickedPlayer.fields.id;
                                    //  indModel.fields.name = state.clickedPlayer.fields.name;

                                      state.indiPlanForPlayer.fields.playerId = state.clickedPlayer.fields.id;
                                      state.indiPlanForPlayer.fields.name = state.clickedPlayer.fields.name;
                                      BlocProvider.of<AdminHomeBloc>(context).add(IndividualLearningPlanDetailSend(state.indiPlanForPlayer));
                                    }),
                              ),
                            ),

                          )


                        ],
                      ),
                    );
                  } else if(state is IndLearningDetailSendLoading)  {
                    return LoadingIndicator();
                  } else if (state is GetHighScoresLoading) {
                    return LoadingIndicator();
                  } else if (state is GetHighScoresLoaded) {
                    List<PlayerPoints> playerPoints = state.userModels;
                    return WillPopScope(
                      onWillPop: () {
                        BlocProvider.of<AdminHomeBloc>(context).add(AdminHomeInitEvent());
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
                                  //BlocProvider.of<AdminHomeBloc>(context).add(AssignVideosEvent());
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AssignVideoPage(userModel,userRepository)));
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
                                  BlocProvider.of<AdminHomeBloc>(context)
                                      .add(IndividualLearningPlan());
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
