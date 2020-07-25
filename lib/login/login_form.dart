import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _email = "";
  String _pass = "";
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    final emailField = TextFormField(
      onSaved: (val) => _email = val,
      textAlign: TextAlign.center,
      obscureText: false,
      validator: (val) => !val.contains("@") ? "Email Id is not Valid" : null,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(58, 58, 58, 1),
        focusColor: Colors.white,
        hintStyle: TextStyle(color: Colors.grey),

        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "NAME@EMAIL.COM",
      ),
    );
    final passwordField = TextFormField(
      onSaved: (val) => _pass = val,
      textAlign: TextAlign.center,
      validator: (val) =>
          val.length < 6 ? "Password cannot be less than 6" : null,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(58, 58, 58, 1),
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "**********",
      ),
    );

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect Combination of Email and Password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInProgress)
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
          else
            return SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                key: scaffoldKey,
                body: Stack(
                  children: [
                    //Background Image
                    Align(
                      alignment: Alignment.topCenter,
                      child: new Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/loginBack.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.17,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 40),
                                //Email - Field
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.2,
                                      MediaQuery.of(context).size.width * 0.1,
                                      MediaQuery.of(context).size.width * 0.2,
                                      MediaQuery.of(context).size.width * 0.01),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color.fromRGBO(211, 172, 43, 1)),
                                      //Color.fromRGBO(211, 172, 43, 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "E-MAIL",
                                          style: TextStyle(
                                              letterSpacing: 2,
                                              color: Color(0xFF3a3a3c),
                                              fontFamily: "MontserratRegular",
                                              //Color.fromRGBO(96, 88, 55, 1),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.002,
                                              0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.002,
                                              2),
                                          child: emailField)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //Password - Field
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.2,
                                      MediaQuery.of(context).size.width * 0.01,
                                      MediaQuery.of(context).size.width * 0.2,
                                      MediaQuery.of(context).size.width * 0.01),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color.fromRGBO(211, 172, 43, 1)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "PASSWORD",
                                          style: TextStyle(
                                            letterSpacing: 2,
                                              color: Color(0xFF3a3a3f),
                                              fontFamily: "MontserratRegular",
                                              //Color.fromRGBO(96, 88, 55, 1),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                              ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle
                                        ),
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.002,
                                              0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.002,
                                              2),
                                          child: passwordField)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //Login Button
                                ButtonTheme(
                                  minWidth: MediaQuery.of(context).size.width *
                                      0.60, //height
                                  height:MediaQuery.of(context).size.height *
                                      0.045 ,// : 100.// 0,
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        print('Form is valid');
                                        //_showSnackbar();
                                        print("EMaillfrom Text ==> " + _email);
                                        print("Password===>" + _pass);
                                        // bloc.add(Login(_email, _pass));
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginButtonPressed(
                                            username: _email,
                                            password: _pass,
                                          ),
                                        );
                                      } else {
                                        print(formKey.currentState.validate());
                                        print(formKey.currentState);
                                        print('Form is Not valid');
                                      }
                                    },
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "MontserratRegular",
                                      letterSpacing: 3),
                                    ),
                                    color: Color(0xFFbf2431),
                                    disabledColor:
                                        Color.fromARGB(191, 36, 49, 1),
                                    shape: Border.all(color: Color.fromRGBO(211, 172, 43, 1)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //Forgot Password Button
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "FORGOT PASSWORD?",
                                      style: TextStyle( letterSpacing: 2,
                                        color: Colors.white,fontFamily: "MontserratRegular",fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}
