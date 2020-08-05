
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/fetchPlayersModel.dart';
abstract class AdminHomeState extends Equatable {
  const AdminHomeState();

  @override
  List<Object> get props => [];
}

class AdminHomeInitial extends AdminHomeState {
  final UserModels userModels;

  AdminHomeInitial({this.userModels});
  @override
  List<Object> get props => [userModels];
}

class AdminHomeInProgress extends AdminHomeState {}

class AdminHomeLoaded extends AdminHomeState {}

class AdminHomeError extends AdminHomeState {
  final String error;

  const AdminHomeError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AdminHomeError { error: $error }';
}

//------------------------------------------------------------------

class FetchPlayersLoading extends AdminHomeState {}

class FetchPlayersLoaded extends AdminHomeState {
final List<FetchPlayersModel> fetchPlayers;
FetchPlayersLoaded(this.fetchPlayers);

@override
List<Object> get props => [fetchPlayers];
}

class FetchPlayersError extends AdminHomeState {
  final String error;

  const FetchPlayersError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FetchPlayersError { error: $error }';
}

//------------------------------------------------------------------

class AssignPointsLoading extends AdminHomeState {}

class AssignPointsLoaded extends AdminHomeState {
  final List<FetchPlayersModel> fetchPlayers;
  AssignPointsLoaded(this.fetchPlayers);

  @override
  List<Object> get props => [fetchPlayers];
}

class AssignPointsError extends AdminHomeState {
  final String error;

  const AssignPointsError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AssignPointsError { error: $error }';
}

//------------------------------------------------------------------

class AssignPointsToPlayerLoading extends AdminHomeState {}

class AssignPointsToPlayerLoaded extends AdminHomeState {
  final UserModel assignedPointsPlayer;
  AssignPointsToPlayerLoaded(this.assignedPointsPlayer);

  @override
  List<Object> get props => [assignedPointsPlayer];
}

class AssignPointsToPlayerError extends AdminHomeState {
  final String error;

  const AssignPointsToPlayerError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AssignPointsToPlayerError { error: $error }';
}

//------------------------------------------------------------------

class AssignVideosLoading extends AdminHomeState {}

class AssignVideosLoaded extends AdminHomeState {
  final List<VideoModel> videosList;
  final List<FetchPlayersModel> fetchPlayers;
  AssignVideosLoaded(this.videosList,this.fetchPlayers);

  @override
  List<Object> get props => [videosList,fetchPlayers];
}

class AssignVideosError extends AdminHomeState {
  final String error;

  const AssignVideosError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AssignVideosError { error: $error }';
}

//------------------------------------------------------------------

class AssignVideosToPlayerLoading extends AdminHomeState {}

class AssignVideosToPlayerLoaded extends AdminHomeState {
  final UserModel player;
  AssignVideosToPlayerLoaded(this.player);

  @override
  List<Object> get props => [player];
}

class AssignVideosToPlayerError extends AdminHomeState {
  final String error;

  const AssignVideosToPlayerError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AssignVideosToPlayerError { error: $error }';
}

//--------------For Individual Learning Plan Section-------------------------------
class IndLearningLoading extends AdminHomeState {}

class IndLearningLoaded extends AdminHomeState {
  final UserModel userModels;
  final List<FetchPlayersModel> fetchPlayers;
  IndLearningLoaded(this.userModels,this.fetchPlayers);
  @override
  List<Object> get props => [userModels,fetchPlayers];
}

class IndLearningError extends AdminHomeState {
  final String error;

  const IndLearningError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IndLearningError { error: $error }';
}


//--------------For Individual Learning Plan Section-------------------------------
class IndLearningDetailLoading extends AdminHomeState {}

class IndLearningDetailLLoaded extends AdminHomeState {
  final UserModel userModels;
  final IndividualLearningModel indiPlanForPlayer;
  IndLearningDetailLLoaded(this.userModels,this.indiPlanForPlayer);
  @override
  List<Object> get props => [userModels,indiPlanForPlayer];
}

class IndLearningDetailLError extends AdminHomeState {
  final String error;

  const IndLearningDetailLError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IndLearningDetailLError { error: $error }';
}