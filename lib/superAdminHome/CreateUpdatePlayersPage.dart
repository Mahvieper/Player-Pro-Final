import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/superAdminHome/bloc/superAdmin_event.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/superAdmin_bloc.dart';
import 'bloc/superAdmin_state.dart';
class CreateUpdatePlayersPage extends StatefulWidget {
  final UserRepository userRepository;
  final UserModel userModel;
  CreateUpdatePlayersPage(this.userModel,this.userRepository);
  @override
  _CreateUpdatePlayersPageState createState() => _CreateUpdatePlayersPageState();
}

class _CreateUpdatePlayersPageState extends State<CreateUpdatePlayersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery;
  bool _isSearching = false;
  String _value = 'Player';
  String searchQuery = "Search query";
  List<UserModel> searchedList = new List<UserModel>();
  List<UserModel> fetchedList = new List<UserModel>();
  List<UserModel> adminList = new List<UserModel>();
  List<String> adminNameList = new List<String>();
  UserModel _selectedAdmin;
  UserModel createPlayer = new UserModel();
  UserModel createAdmin = new UserModel();
  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }




  @override
  Widget build(BuildContext context) {

    Widget buildInd(String title, String desc,UserModel user) {
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
                    if(title.contains("name")) {
                     user.name = val;
                    }
                    else if(title.contains("email")) {
                     user.email = val;
                    }

                    else if(title.contains("points")) {
                      user.points = val;
                    }
                    else if(title.contains("designation")) {
                     user.designation = val;
                    }

                    else if(title.contains("level")) {
                     user.level = val;
                    }

                    else if(title.contains("experience")) {
                      user.experience = val;
                    }

                    else if(title.contains("adminDetails")) {
                      user.adminDetails = val;
                    }

                    else if(title.contains("role")) {
                      user.role = val;
                    }
                  },
                  onSaved: (val) {
                    if(title.contains("name")) {
                      user.name = val;
                    }
                    else if(title.contains("email")) {
                      user.email = val;
                    }

                    else if(title.contains("points")) {
                      user.points = val;
                    }
                    else if(title.contains("designation")) {
                      user.designation = val;
                    }

                    else if(title.contains("level")) {
                      user.level = val;
                    }

                    else if(title.contains("experience")) {
                      user.experience = val;
                    }

                    else if(title.contains("adminDetails")) {
                      user.adminDetails = val;
                    }

                    else if(title.contains("role")) {
                      user.role = val;
                    }

                  },
                  initialValue: desc,
                  enabled: title.contains('role') ? false : true,
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

    Widget buildCreateUser(String title, String desc,UserModel user,String userRole) {
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
                    if(title.contains("name")) {
                      user.name = val;
                    }
                    else if(title.contains("email")) {
                      user.email = val;
                    }

                    else if(title.contains("points")) {
                      user.points = val;
                    }
                    else if(title.contains("designation")) {
                      user.designation = val;
                    }

                    else if(title.contains("level")) {
                      user.level = val;
                    }

                    else if(title.contains("experience")) {
                      user.experience = val;
                    }

                    else if(title.contains("adminDetails")) {
                      user.adminDetails = val;
                    }

                    else if(title.contains("role")) {
                      user.role = val;
                    }
                    else if(title.contains("password")) {
                      user.password = val;
                    }
                  },
                  onSaved: (val) {
                    if(title.contains("name")) {
                      user.name = val;
                    }
                    else if(title.contains("email")) {
                      user.email = val;
                    }

                    else if(title.contains("points")) {
                      user.points = val;
                    }
                    else if(title.contains("designation")) {
                      user.designation = val;
                    }

                    else if(title.contains("level")) {
                      user.level = val;
                    }

                    else if(title.contains("experience")) {
                      user.experience = val;
                    }

                    else if(title.contains("adminDetails")) {
                      user.adminDetails = val;
                    }

                    else if(title.contains("role")) {
                      user.role = val;
                    }

                    else if(title.contains("password")) {
                      user.password = val;
                    }
                  },
                  initialValue: title.contains('role') ? userRole : desc,
                  enabled: title.contains('role') ? false : true,
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

    Widget buildDropDown(String title, String desc,UserModel user) {
      if(user.adminName == null || user.adminName.isEmpty) {
        user.adminName = adminNameList[0];
        for (UserModel user in adminList) {
          if (user.name.contains(user.adminName)) {
            _selectedAdmin = user;
          }
        }
      }
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
              

              title.contains('AdminName') ? Container(
                  decoration: BoxDecoration(color: Color(0xFF3a3a3f)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(color: Color(0xFF3a3a3f)),
                          child: DropdownButton(
                            dropdownColor: Color(0xFF3a3a3f),
                            value:  _value,
                            items: adminNameList.map((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value,style: TextStyle(color: Colors.white),),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                                user.adminName = value;
                               for(UserModel user in adminList) {
                                 if(user.name.contains(_value)) {
                                   _selectedAdmin = user;
                                 }
                               }
                              });
                            },
                          )
                      )
                    ],),
                ) : Container(),




            ],
          ));
    }

    void updateSearchQuery(String newQuery) {

      setState(() {
        searchQuery = newQuery;
        searchedList.clear();
        for(UserModel user in fetchedList) {
          if(user.name.toLowerCase().startsWith(searchQuery.toLowerCase()) && searchQuery.isNotEmpty)
          searchedList.add(user);
        }
        if(searchQuery.isEmpty)
         {
           for(UserModel user in fetchedList) {
               searchedList.add(user);
              // adminNameList.add(user.name);
           }
         }

      });
      print("search query " + newQuery);
    }



    Widget _buildSearchField() {
      return new TextField(
        controller: _searchQuery,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.white30),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
        onChanged: updateSearchQuery,
      );
    }



    return BlocProvider(
      create: (context) {
        return SuperAdminHomeBloc(
          userModel: widget.userModel,
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: widget.userRepository,
        )..add(CreateOrUpdatePlayersEvent());
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: BlocListener<SuperAdminHomeBloc, SuperAdminHomeState>(
              listener: (context, state) {
                if (state is SuperAdminHomeError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error Loading Home'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if(state is CreateUpdatePlayersLoaded) {
                  //  fetchedList = state.fetchUsers;
                  adminList =null;
                  adminList = new List<UserModel>();
                  adminNameList = null;
                  adminNameList = new List<String>();
                  for(UserModel user in state.fetchUsers) {
                    fetchedList.add(user);
                      if(user.role.startsWith("Admin")) {
                        adminList.add(user);
                        adminNameList.add(user.name);
                      }
                  }
                  _value = adminNameList[0];
                } else if(state is UpdateUserInitiatedLoaded) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('User Updated'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }  else if(state is UpdateUserInitiatedError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error Updating User'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if(state is AddNewUserPlayerCreateLoaded) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.createdPlayer.name + ' ' + 'Player Created Successfully'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if(state is AddNewUserAdminCreateLoaded) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.createdAdmin.name + ' ' + 'Admin Created Successfully'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            child: BlocBuilder<SuperAdminHomeBloc, SuperAdminHomeState>(
              builder: (context, state) {
                if (state is CreateUpdatePlayersLoading)
                  return LoadingIndicator();
                else if (state is CreateUpdatePlayersLoaded) {
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
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () {
                                BlocProvider.of<SuperAdminHomeBloc>(context).add(AddNewUserEvent());
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width : 200,
                                          child: _buildSearchField()),
                                      new IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () {
                                         // BlocProvider.of<SuperAdminHomeBloc>(context).add(AddNewUserEvent());
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),


                              Container(
                                height: MediaQuery.of(context).size.height * 0.6,
                                /* margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.1,
                                    MediaQuery.of(context).size.height * 0.28,
                                    MediaQuery.of(context).size.width * 0.1,
                                    0),*/
                                child: ListView.builder(
                                    itemCount: searchedList.length > 0 ? searchedList.length : state.fetchUsers.length ,
                                    itemBuilder: (context, index) {
                                      if(searchQuery.isNotEmpty) {

                                      }
                                      return InkWell(
                                        onTap: () {
                                          searchedList.length > 0 ? BlocProvider.of<SuperAdminHomeBloc>(context).add(UpdateUserEvent(searchedList[index])) :
                                          BlocProvider.of<SuperAdminHomeBloc>(context).add(UpdateUserEvent(state.fetchUsers[index])) ;
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
                                                    searchedList.length > 0 ?    searchedList[index].name
                                                      .toUpperCase() : state.fetchUsers[index].name.toUpperCase(),
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
                                                  searchedList.length > 0 ?  searchedList[index].name
                                                      .toUpperCase() : state.fetchUsers[index].name.toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      "MontserratRegular",
                                                      fontSize: 18,
                                                      color:
                                                      Color(0xFFbf2431)),
                                                ),
                                              ),
                                            )),
                                      );
                                    }),
                              ),
                            ],
                          )),


                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back,color: Colors.white,),
                            onPressed: () {
                              Navigator.pop(context);
                              //BlocProvider.of<SuperAdminHomeBloc>(context).add(SuperAdminHomeInitEvent());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }  else if (state is UpdateUserLoading) {
                  return LoadingIndicator();
                }  else if(state is UpdateUserLoaded) {
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

                     state.playerUpdate.role.contains("Admin") ? Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.18),
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView(
                          children: [
                            buildInd("email", state.playerUpdate.email,state.playerUpdate),
                            buildInd("name", state.playerUpdate.name,state.playerUpdate),
                            buildInd("role", state.playerUpdate.role,state.playerUpdate),
                            buildInd("designation", state.playerUpdate.designation,state.playerUpdate),
                            buildInd("level", state.playerUpdate.level,state.playerUpdate),
                            buildInd("experience", state.playerUpdate.experience,state.playerUpdate),
                            buildInd("adminDetails", state.playerUpdate.adminDetails,state.playerUpdate),
                          ],
                        ),
                      ) :  Container(
                       margin: EdgeInsets.only(
                           top: MediaQuery.of(context).size.height * 0.18),
                       height: MediaQuery.of(context).size.height * 0.6,
                       child: ListView(
                         children: [
                           buildInd("email", state.playerUpdate.email,state.playerUpdate),
                           buildInd("name", state.playerUpdate.name,state.playerUpdate),
                           buildInd("role", state.playerUpdate.role,state.playerUpdate),
                           buildInd("points", state.playerUpdate.points,state.playerUpdate),
                           buildDropDown('AdminName', state.playerUpdate.role, state.playerUpdate)
                         ],
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
                                child: Text("UPDATE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                    letterSpacing: 3),
                                ),
                                color: Color(0xFFbf2431),
                                disabledColor:
                                Color.fromARGB(191, 36, 49, 1),
                                shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                onPressed: () {
                                  if(_selectedAdmin !=null &&  state.playerUpdate.role.contains("Player")) {
                                    state.playerUpdate.adminId = _selectedAdmin.id;
                                  }
                                  BlocProvider.of<SuperAdminHomeBloc>(context).add(UpdateUserInitiatedEvent(state.playerUpdate));
                                }),
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
                              BlocProvider.of<SuperAdminHomeBloc>(context).add(CreateOrUpdatePlayersEvent());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else if(state is UpdateUserInitiatedLoading) {
                  return LoadingIndicator();
                }  else if(state is AddNewUserLoading) {
                  return LoadingIndicator();
                }  else if(state is AddNewUserLoaded) {
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
                                     child: Text("Create Player",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                         letterSpacing: 3),
                                     ),
                                     color: Color(0xFFbf2431),
                                     disabledColor:
                                     Color.fromARGB(191, 36, 49, 1),
                                     shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                     onPressed: () {
                                       BlocProvider.of<SuperAdminHomeBloc>(context).add(AddNewUserPlayerEvent());
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
                                     child: Text("Create Admin",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                         letterSpacing: 3),
                                     ),
                                     color: Color(0xFFbf2431),
                                     disabledColor:
                                     Color.fromARGB(191, 36, 49, 1),
                                     shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                     onPressed: () {
                                       BlocProvider.of<SuperAdminHomeBloc>(context).add(AddNewUserAdminEvent());
                                     }),
                               ),
                             ),
                           ],
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
                              BlocProvider.of<SuperAdminHomeBloc>(context).add(CreateOrUpdatePlayersEvent());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }  else if(state is AddNewUserPlayerLoading) {
                  return LoadingIndicator();
                }  else if(state is AddNewUserPlayerLoaded) {
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

                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.18),
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView(
                          children: [
                            buildCreateUser("name", "",createPlayer,""),
                            buildCreateUser("email","",createPlayer,""),
                            buildCreateUser("password","",createPlayer,""),
                            buildCreateUser("role","",createPlayer,"Player"),
                            buildCreateUser("points", "" ,createPlayer,""),
                            buildDropDown('AdminName', "" , createPlayer),
                          ],
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
                                child: Text("CREATE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                    letterSpacing: 3),
                                ),
                                color: Color(0xFFbf2431),
                                disabledColor:
                                Color.fromARGB(191, 36, 49, 1),
                                shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                onPressed: () {
                                  createPlayer.role = 'Player';
                                  createPlayer.adminId = _selectedAdmin.id;
                                  createPlayer.superAdminName = widget.userModel.name;
                                  createPlayer.superAdminId = widget.userModel.id;
                                 BlocProvider.of<SuperAdminHomeBloc>(context).add(AddNewUserPlayerCreateEvent(createPlayer));
                                }),
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
                              BlocProvider.of<SuperAdminHomeBloc>(context).add(CreateOrUpdatePlayersEvent());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }   else if(state is AddNewUserPlayerCreateLoading) {
                  return LoadingIndicator();
                }  else if(state is AddNewUserAdminLoading) {
                  return LoadingIndicator();
                }  else if(state is AddNewUserAdminLoaded) {
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

                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.18),
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView(
                          children: [
                            buildCreateUser("name", "",createAdmin,""),
                            buildCreateUser("email","",createAdmin,""),
                            buildCreateUser("password","",createAdmin,""),
                            buildCreateUser("role","",createAdmin,"Admin"),
                            buildCreateUser("designation", "",createAdmin,""),
                            buildCreateUser("level","",createAdmin,""),
                            buildCreateUser("experience","",createAdmin,""),
                            buildCreateUser('adminDetails', "" , createAdmin,""),
                          ],
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
                                child: Text("CREATE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                    letterSpacing: 3),
                                ),
                                color: Color(0xFFbf2431),
                                disabledColor:
                                Color.fromARGB(191, 36, 49, 1),
                                shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                onPressed: () {
                                  createAdmin.role = 'Admin';
                                  createAdmin.superAdminName = widget.userModel.name;
                                  createAdmin.superAdminId = widget.userModel.id;
                                  BlocProvider.of<SuperAdminHomeBloc>(context).add(AddNewUserAdminCreateEvent(createAdmin));
                                }),
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
                              BlocProvider.of<SuperAdminHomeBloc>(context).add(CreateOrUpdatePlayersEvent());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else if(state is AddNewUserAdminCreateLoading) {
                  return LoadingIndicator();
                }  else
                  return LoadingIndicator();
              }
            )
          ),
        ),
      ),
    );
  }
}
