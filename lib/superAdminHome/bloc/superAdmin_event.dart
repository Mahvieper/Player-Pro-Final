import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/fetchPlayersModel.dart';
import 'package:user_repository/user_repository.dart';


abstract class SuperAdminHomeEvent extends Equatable {
  const SuperAdminHomeEvent();
}

class SuperAdminHomeInitEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CreateOrUpdatePlayersEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdateUserEvent extends SuperAdminHomeEvent {
  final UserModel playerUpdate;
  const UpdateUserEvent(this.playerUpdate);
  @override
  // TODO: implement props
  List<Object> get props => [playerUpdate];
}

class UpdateUserInitiatedEvent extends SuperAdminHomeEvent {
  final UserModel playerUpdate;
  const UpdateUserInitiatedEvent(this.playerUpdate);
  @override
  // TODO: implement props
  List<Object> get props => [playerUpdate];
}

class AddNewUserEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddNewUserPlayerEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddNewUserPlayerCreateEvent extends SuperAdminHomeEvent {
 final UserModel createPlayer;

 const AddNewUserPlayerCreateEvent(this.createPlayer);
  @override
  // TODO: implement props
  List<Object> get props => [createPlayer];
}

class AddNewUserAdminEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddNewUserAdminCreateEvent extends SuperAdminHomeEvent {
  final UserModel createAdmin;

  const AddNewUserAdminCreateEvent(this.createAdmin);
  @override
  // TODO: implement props
  List<Object> get props => [createAdmin];
}

class UploadVideosPageEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class OpenGoodiesListPageEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoodiesRequestEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PendingGoodiesRequestsListEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoodieAcceptedEvent extends SuperAdminHomeEvent {
  final PurchasedModel goodieRequestModel;
  final bool isAccepted;
  final String pageType;
  GoodieAcceptedEvent(this.goodieRequestModel,this.isAccepted,this.pageType);
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class AcceptedGoodiesRequestListEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RejectedGoodiesRequestsListEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OpenVideosListEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetHighScoreEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VideoUploadingEvent extends SuperAdminHomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}