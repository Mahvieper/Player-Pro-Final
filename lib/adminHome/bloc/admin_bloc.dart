import 'dart:convert';

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
  List<VideoModel> assignedPointsPlayer;

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
        if(event.pointsAssigned == null || event.pointsAssigned.isEmpty) {
          yield AssignPointsToPlayerError(error: "Please Enter some Points in the TextBox");
          yield AssignPointsLoaded(this.fetchPlayersBloc);
        } else {
          UserModel assignedPointsPlayer = await userRepository
              .assignPointsToUser(token, event.playerId, event.pointsAssigned);
          List<FetchPlayersModel> fetchPlayers = await userRepository
              .fetchPlayersUnderAdmin(token, userModel.id.toString());
          yield AssignPointsToPlayerLoaded(assignedPointsPlayer);
          yield AssignPointsLoaded(this.fetchPlayersBloc);
        }
      } catch(error) {
        yield AssignPointsToPlayerError(error: error.toString());
      }
    } else if(event is AssignVideosEvent) {
      yield AssignVideosLoading();
      String token = await _getToken();
      try {
        List<VideoModel> assignedPointsPlayer = await userRepository.getVideos(token);
        List<FetchPlayersModel> fetchPlayers = await userRepository.fetchPlayersUnderAdmin(token,userModel.id.toString());
       this.assignedPointsPlayer = assignedPointsPlayer;
       this.fetchPlayersBloc = fetchPlayers;
        yield AssignVideosLoaded(assignedPointsPlayer,fetchPlayers);
      } catch(error) {
        yield AssignPointsToPlayerError(error: error.toString());
      }
    }  else if(event is AssignVideosToPlayerEvent) {
      yield AssignVideosToPlayerLoading();
      String token = await _getToken();
      try {
        FetchPlayersModel playerClicked = event.playerClicked;
        Map data = {
          "videoUrl":event.videoUrl
        };
        //encode Map to JSON
        var body = json.encode(data);

        print(playerClicked.toString());
        print(event.videoUrl);
        UserModel player = await userRepository.updateUser(token, playerClicked.fields.id.toString(), body);

        yield AssignVideosToPlayerLoaded(player);
        yield AssignVideosLoaded(this.assignedPointsPlayer,this.fetchPlayersBloc);
      } catch(error) {
        yield AssignPointsToPlayerError(error: error.toString());
      }
    }  else if(event is AssignVideosToPlayerErrorEvent) {
      try {
        yield AssignVideosError(error: event.error);
        yield AssignVideosLoaded(this.assignedPointsPlayer,this.fetchPlayersBloc);
      } catch(error) {
        yield AssignVideosError(error: error.toString());
      }
    }  else if(event is IndividualLearningPlan) {
      yield IndLearningLoading();
      try {
        String token = await _getToken();
        List<FetchPlayersModel> fetchPlayers = await userRepository.fetchPlayersUnderAdmin(token,userModel.id.toString());
        yield IndLearningLoaded(userModel,fetchPlayers);
      } catch (error) {
        yield IndLearningError(error: error.toString());
      }
    } else if(event is IndividualLearningPlanDetail) {
      yield IndLearningDetailLoading();
      try {
        String token = await _getToken();
        IndividualLearningModel indiPlanForPlayer = await userRepository.getIndiPlanForPlayer(token,event.clickedPlayer.fields.id.toString());
        yield IndLearningDetailLLoaded(userModel,indiPlanForPlayer);
      } catch (error) {
        yield IndLearningError(error: error.toString());
      }
    }
  }
}

