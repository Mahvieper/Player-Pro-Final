import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:user_repository/user_repository.dart';
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
  final UserModel userModels;

  ShopLoaded(this.userModels);
  @override
  List<Object> get props => [userModels];
}

class ShopError extends HomeState {
  final String error;

  const ShopError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ShopError { error: $error }';
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
//--------------For Individual Learning Plan Section-------------------------------
class IndLearningLoading extends HomeState {}

class IndLearningLoaded extends HomeState {
  final UserModel userModels;
  final List<IndividualLearningModel> indiLearnList;
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