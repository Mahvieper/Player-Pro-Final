import 'package:flutter/material.dart';
import 'package:player_pro_final/adminHome/bloc/admin_event.dart';
import 'package:player_pro_final/adminHome/bloc/admin_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:player_pro_final/authentication/authentication_bloc.dart';
import 'package:user_repository/fetchPlayersModel.dart';

class AdminHomeBloc extends Bloc<AdminHomeEvent,AdminHomeState> {
  final UserRepository userRepository;
  final UserModel userModel;
  final AuthenticationBloc authenticationBloc;
  List<FetchPlayersModel> fetchPlayersBloc;

  AdminHomeBloc({
    @required this.userRepository,
    @required this.userModel,
    this.authenticationBloc
  })  : assert(userRepository != null),
        assert(userModel != null),
        super(AdminHomeInitial());

  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = prefs.getString('token');
    if( token == null || token.isEmpty) {
      token = await prefs.getString('token');
    }
    return token;
  }

  @override
  Stream<AdminHomeState> mapEventToState(AdminHomeEvent event) async* {
    if(event is AdminHomeInitEvent) {
      yield AdminHomeInitial();
    } else if(event is FetchPlayers) {
      yield FetchPlayersLoading();
      String token = await _getToken();
      try {
        List<FetchPlayersModel> fetchPlayers = await userRepository.fetchPlayersUnderAdmin(token,userModel.id.toString());
        yield FetchPlayersLoaded(fetchPlayers);
      } catch(error) {
        yield AdminHomeError(error: error.toString());
      }
    } else if(event is AssignPointsEvent) {
      yield AssignPointsLoading();
      String token = await _getToken();
      try {
        List<FetchPlayersModel> fetchPlayers = await userRepository.fetchPlayersUnderAdmin(token,userModel.id.toString());
        // UserModel playPointsAssigned = await userRepository.assignPointsToUser(token,userModel.id.toString());
        this.fetchPlayersBloc = fetchPlayers;
        yield AssignPointsLoaded(fetchPlayers);
      } catch(error) {
        yield AssignPointsError(error: error.toString());
      }
    } else if(event is AssignPointsToPlayerEvent) {
      yield AssignPointsToPlayerLoading();
      String token = await _getToken();
      try {
        UserModel assignedPointsPlayer = await userRepository.assignPointsToUser(token,event.playerId,event.pointsAssigned);
        List<FetchPlayersModel> fetchPlayers = await userRepository.fetchPlayersUnderAdmin(token,userModel.id.toString());

        // UserModel playPointsAssigned = await userRepository.assignPointsToUser(token,userModel.id.toString());
          yield AssignPointsToPlayerLoaded(assignedPointsPlayer);
          yield AssignPointsLoaded(this.fetchPlayersBloc);
      } catch(error) {
        yield AssignPointsToPlayerError(error: error.toString());
      }
    }
  }
}

