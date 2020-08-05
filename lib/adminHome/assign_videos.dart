import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/adminHome/bloc/admin_event.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:user_repository/fetchPlayersModel.dart';
import 'package:user_repository/user_repository.dart';

import 'bloc/admin_bloc.dart';
import 'bloc/admin_state.dart';

class AssignVideoPage extends StatefulWidget {
  final UserModel userModel;
  final UserRepository userRepository;
  AssignVideoPage(this.userModel,this.userRepository);
  @override
  _AssignVideoPageState createState() => _AssignVideoPageState();
}

class _AssignVideoPageState extends State<AssignVideoPage> {
  List<bool> isSelected = [];

  String videoUrl;

  String playerClickedCheckColor = "";
  FetchPlayersModel playerClicked;

  int prevIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
            create: (context) {
              return AdminHomeBloc(
                userModel: widget.userModel,
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                userRepository: widget.userRepository,
              )..add(AssignVideosEvent());
            },
          child: BlocListener<AdminHomeBloc, AdminHomeState>(
            listener: (context,state) {
              if(state is AssignVideosError) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if(state is AssignVideosToPlayerLoaded) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Player Assigned with the Video"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<AdminHomeBloc, AdminHomeState>(
              builder: (context,state) {
                if(state is AssignVideosLoading) {
                  return LoadingIndicator();
                } else if(state is AssignVideosLoaded) {
                  return WillPopScope(
                    onWillPop: () {
                     // Navigator.of(context).pop();
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
                                int clickedPlayerId = index;
                                return Container(
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    border: index % 2 ==0 ? Border.all(color: Color(0xFFbf2431)) : Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                    color: Color.fromRGBO(43, 43, 43, 1)
                                  ),
                                  child: ExpansionTile(
                                    title: Center(
                                      child: Text( state.fetchPlayers[index]
                                          .fields.name.toUpperCase(),
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontFamily:
                                              "MontserratRegular",
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  211, 172, 43, 1))),
                                    ),

                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(58, 58, 58, 1)
                                        ),
                                        child: Wrap(
                                          children : [
                                            Column(
                                              children: [
                                                ListView.builder(
                                                  scrollDirection: Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: state.videosList.length,
                                                  itemBuilder: (context,index) {
                                                    for (var i = 0; i < state.fetchPlayers.length; i++) {
                                                      isSelected.add(false);
                                                    }
                                                    return Container(
                                                      color: state.fetchPlayers[clickedPlayerId].fields.name.contains(playerClickedCheckColor) && isSelected[index] ? Color.fromRGBO(211, 172, 43, 1) : Color.fromRGBO(58, 58, 58, 1) ,
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            isSelected[index] = !isSelected[index];
                                                            if(prevIndex !=null && prevIndex != index)
                                                              isSelected[prevIndex] = false;

                                                            if(isSelected[index]) {
                                                              prevIndex = index;
                                                              playerClicked = state.fetchPlayers[clickedPlayerId];
                                                              videoUrl = state.videosList[index].videoLink;
                                                            } else {
                                                              isSelected[index] = false;
                                                              playerClicked = null;
                                                              videoUrl = null;
                                                            }
                                                          //  clickedPlayerId = null;
                                                            playerClickedCheckColor = state.fetchPlayers[clickedPlayerId].fields.name;
                                                          });
                                                        },
                                                        title: Center(child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(state.videosList[index].name.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MontserratRegular",color: Color(0xFFbf2431)),),
                                                            SizedBox(width: 8,),
                                                            state.fetchPlayers[clickedPlayerId].fields.name.contains(playerClickedCheckColor) && isSelected[index] ? Icon(Icons.done) : Container(),
                                                          ],
                                                        )),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              //Assign Button.
                                                ButtonTheme(
                                                  minWidth: MediaQuery.of(context).size.width *
                                                  0.80, //height
                                                  height:MediaQuery.of(context).size.height *
                                                  0.045 ,
                                                  disabledColor:
                                                  Color.fromARGB(191, 36, 49, 1),
                                                  shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                                  child: RaisedButton(
                                                    color: Color(0xFFbf2431),
                                                    child:Text("ASSIGN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                                        letterSpacing: 3),),
                                                    onPressed: () {
                                                      if(playerClicked !=null && videoUrl !=null)
                                                    BlocProvider.of<AdminHomeBloc>(context).add(AssignVideosToPlayerEvent(playerClicked,videoUrl));
                                                      else
                                                    BlocProvider.of<AdminHomeBloc>(context).add(AssignVideosToPlayerErrorEvent("Please Select a Video for Assignment"));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],

                                  ),
                                );



                                Container(
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
                            //  BlocProvider.of<AdminHomeBloc>(context)
                                // .add(AdminHomeInitEvent());
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
                }  else
                  return LoadingIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
