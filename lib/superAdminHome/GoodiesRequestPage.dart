import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/adminHome/assign_videos.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/home/update_password.dart';
import 'package:player_pro_final/superAdminHome/bloc/superAdmin_event.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CreateUpdatePlayersPage.dart';
import 'bloc/superAdmin_bloc.dart';
import 'bloc/superAdmin_state.dart';
class GoodiesRequestPage extends StatelessWidget {
  final UserRepository userRepository;
  final UserModel userModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoodiesRequestPage(this.userModel,this.userRepository);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body:  BlocProvider(
          create: (context) {
            return SuperAdminHomeBloc(
              userModel: userModel,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository,
            )..add(GoodiesRequestEvent());
          },
          child: BlocListener<SuperAdminHomeBloc, SuperAdminHomeState>(
          listener: (context, state) {
            if(state is GoodieAcceptedLoaded)
              {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("The Request was Successful"),
                    backgroundColor: Colors.red,
                  ),
                );
              } else  if(state is GoodieAcceptedError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Oops..The Request for was not Successful..Please retry..!!"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
            child: BlocBuilder<SuperAdminHomeBloc, SuperAdminHomeState>(
              builder: (context,state) {
                if(state is GoodiesRequestLoading)
                  return LoadingIndicator();
                else if (state is SuperAdminHomeInitial) {
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
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => AssignVideoPage(
                                            userModel, userRepository)));
                              },
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.1,
                                      10,
                                      MediaQuery.of(context).size.width * 0.1,
                                      0),
                                  child:
                                  Image.asset("assets/AssignPractice.png")),
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<SuperAdminHomeBloc>(context).add(OpenVideosListEvent());
                                // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => UploadVideosPage(userModel,userRepository)));
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
                                // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => CreateGoodies(userModel,userRepository)));
                                BlocProvider.of<SuperAdminHomeBloc>(context).add(OpenGoodiesListPageEvent());

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
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (context) => GoodiesRequestPage(
                                        userModel, userRepository)));
                              },
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.1,
                                      10,
                                      MediaQuery.of(context).size.width * 0.1,
                                      0),
                                  child:
                                  Image.asset("assets/GoodiesRequest.png")),
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
                }
                else if(state is GoodiesRequestLoaded) {
                  return WillPopScope(
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
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                             Navigator.pop(context);
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
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back, color: Colors.white,),
                              onPressed: () {
                               Navigator.pop(context);
                              },
                            ),
                          ),
                        ),

                        Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                                  child: ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width *
                                        0.60, //height
                                    height:MediaQuery.of(context).size.height *
                                        0.045 ,//
                                    child: RaisedButton(
                                        child: Text("Pending Requests",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                            letterSpacing: 3),
                                        ),
                                        color: Color(0xFFbf2431),
                                        disabledColor:
                                        Color.fromARGB(191, 36, 49, 1),
                                        shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                        onPressed: () {
                                          BlocProvider.of<SuperAdminHomeBloc>(context).add(PendingGoodiesRequestsListEvent());
                                        }),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                                  child: ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width *
                                        0.60, //height
                                    height:MediaQuery.of(context).size.height *
                                        0.045 ,//
                                    child: RaisedButton(
                                        child: Text("Accepted Requests",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                            letterSpacing: 3),
                                        ),
                                        color: Color(0xFFbf2431),
                                        disabledColor:
                                        Color.fromARGB(191, 36, 49, 1),
                                        shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                        onPressed: () {
                                          BlocProvider.of<SuperAdminHomeBloc>(context).add(AcceptedGoodiesRequestListEvent());
                                        }),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                                  child: ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width *
                                        0.60, //height
                                    height:MediaQuery.of(context).size.height *
                                        0.045 ,//
                                    child: RaisedButton(
                                        child: Text("Rejected Requests",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                            letterSpacing: 3),
                                        ),
                                        color: Color(0xFFbf2431),
                                        disabledColor:
                                        Color.fromARGB(191, 36, 49, 1),
                                        shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                        onPressed: () {
                                          BlocProvider.of<SuperAdminHomeBloc>(context).add(RejectedGoodiesRequestsListEvent());
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if(state is PendingGoodiesRequestsListLoading)
                  return LoadingIndicator();
                else if(state is PendingGoodiesRequestsListLoaded) {
                  return WillPopScope(
                    onWillPop: () {
                      BlocProvider.of<SuperAdminHomeBloc>(context)
                          .add(SuperAdminHomeInitEvent());
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
                              icon: Icon(
                                Icons.arrow_back, color: Colors.white,),
                              onPressed: () {
                                BlocProvider.of<SuperAdminHomeBloc>(context).add(GoodiesRequestEvent());
                              },
                            ),
                          ),
                        ),

                        //Show List of Players Under the Admin.
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.1,
                              MediaQuery.of(context).size.height * 0.18,
                              MediaQuery.of(context).size.width * 0.1,
                              0),
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                              itemCount: state.shoppingItemsList.length,
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
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width : MediaQuery.of(context).size.width * 0.4,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              Wrap(children: [
                                                Container(
                                                  width :  MediaQuery.of(context).size.width * 0.4,
                                                  child: (index % 2 == 0)
                                                      ? Text(
                                                    state.shoppingItemsList[index]
                                                        .goodiesName
                                                        .toUpperCase(),
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 5,
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
                                                    state.shoppingItemsList[index]
                                                        .goodiesName
                                                        .toUpperCase(),
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "MontserratRegular",
                                                        fontSize: 18,
                                                        color: Color(0xFFbf2431)),
                                                  ),
                                                ),
                                              ],),

                                              Text(state.shoppingItemsList[index]
                                                  .userName
                                                  .toUpperCase(),
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      "MontserratRegular",
                                                      fontSize: 14,
                                                      color: Color(0xFFbf2431))),

                                                Text(state.shoppingItemsList[index]
                                                    .dateRaised
                                                    .toUpperCase(),
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "MontserratRegular",
                                                        fontSize: 10,
                                                        color: Color(0xFFbf2431)))
                                            ],),


                                          ),

                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<SuperAdminHomeBloc>(context)
                                                  .add(GoodieAcceptedEvent(state.shoppingItemsList[index],false,"Pending"));
                                            },
                                            disabledColor: Colors.white,
                                            icon: state.shoppingItemsList[index].status.contains("Rejected") && state.shoppingItemsList[index].status.isNotEmpty ? Icon(Icons.ac_unit,color: Color.fromRGBO(211, 172, 43, 1),) : Icon(Icons.clear),
                                            color: Colors.white,
                                          ),

                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<SuperAdminHomeBloc>(context)
                                                  .add(GoodieAcceptedEvent(state.shoppingItemsList[index],true,"Pending"));
                                            },
                                            disabledColor: Colors.white,
                                            icon: state.shoppingItemsList[index].status.contains("Accepted") && state.shoppingItemsList[index].status.isNotEmpty ? Icon(Icons.beenhere,color: Color.fromRGBO(211, 172, 43, 1),) : Icon(Icons.done),
                                            color: Colors.white,
                                          )
                                        ],
                                      ),

                                    ));
                              }),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              //BlocProvider.of<SuperAdminHomeBloc>(context)
                                 // .add(SuperAdminHomeInitEvent());
                              Navigator.pop(context);
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
                } else if(state is GoodieAcceptedLoading)
                  return LoadingIndicator();
                else if(state is AcceptedGoodiesRequestListLoading)
                  return LoadingIndicator();
                else if(state is AcceptedGoodiesRequestListLoaded) {
                  return WillPopScope(
                    onWillPop: () {
                      BlocProvider.of<SuperAdminHomeBloc>(context)
                          .add(SuperAdminHomeInitEvent());
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
                              icon: Icon(
                                Icons.arrow_back, color: Colors.white,),
                              onPressed: () {
                                BlocProvider.of<SuperAdminHomeBloc>(context).add(GoodiesRequestEvent());
                              },
                            ),
                          ),
                        ),

                        //Show List of Players Under the Admin.
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.1,
                              MediaQuery.of(context).size.height * 0.18,
                              MediaQuery.of(context).size.width * 0.1,
                              0),
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                              itemCount: state.shoppingItemsList.length,
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
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width : MediaQuery.of(context).size.width * 0.4,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Wrap(children: [
                                                  Container(
                                                    width :  MediaQuery.of(context).size.width * 0.4,
                                                    child: (index % 2 == 0)
                                                        ? Text(
                                                      state.shoppingItemsList[index]
                                                          .goodiesName
                                                          .toUpperCase(),
                                                      overflow: TextOverflow.clip,
                                                      maxLines: 5,
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
                                                      state.shoppingItemsList[index]
                                                          .goodiesName
                                                          .toUpperCase(),
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily:
                                                          "MontserratRegular",
                                                          fontSize: 18,
                                                          color: Color(0xFFbf2431)),
                                                    ),
                                                  ),
                                                ],),

                                                Text(state.shoppingItemsList[index]
                                                    .userName
                                                    .toUpperCase(),
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "MontserratRegular",
                                                        fontSize: 14,
                                                        color: Color(0xFFbf2431))),

                                                Text(state.shoppingItemsList[index]
                                                    .dateRaised
                                                    .toUpperCase(),
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "MontserratRegular",
                                                        fontSize: 10,
                                                        color: Color(0xFFbf2431)))
                                              ],),


                                          ),

                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<SuperAdminHomeBloc>(context)
                                                  .add(GoodieAcceptedEvent(state.shoppingItemsList[index],false,"Accept"));
                                            },
                                            disabledColor: Colors.white,
                                            icon: state.shoppingItemsList[index].status.contains("Rejected") && state.shoppingItemsList[index].status.isNotEmpty ? Icon(Icons.ac_unit,color: Color.fromRGBO(211, 172, 43, 1),) : Icon(Icons.clear),
                                            color: Colors.white,
                                          ),

                                          IconButton(
                                            onPressed: () {
                                             // BlocProvider.of<SuperAdminHomeBloc>(context)
                                                //  .add(GoodieAcceptedEvent(state.shoppingItemsList[index],true));
                                            },
                                            disabledColor: Colors.white,
                                            icon: state.shoppingItemsList[index].status.contains("Accepted") && state.shoppingItemsList[index].status.isNotEmpty ? Icon(Icons.beenhere,color: Color.fromRGBO(211, 172, 43, 1),) : Icon(Icons.done),
                                            color: Colors.white,
                                          )
                                        ],
                                      ),

                                    ));
                              }),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                             // BlocProvider.of<SuperAdminHomeBloc>(context)
                                  //.add(SuperAdminHomeInitEvent());
                              Navigator.pop(context);
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
                } else if(state is RejectedGoodiesRequestsListLoading)
                  return LoadingIndicator();
                else if(state is RejectedGoodiesRequestsListLoaded) {
                  return WillPopScope(
                    onWillPop: () {
                      BlocProvider.of<SuperAdminHomeBloc>(context)
                          .add(SuperAdminHomeInitEvent());
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
                              icon: Icon(
                                Icons.arrow_back, color: Colors.white,),
                              onPressed: () {
                                BlocProvider.of<SuperAdminHomeBloc>(context).add(GoodiesRequestEvent());
                              },
                            ),
                          ),
                        ),
                        //Show List of Players Under the Admin.
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.1,
                              MediaQuery.of(context).size.height * 0.18,
                              MediaQuery.of(context).size.width * 0.1,
                              0),
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                              itemCount: state.shoppingItemsList.length,
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
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width : MediaQuery.of(context).size.width * 0.4,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Wrap(children: [
                                                  Container(
                                                    width :  MediaQuery.of(context).size.width * 0.4,
                                                    child: (index % 2 == 0)
                                                        ? Text(
                                                      state.shoppingItemsList[index]
                                                          .goodiesName
                                                          .toUpperCase(),
                                                      overflow: TextOverflow.clip,
                                                      maxLines: 5,
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
                                                      state.shoppingItemsList[index]
                                                          .goodiesName
                                                          .toUpperCase(),
                                                      overflow: TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily:
                                                          "MontserratRegular",
                                                          fontSize: 18,
                                                          color: Color(0xFFbf2431)),
                                                    ),
                                                  ),
                                                ],),

                                                Text(state.shoppingItemsList[index]
                                                    .userName
                                                    .toUpperCase(),
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "MontserratRegular",
                                                        fontSize: 14,
                                                        color: Color(0xFFbf2431))),

                                                Text(state.shoppingItemsList[index]
                                                    .dateRaised
                                                    .toUpperCase(),
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "MontserratRegular",
                                                        fontSize: 10,
                                                        color: Color(0xFFbf2431)))
                                              ],),


                                          ),

                                          IconButton(
                                            onPressed: () {
                                             // BlocProvider.of<SuperAdminHomeBloc>(context)
                                               //   .add(GoodieAcceptedEvent(state.shoppingItemsList[index],false));
                                            },
                                            disabledColor: Colors.white,
                                            icon: state.shoppingItemsList[index].status.contains("Rejected") && state.shoppingItemsList[index].status.isNotEmpty ? Icon(Icons.ac_unit,color: Color.fromRGBO(211, 172, 43, 1),) : Icon(Icons.clear),
                                            color: Colors.white,
                                          ),

                                          IconButton(
                                            onPressed: () {
                                               BlocProvider.of<SuperAdminHomeBloc>(context)
                                                .add(GoodieAcceptedEvent(state.shoppingItemsList[index],true,"Reject"));
                                            },
                                            disabledColor: Colors.white,
                                            icon: state.shoppingItemsList[index].status.contains("Accepted") && state.shoppingItemsList[index].status.isNotEmpty ? Icon(Icons.beenhere,color: Color.fromRGBO(211, 172, 43, 1),) : Icon(Icons.done),
                                            color: Colors.white,
                                          )
                                        ],
                                      ),

                                    ));
                              }),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              //BlocProvider.of<SuperAdminHomeBloc>(context)
                                  //.add(SuperAdminHomeInitEvent());
                              Navigator.pop(context);
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
                else
                  return LoadingIndicator();
              },
            ),
          ),
        ),
      ),
    );



  }
}
