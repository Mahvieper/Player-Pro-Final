import 'package:player_pro_final/superAdminHome/bloc/superAdmin_event.dart';
import 'package:player_pro_final/superAdminHome/bloc/superAdmin_state.dart';
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:player_pro_final/authentication/authentication_bloc.dart';
import 'package:user_repository/fetchPlayersModel.dart';

class SuperAdminHomeBloc
    extends Bloc<SuperAdminHomeEvent, SuperAdminHomeState> {
  final UserRepository userRepository;
  final UserModel userModel;
  final AuthenticationBloc authenticationBloc;
  List<UserModel> allUsersList;
  SuperAdminHomeBloc(
      {@required this.userRepository,
      @required this.userModel,
      this.authenticationBloc})
      : assert(userRepository != null),
        assert(userModel != null),
        super(SuperAdminHomeInitial());

  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      token = await prefs.getString('token');
    }
    return token;
  }

  @override
  Stream<SuperAdminHomeState> mapEventToState(
      SuperAdminHomeEvent event) async* {
    if (event is SuperAdminHomeInitEvent) {
      yield SuperAdminHomeInitial();
    } else if (event is CreateOrUpdatePlayersEvent) {
      yield CreateUpdatePlayersLoading();

      try {
        String token = await _getToken();
        allUsersList = await userRepository.getAllUsers(token);
        yield CreateUpdatePlayersLoaded(allUsersList);
      } catch (error) {
        yield CreateUpdatePlayersError(error: error.toString());
      }
    } else if (event is UpdateUserEvent) {
      yield UpdateUserLoading();

      try {
        String token = await _getToken();
        UserModel playerUpdate = event.playerUpdate;
        yield UpdateUserLoaded(playerUpdate);
      } catch (error) {
        yield UpdateUserError(error: error.toString());
      }
    } else if (event is UpdateUserInitiatedEvent) {
      yield UpdateUserInitiatedLoading();

      try {
        String token = await _getToken();
        Map data;
        if (event.playerUpdate.role.contains("Admin")) {
          if(event.playerUpdate.email ==null || event.playerUpdate.name ==null || event.playerUpdate.role == null
          || event.playerUpdate.designation == null || event.playerUpdate.level == null ||event.playerUpdate.experience == null
          || event.playerUpdate.adminDetails == null) {
            throw Exception();
          } else {
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
        } else {

          if(event.playerUpdate.email ==null || event.playerUpdate.name ==null || event.playerUpdate.role == null
              || event.playerUpdate.adminName == null || event.playerUpdate.adminId == null) {
            throw Exception();

          } else {
            data = {
              "email": event.playerUpdate.email,
              "name": event.playerUpdate.name,
              "role": event.playerUpdate.role,
              //"points": event.playerUpdate.points,
              "AdminName": event.playerUpdate.adminName,
              "admin_id": event.playerUpdate.adminId,
            };
          }
        }
        //encode Map to JSON
        var body = json.encode(data);
        UserModel playerUpdate = await userRepository.updateUser(
            token, event.playerUpdate.id.toString(), body);
        yield UpdateUserInitiatedLoaded(playerUpdate);
        yield UpdateUserLoaded(playerUpdate);
      } catch (error) {
        yield UpdateUserInitiatedError(error: error.toString());
      }
    } else if (event is AddNewUserEvent) {
      yield AddNewUserLoading();

      try {
        yield AddNewUserLoaded();
      } catch (error) {
        yield AddNewUserError(error: error.toString());
      }
    } else if (event is AddNewUserPlayerEvent) {
      yield AddNewUserPlayerLoading();
      try {
        yield AddNewUserPlayerLoaded();
      } catch (error) {
        yield AddNewUserPlayerError(error: error.toString());
      }
    } else if (event is AddNewUserPlayerCreateEvent) {
      yield AddNewUserPlayerCreateLoading();
      try {
        Map data;
        if(event.createPlayer.email ==null || event.createPlayer.name ==null || event.createPlayer.role == null
            || event.createPlayer.adminName == null || event.createPlayer.adminId == null || event.createPlayer.password == null
        ||event.createPlayer.superAdminName == null || event.createPlayer.superAdminId == null) {
          throw Exception();
        } else {
          data = {
            "email": event.createPlayer.email,
            "name": event.createPlayer.name,
            "password": event.createPlayer.password,
            "role": event.createPlayer.role,
            // "points": event.createPlayer.points,
            "AdminName": event.createPlayer.adminName,
            "admin_id": event.createPlayer.adminId,
            "superAdminName": event.createPlayer.superAdminName,
            "super_admin_id": event.createPlayer.superAdminId,
          };
        }
        var body = json.encode(data);
        String token = await _getToken();
        UserModel createdUser = await userRepository.createUser(token, body);
        yield AddNewUserPlayerCreateLoaded(createdUser);
        yield CreateUpdatePlayersLoaded(allUsersList);
      } catch (error) {
        yield AddNewUserPlayerCreateError(error: error.toString());
        yield AddNewUserPlayerLoaded();
      }
    } else if (event is AddNewUserAdminEvent) {
      yield AddNewUserAdminLoading();
      try {
        yield AddNewUserAdminLoaded();
      } catch (error) {
        yield AddNewUserAdminError(error: error.toString());
      }
    } else if (event is AddNewUserAdminCreateEvent) {
      yield AddNewUserAdminCreateLoading();
      try {
        Map data;
        if(event.createAdmin.email ==null || event.createAdmin.name ==null || event.createAdmin.role == null
            || event.createAdmin.designation == null || event.createAdmin.level == null ||event.createAdmin.experience == null
            || event.createAdmin.adminDetails == null || event.createAdmin.password == null || event.createAdmin.superAdminName == null
            || event.createAdmin.superAdminId == null) {
          throw Exception();
        } else {
          data = {
            "email": event.createAdmin.email,
            "name": event.createAdmin.name,
            "admin_id": null,
            "password": event.createAdmin.password,
            "role": event.createAdmin.role,
            "designation": event.createAdmin.designation,
            "level": event.createAdmin.level,
            "experience": event.createAdmin.experience,
            "adminDetails": event.createAdmin.adminDetails,
            "superAdminName": event.createAdmin.superAdminName,
            "super_admin_id": event.createAdmin.superAdminId,
          };
        }
        var body = json.encode(data);
        String token = await _getToken();
        UserModel createdUser = await userRepository.createUser(token, body);
        yield AddNewUserAdminCreateLoaded(createdUser);
        yield CreateUpdatePlayersLoaded(allUsersList);
      } catch (error) {
        yield AddNewUserAdminCreateError(error: error.toString());
        yield AddNewUserAdminLoaded();
      }
    } else if(event is UploadVideosPageEvent) {
      yield UploadVideosPageLoading();

      try {
        yield UploadVideosPageLoaded(userModel);
      } catch(error) {
        yield UploadVideosPageError(error: error.toString());
      }
    } else if(event is OpenVideosListEvent) {
      yield OpenVideosListPageLoading();

      try {
        String token = await _getToken();
        List<VideoModel> videosList = await userRepository.getVideos(token);
        yield OpenVideosListPageLoaded(userModel,videosList);
      } catch(error) {
        yield OpenVideosListPageError(error: error.toString());
      }
    } else if(event is OpenGoodiesListPageEvent) {
      yield OpenGoodiesListPageLoading();

      try {
        String token = await _getToken();
        List<ShoppingItemModel> shoppingItemsList = await userRepository.getShoppingItems(token);
        yield OpenGoodiesListPageLoaded(userModel,shoppingItemsList);
      } catch(error) {
        yield OpenGoodiesListPageError(error: error.toString());
      }
    }  else if(event is GoodiesRequestEvent) {
      yield GoodiesRequestLoading();

      try {
        yield GoodiesRequestLoaded();
      } catch(error) {
        yield GoodiesRequestError(error: error.toString());
      }
    } else if(event is PendingGoodiesRequestsListEvent) {
      yield PendingGoodiesRequestsListLoading();

      try {
        String token = await _getToken();
        List<PurchasedModel> shoppingItemsList = await userRepository.getGoodiesRequests(token);
        List<PurchasedModel> shoppingItemsListNew = new List<PurchasedModel>();
        for(PurchasedModel item in shoppingItemsList) {
          if((!item.status.contains("Accepted") &&  !item.status.contains("Rejected"))) {
            shoppingItemsListNew.add(item);
          }
        }
        yield PendingGoodiesRequestsListLoaded(userModel,shoppingItemsListNew);
      } catch(error) {
        yield PendingGoodiesRequestsListError(error: error.toString());
      }
    }  else if(event is GoodieAcceptedEvent) {
      yield GoodieAcceptedLoading();

      try {
        String token = await _getToken();
        Map data;
        if(event.isAccepted) {
          data = {
            "userName": event.goodieRequestModel.userName,
            "status": "Accepted",
            "userId" : event.goodieRequestModel.userId.toString(),
            "points" : event.goodieRequestModel.points,
            "goodiesName" : event.goodieRequestModel.goodiesName,
          };
        }
        else {
          data = {
            "userName": event.goodieRequestModel.userName,
            "status": "Rejected",
            "userId" : event.goodieRequestModel.userId.toString(),
            "points" : event.goodieRequestModel.points,
            "goodiesName" : event.goodieRequestModel.goodiesName,
          };
        }
        var body = json.encode(data);
        PurchasedModel shoppingItem = await userRepository.updateGoodiesRequest(token,event.goodieRequestModel.id.toString(),body);
        yield GoodieAcceptedLoaded(userModel,shoppingItem);
        List<PurchasedModel> shoppingItemsList = await userRepository.getGoodiesRequests(token);
        if(event.pageType.contains("Pending")) {
          List<PurchasedModel> shoppingItemsListNew = new List<PurchasedModel>();
          for(PurchasedModel item in shoppingItemsList) {
            if((!item.status.contains("Accepted") &&  !item.status.contains("Rejected"))) {
              shoppingItemsListNew.add(item);
            }
          }
          yield PendingGoodiesRequestsListLoaded(userModel,shoppingItemsListNew);
        }

        else if(event.pageType.contains("Accept")) {
          List<PurchasedModel> shoppingItemsListNew = new List<PurchasedModel>();
          for(PurchasedModel item in shoppingItemsList) {
            if((!item.status.isEmpty && !item.status.contains("Rejected"))) {
              shoppingItemsListNew.add(item);
            }
          }
          yield AcceptedGoodiesRequestListLoaded(userModel,shoppingItemsListNew);
        }
          else if(event.pageType.contains("Reject")) {
          List<PurchasedModel> shoppingItemsListNew = new List<PurchasedModel>();
          for(PurchasedModel item in shoppingItemsList) {
            if((!item.status.isEmpty && !item.status.contains("Accepted"))) {
              shoppingItemsListNew.add(item);
            }
          }
          yield RejectedGoodiesRequestsListLoaded(userModel,shoppingItemsListNew);
        }

      } catch(error) {
        yield GoodieAcceptedError(error: error.toString());
      }
    } else if(event is AcceptedGoodiesRequestListEvent) {
      yield AcceptedGoodiesRequestListLoading();

      try {
        String token = await _getToken();
        List<PurchasedModel> shoppingItemsList = await userRepository.getGoodiesRequests(token);
        List<PurchasedModel> shoppingItemsListNew = new List<PurchasedModel>();
        for(PurchasedModel item in shoppingItemsList) {
           if(!item.status.isEmpty && !item.status.contains("Rejected")) {
             shoppingItemsListNew.add(item);
           }
        }
        yield AcceptedGoodiesRequestListLoaded(userModel,shoppingItemsListNew);
      } catch(error) {
        yield AcceptedGoodiesRequestListError(error: error.toString());
      }
    }  else if(event is RejectedGoodiesRequestsListEvent) {
      yield RejectedGoodiesRequestsListLoading();

      try {
        String token = await _getToken();
        List<PurchasedModel> shoppingItemsList = await userRepository.getGoodiesRequests(token);
        List<PurchasedModel> shoppingItemsListNew = new List<PurchasedModel>();
        for(PurchasedModel item in shoppingItemsList) {
          if(!item.status.isEmpty && !item.status.contains("Accepted")) {
            shoppingItemsListNew.add(item);
          }
        }
        yield RejectedGoodiesRequestsListLoaded(userModel,shoppingItemsListNew);
      } catch(error) {
        yield RejectedGoodiesRequestsListError(error: error.toString());
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

    }
  }
}
