import 'package:flutter/material.dart';
import 'package:player_pro_final/home/home.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:user_repository/user_repository.dart';
class HomeSelection extends StatelessWidget {
  final UserRepository userRepository;
  String userRole;
  HomeSelection(this.userRole,this.userModel,this.userRepository);
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
     switch(userRole) {
       case 'SuperAdmin' :
       //  return SuperAdmin();
         break;
       case 'Admin' :
       //  return Admin();
         break;
       case 'Player' :
         return HomePage(userModel,userRepository);
         break;
    }
  }
}
