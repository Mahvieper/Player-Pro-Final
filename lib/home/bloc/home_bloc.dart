import 'package:player_pro_final/authentication/authentication_bloc.dart';
import 'package:player_pro_final/home/bloc/home_event.dart';
import 'package:player_pro_final/home/bloc/home_state.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:player_pro_final/model/model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final UserModel userModel;
  final AuthenticationBloc authenticationBloc;
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

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is HomeInitEvent) {

      yield HomeInitial();
    }
    else if (event is FetchPoints) {
      yield HomePointsLoading();
      try {
        yield HomePointsLoaded(userModel);
      } catch (error) {
        yield HomePointsError(error: error.toString());
      }
    } else if(event is IndividualLearningPlan) {
      yield IndLearningLoading();
      try {
        String token = await _getToken();
        List<IndividualLearningModel> indiLearnList = await userRepository.getIndiPlan(token);
        yield IndLearningLoaded(userModel,indiLearnList);
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

    }else if(event is ShopEvent) {

    } else if(event is PracticeEvent) {

    } else if(event is ContactUsEvent) {
      yield ContactUsLoading();

      try {
        yield ContactUsLoaded(userModel);
      } catch(error) {
        yield ContactUsError(error : error.toString());
      }
    } else if(event is ContactUsRequested) {
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
    } else if (event is ReportProbEvent) {
      yield ReportProbLoading();

      try {
        yield ReportProbLoaded(userModel);
      } catch(error) {
        yield ReportProbError(error : error.toString());
      }
    } else if(event is ReportProbRequested) {
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
    }
  }
}