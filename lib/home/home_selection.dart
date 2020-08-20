import 'package:flutter/material.dart';
import 'package:player_pro_final/home/home.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:player_pro_final/superAdminHome/super_admin_home_page.dart';
import 'package:user_repository/user_repository.dart';

import '../adminHome/admin_home_page.dart';
class HomeSelection extends StatelessWidget {
  final UserRepository userRepository;
  String userRole;
  HomeSelection(this.userRole,this.userModel,this.userRepository);
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
     switch(userRole) {
       case 'Super Admin' :
         return SuperAdminHomePage(userModel,userRepository);
         break;
       case 'Admin' :
        return AdminHomePage(userModel,userRepository);
         break;
       case 'Player' :
         return HomePage(userModel,userRepository);
         break;
    }
  }
}
