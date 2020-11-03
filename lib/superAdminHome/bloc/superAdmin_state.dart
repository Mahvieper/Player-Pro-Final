
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/fetchPlayersModel.dart';
abstract class SuperAdminHomeState extends Equatable {
  const SuperAdminHomeState();

  @override
  List<Object> get props => [];
}


class SuperAdminHomeInitial extends SuperAdminHomeState {
  final UserModels userModels;

  SuperAdminHomeInitial({this.userModels});
  @override
  List<Object> get props => [userModels];
}

class SuperAdminHomeInProgress extends SuperAdminHomeState {}

class SuperAdminHomeLoaded extends SuperAdminHomeState {}

class SuperAdminHomeError extends SuperAdminHomeState {
  final String error;

  const SuperAdminHomeError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SuperAdminHomeError { error: $error }';
}

//----------Create Players or Update Players--------------------------------------------------------

class CreateUpdatePlayersLoading extends SuperAdminHomeState {}

class CreateUpdatePlayersLoaded extends SuperAdminHomeState {
  final List<UserModel> fetchUsers;
  CreateUpdatePlayersLoaded(this.fetchUsers);

  @override
  List<Object> get props => [fetchUsers];
}

class CreateUpdatePlayersError extends SuperAdminHomeState {
  final String error;

  const CreateUpdatePlayersError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreateUpdatePlayersError { error: $error }';
}

//---------------------Update User---------------------------------------------
class UpdateUserLoading extends SuperAdminHomeState {}

class UpdateUserLoaded extends SuperAdminHomeState {
  final UserModel playerUpdate;
  UpdateUserLoaded(this.playerUpdate);

  @override
  List<Object> get props => [playerUpdate];
}

class UpdateUserError extends SuperAdminHomeState {
  final String error;

  const UpdateUserError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateUserError { error: $error }';
}

//---------------------Update User Initiated---------------------------------------------
class UpdateUserInitiatedLoading extends SuperAdminHomeState {}

class UpdateUserInitiatedLoaded extends SuperAdminHomeState {
  final UserModel playerUpdate;
  UpdateUserInitiatedLoaded(this.playerUpdate);

  @override
  List<Object> get props => [playerUpdate];
}

class UpdateUserInitiatedError extends SuperAdminHomeState {
  final String error;

  const UpdateUserInitiatedError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateUserInitiatedError { error: $error }';
}

//---------------------AddNewUser Page Opening---------------------------------------------
class AddNewUserLoading extends SuperAdminHomeState {}

class AddNewUserLoaded extends SuperAdminHomeState {
  @override
  List<Object> get props => [];
}

class AddNewUserError extends SuperAdminHomeState {
  final String error;

  const AddNewUserError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddNewUserError { error: $error }';
}

//---------------------AddNewUser Player Page Open---------------------------------------------
class AddNewUserPlayerLoading extends SuperAdminHomeState {}

class AddNewUserPlayerLoaded extends SuperAdminHomeState {
  @override
  List<Object> get props => [];
}

class AddNewUserPlayerError extends SuperAdminHomeState {
  final String error;

  const AddNewUserPlayerError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddNewUserPlayerError { error: $error }';
}

//---------------------AddNewUser Player Create call to server Open---------------------------------------------
class AddNewUserPlayerCreateLoading extends SuperAdminHomeState {}

class AddNewUserPlayerCreateLoaded extends SuperAdminHomeState {
  final UserModel createdPlayer;
  AddNewUserPlayerCreateLoaded(this.createdPlayer);
  @override
  List<Object> get props => [createdPlayer];
}

class AddNewUserPlayerCreateError extends SuperAdminHomeState {
  final String error;

  const AddNewUserPlayerCreateError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddNewUserPlayerCreateError { error: $error }';
}

//---------------------AddNewUser Admin Page Open---------------------------------------------
class AddNewUserAdminLoading extends SuperAdminHomeState {}

class AddNewUserAdminLoaded extends SuperAdminHomeState {
  @override
  List<Object> get props => [];
}

class AddNewUserAdminError extends SuperAdminHomeState {
  final String error;

  const AddNewUserAdminError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddNewUserAdminError { error: $error }';
}

//---------------------AddNewUser Admin Create call to server Open---------------------------------------------
class AddNewUserAdminCreateLoading extends SuperAdminHomeState {}

class AddNewUserAdminCreateLoaded extends SuperAdminHomeState {
  final UserModel createdAdmin;
  AddNewUserAdminCreateLoaded(this.createdAdmin);
  @override
  List<Object> get props => [createdAdmin];
}

class AddNewUserAdminCreateError extends SuperAdminHomeState {
  final String error;

  const AddNewUserAdminCreateError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddNewUserAdminCreateError { error: $error }';
}

//---------------------Upload Videos HomePage---------------------------------------------
class UploadVideosPageLoading extends SuperAdminHomeState {}

