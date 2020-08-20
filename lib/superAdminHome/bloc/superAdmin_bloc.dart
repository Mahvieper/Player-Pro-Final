import 'package:player_pro_final/superAdminHome/bloc/superAdmin_event.dart';
import 'package:player_pro_final/superAdminHome/bloc/superAdmin_state.dart';
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:player_pro_final/adminHome/bloc/admin_event.dart';
import 'package:player_pro_final/adminHome/bloc/admin_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:player_pro_final/authentication/authentication_bloc.dart';
import 'package:user_repository/fetchPlayersModel.dart';

class SuperAdminHomeBloc extends Bloc<SuperAdminHomeEvent,SuperAdminHomeState> {
  final UserRepository userRepository;
  final UserModel userModel;
  final AuthenticationBloc authenticationBloc;
  List<UserModel> allUsersList;
  SuperAdminHomeBloc({
    @required this.userRepository,
    @required this.userModel,
    this.authenticationBloc
  })  : assert(userRepository != null),
        assert(userModel != null),
        super(SuperAdminHomeInitial());

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
  Stream<SuperAdminHomeState> mapEventToState(SuperAdminHomeEvent event) async* {
    if(event is SuperAdminHomeInitEvent) {
      yield SuperAdminHomeInitial();
    } else if(event is CreateOrUpdatePlayersEvent) {
      yield CreateUpdatePlayersLoading();

      try {
        String token = await _getToken();
         allUsersList = await userRepository.getAllUsers(token);
        yield CreateUpdatePlayersLoaded(allUsersList);
      }catch(error) {
        yield CreateUpdatePlayersError(error: error.toString());
      }
    } else if(event is UpdateUserEvent) {
      yield UpdateUserLoading();

      try {
        String token = await _getToken();
        UserModel playerUpdate = event.playerUpdate;
        yield UpdateUserLoaded(playerUpdate);
      }catch(error) {
        yield UpdateUserError(error: error.toString());
      }
    }  else if(event is UpdateUserInitiatedEvent) {
      yield UpdateUserInitiatedLoading();

      try {
        String token = await _getToken();
        Map data;
        if (event.playerUpdate.role.contains("Admin")) {
          data = {
            "email": event.playerUpdate.email,
            "name": event.playerUpdate.name,
            "role": event.playerUpdate.role,
            "designation": event.playerUpdate.designation,
            "level": event.playerUpdate.level,
            "experience": event.playerUpdate.experience,
            "adminDetails": event.playerUpdate.adminDetails,
          };
        }
        else {
           data = {
            "email": event.playerUpdate.email,
            "name": event.playerUpdate.name,
            "role": event.playerUpdate.role,
            "points": event.playerUpdate.points,
            "AdminName": event.playerUpdate.adminName,
             "admin_id" :  event.playerUpdate.adminId,
          };
      }
        //encode Map to JSON
        var body = json.encode(data);
        UserModel playerUpdate = await userRepository.updateUser(token, event.playerUpdate.id.toString(), body);
        yield UpdateUserInitiatedLoaded(playerUpdate);
        yield UpdateUserLoaded(playerUpdate);
      }catch(error) {
        yield UpdateUserInitiatedError(error: error.toString());
      }
    } else if(event is AddNewUserEvent) {
      yield AddNewUserLoading();

      try {
        yield AddNewUserLoaded();
      }catch(error) {
        yield AddNewUserError(error: error.toString());
      }
    } else if(event is AddNewUserPlayerEvent) {
      yield AddNewUserPlayerLoading();
      try {
        yield AddNewUserPlayerLoaded();
      }catch(error) {
        yield AddNewUserPlayerError(error: error.toString());
      }
    }  else if(event is AddNewUserPlayerCreateEvent) {
      yield AddNewUserPlayerCreateLoading();
      try {
        Map data;
        data = {
          "email": event.createPlayer.email,
          "name": event.createPlayer.name,
          "password" : event.createPlayer.password,
          "role": event.createPlayer.role,
          "points": event.createPlayer.points,
          "AdminName": event.createPlayer.adminName,
          "admin_id" : event.createPlayer.adminId,
          "superAdminName" : event.createPlayer.superAdminName,
          "super_admin_id" : event.createPlayer.superAdminId,
        };
        var body = json.encode(data);
        String token = await _getToken();
        UserModel createdUser = await userRepository.createUser(token,body);
        yield AddNewUserPlayerCreateLoaded(createdUser);
        yield CreateUpdatePlayersLoaded(allUsersList);
      }catch(error) {
        yield AddNewUserPlayerCreateError(error: error.toString());
      }
    }  else if(event is AddNewUserAdminEvent) {
      yield AddNewUserAdminLoading();
      try {
        yield AddNewUserAdminLoaded();
      }catch(error) {
        yield AddNewUserAdminError(error: error.toString());
      }
    }
    else if(event is AddNewUserAdminCreateEvent) {
      yield AddNewUserAdminCreateLoading();
      try {
        Map data;
        data = {
          "email": event.createAdmin.email,
          "name": event.createAdmin.name,
          "admin_id" : null,
          "password" : event.createAdmin.password,
          "role": event.createAdmin.role,
          "designation": event.createAdmin.designation,
          "level": event.createAdmin.level,
          "experience": event.createAdmin.experience,
          "adminDetails": event.createAdmin.adminDetails,
          "superAdminName" : event.createAdmin.superAdminName,
          "super_admin_id" : event.createAdmin.superAdminId,
        };
        var body = json.encode(data);
        String token = await _getToken();
        UserModel createdUser = await userRepository.createUser(token,body);
        yield AddNewUserAdminCreateLoaded(createdUser);
        yield CreateUpdatePlayersLoaded(allUsersList);
      }catch(error) {
        yield AddNewUserAdminCreateError(error: error.toString());
      }
    }
  }

}