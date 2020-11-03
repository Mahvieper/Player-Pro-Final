import 'dart:convert';

import 'package:player_pro_final/authentication/authentication_bloc.dart';
import 'package:player_pro_final/home/bloc/home_event.dart';
import 'package:player_pro_final/home/bloc/home_state.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:user_repository/IndividualPlayersModel.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final UserModel userModel;
  final AuthenticationBloc authenticationBloc;
  List<ShoppingItemModel> shoppingItemsList;
 // String token;
  HomeBloc({
    @required this.userRepository,
    @required this.userModel,
    this.authenticationBloc
  })  : assert(userRepository != null),
        assert(userModel != null),
        super(HomeInitial());


  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = prefs.getString('token');
    if( token == null || token.isEmpty) {
      token = await prefs.getString('token');
    }
    return token;
  }

  _saveForgetClickedOff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool forgetClicked;
    forgetClicked = prefs.getBool('forgetClicked');
    if( forgetClicked == null || forgetClicked == true) {
      await prefs.setBool('forgetClicked', false);
    }
  }

  _getForgetClicked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool forgetClicked;
    forgetClicked = prefs.getBool('forgetClicked');
    return forgetClicked;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is HomeInitEvent) {
      yield HomeInitial();
      bool isForgetClicked = await _getForgetClicked();
      if(isForgetClicked !=null && isForgetClicked) {
        print("In Forget clicked");
        yield ForgetClicked();
        await _saveForgetClickedOff();
      } else {
        print("Not In Forget clicked");
      }
    }
    else if (event is FetchPoints) {
      yield HomePointsLoading();
      try {
        yield HomePointsLoaded(userModel);
      } catch (error) {
        yield HomePointsError(error: error.toString());
      }
    }  else if(event is IndividualLearningPlanSavedListEvent) {
      yield IndLearningSavedListLoading();
      try {
        String token = await _getToken();
        List<IndividualLearningModel> indiLearnList = await userRepository.getIndiPlanForPlayer(token,this.userModel.id.toString());
        yield IndLearningSavedListLoaded(userModel,indiLearnList);
      } catch (error) {
        yield IndLearningSavedListError(error: error.toString());
      }
    } else if(event is IndividualLearningPlan) {
      yield IndLearningLoading();
      try {
        String token = await _getToken();
        IndividualLearningModel indiLearnModel = event.indiModel;
        yield IndLearningLoaded(userModel,indiLearnModel);
      } catch (error) {
        yield IndLearningError(error: error.toString());
      }
    } else if(event is GetCoachEvent) {
      yield GetCoachLoading();
      try {
       // userModel = userRepository.fetchCoach();
        yield GetCoachLoaded(userModel);
      } catch (error) {
        yield GetCoachError(error: error.toString());
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

    } else if(event is ShopEvent) {
      yield ShopLoading();
      if (shoppingItemsList != null) {
        yield ShopLoaded(shoppingItemsList);
      } else {
        try {
          String token = await _getToken();
          List<ShoppingItemModel> shoppingItemsList = await userRepository.getShoppingItems(token);
          this.shoppingItemsList = shoppingItemsList;
          yield ShopLoaded(shoppingItemsList);
        } catch (error) {
          yield ShopError(error: error.toString());
        }
    }
    } else if(event is ItemConfirmationEvent) {
      yield ItemConfirmationLoading();
      try {
        yield ItemConfirmationLoaded(event.itemSelected,event.currentPlayer);
        //List<ShoppingItemModel> shoppingItemsList = await userRepository.getShoppingItems(token);
       // yield ShopLoaded(shoppingItemsList);
      }catch(error) {
        yield ItemConfirmationError(error: error.toString());
      }
    } else if(event is ItemPurchasedEvent) {
      yield ItemPurchasedLoading();

      try {
        String token = await _getToken();
        if(int.parse(event.currentPlayer.points) >= event.itemSelected.pointsRequired) {
          Map data = {
            "userName":event.currentPlayer.name,
            "userId" : event.currentPlayer.id,
            "points" : event.itemSelected.pointsRequired,
            "goodiesName" : event.itemSelected.name,
            "goodiesId" : event.itemSelected.id
          };
          //encode Map to JSON
          var body = json.encode(data);

          PurchasedModel itemShopped = await userRepository.makePurchase(token, body);
          int updatedPoints = int.parse(event.currentPlayer.points) - event.itemSelected.pointsRequired;
          event.currentPlayer.points = updatedPoints.toString();
          yield ItemPurchasedLoaded(itemShopped);
          yield ShopLoaded(this.shoppingItemsList);
        } else {
          yield ItemPurchasedError(error: "You don't have Enough Points to Buy this Item");
          yield ShopLoaded(this.shoppingItemsList);
        }
      }catch (error) {
        yield ItemPurchasedError(error: error.toString());
      }
    }  else if(event is ContactUsEvent) {
      yield ContactUsLoading();

      try {
        yield ContactUsLoaded(userModel);
      } catch(error) {
        yield ContactUsError(error : error.toString());
      }
    }
    else if(event is ContactUsRequested) {
      yield ContactUsLoading();
      UserModel userModel = event.userModel;
      String token = await _getToken();
      try {
        String responseMessage = await userRepository.sendContactUs(
            event.name, event.email, event.message, token);

        yield ContactUsSuccess(response: responseMessage);

        yield ContactUsLoaded(userModel);
      } catch(error) {
        ContactUsError(error: error.toString());
      }
    }
    else if (event is ReportProbEvent) {
      yield ReportProbLoading();

      try {
        yield ReportProbLoaded(userModel);
      } catch(error) {
        yield ReportProbError(error : error.toString());
      }
    }
    else if(event is ReportProbRequested) {
      yield ReportProbLoading();
      UserModel userModel = event.userModel;
      String token = await _getToken();
      try {
        String responseMessage = await userRepository.sendReportProblemRequest(
            event.name, event.title, event.problem, token);

        yield ReportProbSuccess(response: responseMessage);

        yield ReportProbLoaded(userModel);
      } catch(error) {
        ContactUsError(error: error.toString());
      }
    } else if(event is UpdatePasswordEvent) {
      yield UpdatePassLoading();
      try {
        yield UpdatePassLoaded(userModel);
      } catch(error) {
        yield UpdatePassError(error: error.toString());
      }
    } else if(event is UpdatePasswordRequested) {
      yield UpdatePassRequestedLoading();

      try {
        String token = await _getToken();
        String response = await userRepository.updatePassword(event.oldPass,event.newPass,token);
        yield UpdatePassRequestedLoaded(this.userModel);
        yield UpdatePassLoaded(userModel);
      }catch(error) {
        yield UpdatePassError(error: error.toString());
        yield UpdatePassLoaded(userModel);
      }
    } else if(event is PracticeCompletedEvent) {
      yield PracticeCompletedLoading();

      try {
        String token = await _getToken();
        Map data = {
          "isComplete": true,
        };
        //encode Map to JSON
        var body = json.encode(data);

        UserModel userModelResponse  = await userRepository.updateUser(token,this.userModel.id.toString(),body);
        yield PracticeCompletedLoaded(userModelResponse);
        //yield UpdatePassLoaded(userModel);
      }catch(error) {
        yield PracticeCompletedError(error: error.toString());
        yield PracticeCompletedLoaded(this.userModel);
       // yield UpdatePassLoaded(userModel);
      }
    }
  }
}