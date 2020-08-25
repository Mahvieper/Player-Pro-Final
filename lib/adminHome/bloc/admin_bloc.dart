import 'dart:convert';
import 'package:user_repository/IndividualPlayersModel.dart';
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
  List<IndividualLearningModel> plansList;
  FetchPlayersModel clickedPlayer;
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
          "videoUrl":event.videoUrl,
          "isComplete" : false,
          "videoId" : event.videoModel.id
        };

       /* Map dataForAllotment = {
          "assigName":event.videoModel.name,
          "playerName" : event.playerClicked.fields.name,
          "playerId" : event.playerClicked.fields.id,
          "assignByName" : userModel.name,
          "assignById" : userModel.id,
          "assignLink" : event.videoModel.videoLink,
          "assigId" : event.videoModel.id,
          "assignStatus" : false,
        };*/
        //encode Map to JSON
        var body = json.encode(data);
       // var bodyForAllotment = json.encode(dataForAllotment);
        print(playerClicked.toString());
        print(event.videoUrl);
        UserModel player = await userRepository.updateUser(token, playerClicked.fields.id.toString(), body);
       // AllotModel playerAllotedAssignment = await userRepository.postAllotmentToPlayer(token,playerClicked.fields.id.toString(),bodyForAllotment);
       // print(playerAllotedAssignment);
        yield AssignVideosToPlayerLoaded(player);
        yield AssignVideosLoaded(this.assignedPointsPlayer,this.fetchPlayersBloc);
      } catch(error) {
        yield AssignPointsToPlayerError(error: error.toString());
        yield AssignVideosLoaded(this.assignedPointsPlayer,this.fetchPlayersBloc);
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
       this.fetchPlayersBloc = fetchPlayers;
        yield IndLearningLoaded(userModel,fetchPlayers);
      } catch (error) {
        yield IndLearningError(error: error.toString());
      }
    }  else if(event is IndividualLearningPlanSavedList) {
      yield IndividualLearningPlanSavedListLoading();
      try {
        String token = await _getToken();
        List<IndividualLearningModel> indiPlanForPlayer = await userRepository.getIndiPlanForPlayer(token,event.clickedPlayer.fields.id.toString());
        this.plansList = indiPlanForPlayer;
        this.clickedPlayer = event.clickedPlayer;
        yield IndividualLearningPlanSavedListLoaded(userModel,indiPlanForPlayer,event.clickedPlayer);
      } catch (error) {
        yield IndLearningError(error: error.toString());
      }
    }

    else if(event is IndividualLearningPlanDetail) {
      yield IndLearningDetailLoading();
      try {
        String token = await _getToken();
       // List<IndividualLearningModel> indiPlanForPlayer = await userRepository.getIndiPlanForPlayer(token,event.clickedPlayer.fields.id.toString());
        yield IndLearningDetailLLoaded(userModel,event.clickedIndiDateModel,event.clickedPlayer);
      } catch (error) {
        yield IndLearningError(error: error.toString());
      }
    } else if(event is IndividualLearningPlanDetailSend) {

      yield IndLearningDetailSendLoading();
      try {
        String token = await _getToken();
        IndividualLearningModel modelForPlayer = event.modelForPlayer;
        Map data;
        if (modelForPlayer.pk == -1) {
          data = {
            "playerId": modelForPlayer.fields.playerId,
            "Name": modelForPlayer.fields.name,
            "Target": modelForPlayer.fields.target,
            "Technical": modelForPlayer.fields.technical,
            "Physical": modelForPlayer.fields.physical,
            "Psychology": modelForPlayer.fields.psychology,
            "Social": modelForPlayer.fields.social,
            "Tactical": modelForPlayer.fields.tactical,
            "Information": modelForPlayer.fields.information,
          };
        } else {
         data = {
          "playerId": modelForPlayer.fields.playerId,
          "Name": modelForPlayer.fields.name,
          "Target": modelForPlayer.fields.target,
          "Technical": modelForPlayer.fields.technical,
          "Physical": modelForPlayer.fields.physical,
          "Psychology": modelForPlayer.fields.psychology,
          "Social": modelForPlayer.fields.social,
          "Tactical": modelForPlayer.fields.tactical,
          "Information": modelForPlayer.fields.information,
          "date": modelForPlayer.fields.date,
          "id": modelForPlayer.fields.id
        };
      }
        //encode Map to JSON
        var body =  json.encode(data);
        // = json.encode(data);
        IndividualLearningModel indiPlanForPlayer;
        if(modelForPlayer.pk == -1)
          indiPlanForPlayer = await userRepository.postIndiPlanForPlayer(token,modelForPlayer.fields.playerId.toString(),body);
        else
          indiPlanForPlayer = await userRepository.putIndiPlanForPlayer(token,modelForPlayer.fields.playerId.toString(),body);
        yield IndLearningDetailLSendLoaded(userModel,indiPlanForPlayer);
        yield IndLearningLoaded(userModel,this.fetchPlayersBloc);
      } catch (error) {
        yield IndLearningDetailSendError(error: error.toString());
      }
    } else if(event is GetHighScoreEvent) {
      yield GetHighScoresLoading();

      try {
        String token = await _getToken();
        print("Token from Bloc ===>" + token);
        List<PlayerPoints> _playersList = await userRepository.getUsers(token,"Player");
        print("Players List"+ _playersList.toString());
        // List<UserModel> _playersList = new List<UserModel>();
        yield GetHighScoresLoaded(_playersList);
      } catch (error) {
        yield GetHighScoresError(error: error.toString());
      }

    } else if(event is SnackBarEvent) {
      yield SnackBarLoaded(error: event.message.toString());
      yield IndividualLearningPlanSavedListLoaded(this.userModel,this.plansList,this.clickedPlayer);
    }
  }
}

