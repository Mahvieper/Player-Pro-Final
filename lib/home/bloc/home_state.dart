import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/IndividualPlayersModel.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final UserModels userModels;

  HomeInitial({this.userModels});
  @override
  List<Object> get props => [userModels];
}
class ForgetClicked extends HomeState {}

class HomeInProgress extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeError extends HomeState {
  final String error;

  const HomeError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeError { error: $error }';
}
//--------------For Points Section-------------------------------
class HomePointsLoading extends HomeState {}

class HomePointsLoaded extends HomeState {
  final UserModel userModels;

  HomePointsLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class HomePointsError extends HomeState {
  final String error;

  const HomePointsError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeError { error: $error }';
}

//--------------For Shop Section-------------------------------
class ShopLoading extends HomeState {}

class ShopLoaded extends HomeState {
  final List<ShoppingItemModel> shoppingItemsList;

  ShopLoaded(this.shoppingItemsList);
  @override
  List<Object> get props => [shoppingItemsList];
}

class ShopError extends HomeState {
  final String error;

  const ShopError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShopError { error: $error }';
}

//--------------For Shop Confirmation Section-------------------------------
class ItemConfirmationLoading extends HomeState {}

class ItemConfirmationLoaded extends HomeState {
  final ShoppingItemModel shoppingItem;
  final UserModel currentPlayer;
  ItemConfirmationLoaded(this.shoppingItem,this.currentPlayer);
  @override
  List<Object> get props => [shoppingItem,currentPlayer];
}

class ItemConfirmationError extends HomeState {
  final String error;

  const ItemConfirmationError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ItemConfirmationError { error: $error }';
}

//--------------For Item Purchased Section-------------------------------
class ItemPurchasedLoading extends HomeState {}

class ItemPurchasedLoaded extends HomeState {
  final PurchasedModel purchasedItem;
  //final UserModel currentPlayer;
  ItemPurchasedLoaded(this.purchasedItem);
  @override
  List<Object> get props => [purchasedItem];
}

class ItemPurchasedError extends HomeState {
  final String error;

  const ItemPurchasedError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ItemConfirmationError { error: $error }';
}
//--------------For Practice Section-------------------------------
class PracticeLoading extends HomeState {}

class PracticeLoaded extends HomeState {
  final UserModel userModels;

  PracticeLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class PracticeError extends HomeState {
  final String error;

  const PracticeError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PracticeError { error: $error }';
}

//--------------For Practice Section-------------------------------
class PracticeCompletedLoading extends HomeState {}

class PracticeCompletedLoaded extends HomeState {
  final UserModel userModels;

  PracticeCompletedLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class PracticeCompletedError extends HomeState {
  final String error;

  const PracticeCompletedError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PracticeCompletedError { error: $error }';
}

//--------------For Individual Learning Plan Saved List Section-------------------------------
class IndLearningSavedListLoading extends HomeState {}

class IndLearningSavedListLoaded extends HomeState {
  final UserModel userModels;
  final List<IndividualLearningModel> indiLearnList;
  IndLearningSavedListLoaded(this.userModels,this.indiLearnList);
  @override
  List<Object> get props => [userModels];
}

class IndLearningSavedListError extends HomeState {
  final String error;

  const IndLearningSavedListError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IndLearningSavedListError { error: $error }';
}
//--------------For Individual Learning Plan Section-------------------------------
class IndLearningLoading extends HomeState {}

class IndLearningLoaded extends HomeState {
  final UserModel userModels;
  final IndividualLearningModel indiLearnList;
  IndLearningLoaded(this.userModels,this.indiLearnList);
  @override
  List<Object> get props => [userModels];
}

class IndLearningError extends HomeState {
  final String error;

  const IndLearningError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IndLearningError { error: $error }';
}
//--------------For Get Coach Details Section-------------------------------
class GetCoachLoading extends HomeState {}

class GetCoachLoaded extends HomeState {
  final UserModel userModels;

  GetCoachLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class GetCoachError extends HomeState {
  final String error;

  const GetCoachError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GetCoachError { error: $error }';
}
//--------------For Get HighScores Section-------------------------------
class GetHighScoresLoading extends HomeState {}

class GetHighScoresLoaded extends HomeState {
  final List<PlayerPoints> userModels;

  GetHighScoresLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class GetHighScoresError extends HomeState {
  final String error;

  const GetHighScoresError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GetHighScoresError { error: $error }';
}

//--------------For Contact Us Section-------------------------------
class ContactUsLoading extends HomeState {}

class ContactUsLoaded extends HomeState {
  final UserModel userModels;

  ContactUsLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class ContactUsError extends HomeState {
  final String error;

  const ContactUsError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ContactUsError { error: $error }';
}

class ContactUsSuccess extends HomeState {
  final String response;

  const ContactUsSuccess({@required this.response});

  @override
  List<Object> get props => [response];

  @override
  String toString() => 'ContactUsSuccess { Response : $response }';
}
//--------------For Report Problem Section-------------------------------
class ReportProbLoading extends HomeState {}

class ReportProbLoaded extends HomeState {
  final UserModel userModels;

  ReportProbLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class ReportProbError extends HomeState {
  final String error;

  const ReportProbError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ReportProbError { error: $error }';
}

class ReportProbSuccess extends HomeState {
  final String response;

  const ReportProbSuccess({@required this.response});

  @override
  List<Object> get props => [response];

  @override
  String toString() => 'ReportProbSuccess { Response : $response }';
}

//--------------For Update Password Section-------------------------------
class UpdatePassLoading extends HomeState {}

class UpdatePassLoaded extends HomeState {
  final UserModel userModels;

  UpdatePassLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class UpdatePassError extends HomeState {
  final String error;

  const UpdatePassError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ReportProbError { error: $error }';
}

class UpdatePassSuccess extends HomeState {
  final String response;

  const UpdatePassSuccess({@required this.response});

  @override
  List<Object> get props => [response];

  @override
  String toString() => 'ReportProbSuccess { Response : $response }';
}

//--------------For Update Password  Requested Section-------------------------------
class UpdatePassRequestedLoading extends HomeState {}

class UpdatePassRequestedLoaded extends HomeState {
  final UserModel userModels;

  UpdatePassRequestedLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class UpdatePassRequestedError extends HomeState {
  final String error;

  const UpdatePassRequestedError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ReportProbError { error: $error }';
}
