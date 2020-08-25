import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/superAdminHome/bloc/superAdmin_event.dart';
import 'package:user_repository/user_repository.dart';

import 'bloc/superAdmin_bloc.dart';
import 'bloc/superAdmin_state.dart';

class UploadVideosPage extends StatefulWidget {
  final UserRepository userRepository;
  final UserModel userModel;
  UploadVideosPage(this.userModel,this.userRepository);
  @override
  _UploadVideosPageState createState() => _UploadVideosPageState();
}

class _UploadVideosPageState extends State<UploadVideosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) {
        return SuperAdminHomeBloc(
          userModel: widget.userModel,
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: widget.userRepository,
        )..add(UploadVideosPageEvent());
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          key: _scaffoldKey,
          body: BlocListener<SuperAdminHomeBloc, SuperAdminHomeState>(
            listener: (context,state) {

            },
            child: BlocBuilder<SuperAdminHomeBloc, SuperAdminHomeState>(
              builder: (context,state) {
                if(state is UploadVideosPageLoading)
                  return LoadingIndicator();
                else if(state is UploadVideosPageLoaded) {
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

                      /*

                      Container(
                        //  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, MediaQuery.of(context).size.width * 0.1, 0),
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.1,
                              MediaQuery.of(context).size.height * 0.18,
                              MediaQuery.of(context).size.width * 0.1,
                              0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                height: MediaQuery.of(context).size.height * 0.55,
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

                      */
                    ],
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
