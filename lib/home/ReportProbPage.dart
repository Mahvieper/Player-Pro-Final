import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/home/bloc/home_event.dart';
import 'package:user_repository/user_repository.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class ReportProbPage extends StatelessWidget {
  final UserRepository userRepository;
  ReportProbPage(this.userModel, this.userRepository);
  final UserModel userModel;
  String _name, _title, _problem;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFF3a3a3f)),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: title.contains("PROBLEM") ? 5 : 1,
                  maxLines: 8,
                  onSaved: (val) {
                    if(title.contains("NAME")) {
                      _name = val;
                    } else if (title.contains("TITLE")) {
                      _title = val;
                    } else if (title.contains("PROBLEM")) {
                      _problem = val;
                    }
                  },
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
        )..add(ReportProbEvent());
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          body: BlocListener<HomeBloc, HomeState>(
            listener: (context,state) {
              if(state is ReportProbSuccess) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.response),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is ReportProbLoading)
                  return LoadingIndicator();
                else if (state is ReportProbLoaded) {
                  return WillPopScope(
                    onWillPop: () {
                      Navigator.pop(context);
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
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15),
                          height: MediaQuery.of(context).size.height * 0.8,
                          padding: EdgeInsets.all(30),
                          child: Form(
                            key: formKey,
                            child: ListView(
                              children: [
                                buildInputs("NAME"),
                                buildInputs("TITLE"),
                                buildInputs("PROBLEM"),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  child: SizedBox(
                                    width: 250,
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();
                                          print('Form is valid');
                                          /* BlocProvider.of<LoginBloc>(context).add(
                                            LoginButtonPressed(
                                              username: _email,
                                              password: _pass,
                                            ),
                                          );*/
                                          BlocProvider.of<HomeBloc>(context).add(ReportProbRequested(userModel,_name,_title,_problem));
                                        } else {
                                          print(formKey.currentState.validate());
                                          print(formKey.currentState);
                                          print('Form is Not valid');
                                        }
                                      },
                                      child: Text(
                                        "SEND",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "MontserratRegular",
                                            letterSpacing: 3),
                                      ),
                                      color: Color(0xFFbf2431),
                                      disabledColor:
                                          Color.fromARGB(191, 36, 49, 1),
                                      shape: Border.all(
                                          color: Color.fromRGBO(211, 172, 43, 1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else
                  return LoadingIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
