
import 'package:player_pro_final/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeInitEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchPoints extends HomeEvent {
  final UserModel userModels;
  const FetchPoints({
    @required this.userModels,
  });

  @override
  List<Object> get props => [userModels];

  @override
  String toString() =>
      'FetchPoints { userModels: $userModels }';
}

class ShopEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ItemConfirmationEvent extends HomeEvent {
  final ShoppingItemModel itemSelected;
  final UserModel currentPlayer;

  ItemConfirmationEvent(this.itemSelected,this.currentPlayer);
  @override
  // TODO: implement props
  List<Object> get props => [itemSelected,currentPlayer];
}


class ItemPurchasedEvent extends HomeEvent {
  final ShoppingItemModel itemSelected;
  final UserModel currentPlayer;

  ItemPurchasedEvent(this.itemSelected,this.currentPlayer);
  @override
  // TODO: implement props
  List<Object> get props => [itemSelected,currentPlayer];
}

class PracticeEvent extends HomeEvent {

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class IndividualLearningPlan extends HomeEvent {

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetCoachEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetHighScoreEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContactUsEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContactUsRequested extends HomeEvent {
  final UserModel userModel;
  final String name,email,message;
  const ContactUsRequested(this.userModel,this.name,this.email,this.message);
  @override
  // TODO: implement props
  List<Object> get props => [userModel,name,email,message];
}

class ReportProbEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ReportProbRequested extends HomeEvent {
  final UserModel userModel;
  final String name,title,problem;
  const ReportProbRequested(this.userModel,this.name,this.title,this.problem);
  @override
  // TODO: implement props
  List<Object> get props => [userModel,name,title,problem];
}