import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
   UserModel userModel;

   getUser() {
     return userModel;
   }
  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = prefs.getString('token');
    if( token == null || token.isEmpty) {
      token = await prefs.getString('token');
    }
    return token;
  }

  _deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  _saveToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AuthenticationStarted) {
     //final bool hasToken = await userRepository.hasToken();
      String token = await _getToken();
      final bool hasToken = (token != null) ? true : false;
      if (hasToken) {
        try {
          userModel = await userRepository.getUser(token);
          yield AuthenticationSuccess(userModel: userModel);
        } catch(error) {
          yield AuthenticationFailure();
        }

      } else {
        yield AuthenticationFailure();
      }
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await _saveToken(event.token);
      try{
        userModel = await userRepository.getUser(event.token);
      } catch(error) {
        yield AuthenticationFailure();
      }

      yield AuthenticationSuccess(userModel: userModel);
    }

    if (event is AuthenticationLoggedOut) {
      await _deleteToken();
      yield AuthenticationInProgress();
      await userRepository.deleteToken();
      yield AuthenticationFailure();
    }
  }
}