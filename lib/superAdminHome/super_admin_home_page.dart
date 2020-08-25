import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/home/update_password.dart';
import 'package:user_repository/user_repository.dart';

import 'CreateUpdatePlayersPage.dart';
import 'bloc/superAdmin_bloc.dart';
import 'bloc/superAdmin_event.dart';
import 'bloc/superAdmin_state.dart';

class SuperAdminHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserRepository userRepository;
  final UserModel userModel;

  SuperAdminHomePage(this.userModel, this.userRepository);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SuperAdminHomeBloc(
          userModel: userModel,
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: userRepository,
        )..add(SuperAdminHomeInitEvent());
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
            body: BlocListener<SuperAdminHomeBloc, SuperAdminHomeState>(
                listener: (context, state) {
              if (state is SuperAdminHomeError) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error Loading Home'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }, child: BlocBuilder<SuperAdminHomeBloc, SuperAdminHomeState>(
                    builder: (context, state) {
              if (state is SuperAdminHomeInProgress) {
                return LoadingIndicator();
              } else if (state is SuperAdminHomeInitial) {
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
                              // BlocProvider.of<SuperAdminHomeBloc>(context)
                              //    .add(CreateOrUpdatePlayersEvent());
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => CreateUpdatePlayersPage(
                                      userModel, userRepository)));
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.1,
                                    10,
                                    MediaQuery.of(context).size.width * 0.1,
                                    0),
                                child:
                                    Image.asset("assets/UserCreateUpdate.png")),
                          ),
                          InkWell(
                            onTap: () {
                              //  BlocProvider.of<SuperAdminHomeBloc>(context)
                              //  .add(AssignPointsEvent(userModel));
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => CreateUpdatePlayersPage(
                                      userModel, userRepository)));
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.1,
                                    10,
                                    MediaQuery.of(context).size.width * 0.1,
                                    0),
                                child: Image.asset("assets/AssignPractice.png")),
                          ),
                          InkWell(
                            onTap: () {
                              //BlocProvider.of<AdminHomeBloc>(context).add(AssignVideosEvent());
                              // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AssignVideoPage(userModel,userRepository)));
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.1,
                                    10,
                                    MediaQuery.of(context).size.width * 0.1,
                                    0),
                                child:
                                    Image.asset("assets/UploadPractice.png")),
                          ),
                          InkWell(
                            onTap: () {
                              // BlocProvider.of<SuperAdminHomeBloc>(context)
                              //  .add(IndividualLearningPlan());
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.1,
                                    10,
                                    MediaQuery.of(context).size.width * 0.1,
                                    0),
                                child: Image.asset("assets/CreateGoodies.png")),
                          ),

                          InkWell(
                            onTap: () {
                              // BlocProvider.of<SuperAdminHomeBloc>(context)
                              //  .add(IndividualLearningPlan());
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.1,
                                    10,
                                    MediaQuery.of(context).size.width * 0.1,
                                    0),
                                child: Image.asset("assets/GoodiesRequest.png")),
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
                              // BlocProvider.of<SuperAdminHomeBloc>(context)
                              //  .add(GetHighScoreEvent());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(211, 172, 43, 1)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
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
                                        left:
                                            MediaQuery.of(context).size.width *
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
              } else
                return LoadingIndicator();
            }))),
      ),
    );
  }
}
