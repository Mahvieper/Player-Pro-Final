
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/fetchPlayersModel.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/IndividualPlayersModel.dart';

abstract class AdminHomeEvent extends Equatable {
  const AdminHomeEvent();
}

class AdminHomeInitEvent extends AdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchPlayers extends AdminHomeEvent {
  final UserModel userModel;

  FetchPlayers(this.userModel);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AssignPointsEvent extends AdminHomeEvent {
  final UserModel userModel;

  AssignPointsEvent(this.userModel);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AssignPointsToPlayerEvent extends AdminHomeEvent {
  final String playerId;
  final String pointsAssigned;
  AssignPointsToPlayerEvent(this.playerId,this.pointsAssigned);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AssignVideosEvent extends AdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AssignVideosToPlayerEvent extends AdminHomeEvent {
  final FetchPlayersModel playerClicked;
  final String videoUrl;
  final VideoModel videoModel;
  AssignVideosToPlayerEvent(this.playerClicked,this.videoUrl,this.videoModel);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AssignVideosToPlayerErrorEvent extends AdminHomeEvent {
  final String error;
  AssignVideosToPlayerErrorEvent(this.error);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class IndividualLearningPlan extends AdminHomeEvent {

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class IndividualLearningPlanSavedList extends AdminHomeEvent {
  final FetchPlayersModel clickedPlayer;
  IndividualLearningPlanSavedList(this.clickedPlayer);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class IndividualLearningPlanDetail extends AdminHomeEvent {
  final FetchPlayersModel clickedPlayer;
  final IndividualLearningModel clickedIndiDateModel;
  IndividualLearningPlanDetail(this.clickedPlayer,this.clickedIndiDateModel);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SnackBarEvent extends AdminHomeEvent {
  final String message;
  SnackBarEvent(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class IndividualLearningPlanDetailSend extends AdminHomeEvent {
  final IndividualLearningModel modelForPlayer;

  IndividualLearningPlanDetailSend(this.modelForPlayer);
  @override
  // TODO: implement props
  List<Object> get props => [modelForPlayer];
}

class GetHighScoreEvent extends AdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}