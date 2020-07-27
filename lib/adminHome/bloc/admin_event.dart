
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';


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