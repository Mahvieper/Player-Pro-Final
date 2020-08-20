import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;


  _saveToken(String _token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = prefs.getString('token');
    if( token == null || token.isEmpty) {
      await prefs.setString('token', _token);
    }
  }

  _saveForgetClicked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool forgetClicked;
    forgetClicked = prefs.getBool('forgetClicked');
    if( forgetClicked == null || forgetClicked == false) {
      await prefs.setBool('forgetClicked', true);
    }
  }

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        _saveToken(token);
        authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    } else  if (event is ForgetPressed) {
      yield ForgetInProgress();

      try {
        String forgetResponse = await userRepository.forgetPasssword(event.username);
        yield ForgetLoaded(forgetResponse);
        yield LoginInitial();
        await _saveForgetClicked();
        print("ForgetClicked Saved");
      } catch (error) {
        yield ForgetFailure(error: error.toString());
      }
    }
  }
}