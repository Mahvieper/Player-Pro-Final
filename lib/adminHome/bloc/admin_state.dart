
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