class UploadVideosPageLoaded extends SuperAdminHomeState {
  final UserModel userModelVideo;
  UploadVideosPageLoaded(this.userModelVideo);
  @override
  List<Object> get props => [userModelVideo];
}

class UploadVideosPageError extends SuperAdminHomeState {
  final String error;

  const UploadVideosPageError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddNewUserAdminCreateError { error: $error }';
}

//---------------------OpenVideosListEvent---------------------------------------------
class OpenVideosListPageLoading extends SuperAdminHomeState {}

class OpenVideosListPageLoaded extends SuperAdminHomeState {
  final UserModel userModelVideo;
  final List<VideoModel> videosList;
  OpenVideosListPageLoaded(this.userModelVideo,this.videosList);
  @override
  List<Object> get props => [userModelVideo];
}

class OpenVideosListPageError extends SuperAdminHomeState {
  final String error;

  const OpenVideosListPageError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OpenVideosListPageError { error: $error }';
}

//---------------------OpenVideosListEvent---------------------------------------------
class OpenGoodiesListPageLoading extends SuperAdminHomeState {}

class OpenGoodiesListPageLoaded extends SuperAdminHomeState {
  final UserModel userModelVideo;
  final List<ShoppingItemModel> shoppingItemsList;
  OpenGoodiesListPageLoaded(this.userModelVideo,this.shoppingItemsList);
  @override
  List<Object> get props => [userModelVideo];
}

class OpenGoodiesListPageError extends SuperAdminHomeState {
  final String error;

  const OpenGoodiesListPageError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OpenGoodiesListPageError { error: $error }';
}

//---------------------GoodiesRequestEvent---------------------------------------------
class GoodiesRequestLoading extends SuperAdminHomeState {}

class GoodiesRequestLoaded extends SuperAdminHomeState {
  @override
  List<Object> get props => [];
}

class GoodiesRequestError extends SuperAdminHomeState {
  final String error;

  const GoodiesRequestError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GoodiesRequestError { error: $error }';
}



//---------------------PendingGoodiesRequestsListEvent---------------------------------------------
class PendingGoodiesRequestsListLoading extends SuperAdminHomeState {}

class PendingGoodiesRequestsListLoaded extends SuperAdminHomeState {
  final UserModel userModelVideo;
  final List<PurchasedModel> shoppingItemsList;
  PendingGoodiesRequestsListLoaded(this.userModelVideo,this.shoppingItemsList);
  @override
  List<Object> get props => [];
}

class PendingGoodiesRequestsListError extends SuperAdminHomeState {
  final String error;

  const PendingGoodiesRequestsListError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PendingGoodiesRequestsListError { error: $error }';
}


//---------------------GoodieAcceptedEvent---------------------------------------------
class GoodieAcceptedLoading extends SuperAdminHomeState {}

class GoodieAcceptedLoaded extends SuperAdminHomeState {
  final UserModel userModelVideo;
  final PurchasedModel shoppingItem;
  GoodieAcceptedLoaded(this.userModelVideo,this.shoppingItem);
  @override
  List<Object> get props => [];
}

class GoodieAcceptedError extends SuperAdminHomeState {
  final String error;

  const GoodieAcceptedError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GoodieAcceptedError { error: $error }';
}


//---------------------AcceptedGoodiesRequestListEvent---------------------------------------------
class AcceptedGoodiesRequestListLoading extends SuperAdminHomeState {}

class AcceptedGoodiesRequestListLoaded extends SuperAdminHomeState {
  final UserModel userModelVideo;
  final List<PurchasedModel> shoppingItemsList;
  AcceptedGoodiesRequestListLoaded(this.userModelVideo,this.shoppingItemsList);
  @override
  List<Object> get props => [userModelVideo,shoppingItemsList];
}

class AcceptedGoodiesRequestListError extends SuperAdminHomeState {
  final String error;

  const AcceptedGoodiesRequestListError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PendingGoodiesRequestsListError { error: $error }';
}

//--------------For Get HighScores Section-------------------------------
class GetHighScoresLoading extends SuperAdminHomeState {}

class GetHighScoresLoaded extends SuperAdminHomeState {
  final List<PlayerPoints> userModels;

  GetHighScoresLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class GetHighScoresError extends SuperAdminHomeState {
  final String error;

  const GetHighScoresError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GetHighScoresError { error: $error }';
}

//---------------------RejectedGoodiesRequestsListEvent---------------------------------------------
class RejectedGoodiesRequestsListLoading extends SuperAdminHomeState {}

class RejectedGoodiesRequestsListLoaded extends SuperAdminHomeState {
  final UserModel userModelVideo;
  final List<PurchasedModel> shoppingItemsList;
  RejectedGoodiesRequestsListLoaded(this.userModelVideo,this.shoppingItemsList);
  @override
  List<Object> get props => [userModelVideo,shoppingItemsList];
}

class RejectedGoodiesRequestsListError extends SuperAdminHomeState {
  final String error;

  const RejectedGoodiesRequestsListError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RejectedGoodiesRequestsListError { error: $error }';
}