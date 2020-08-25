import 'package:flutter/material.dart';
import 'package:player_pro_final/home/home.dart';
import 'package:player_pro_final/model/model.dart';
import 'package:player_pro_final/superAdminHome/super_admin_home_page.dart';
import 'package:user_repository/user_repository.dart';

import '../adminHome/admin_home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class HomeSelection extends StatefulWidget {
  final UserRepository userRepository;
  String userRole;
  HomeSelection(this.userRole,this.userModel,this.userRepository);
  final UserModel userModel;

  @override
  _HomeSelectionState createState() => _HomeSelectionState();
}

class _HomeSelectionState extends State<HomeSelection> {

  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });

  }

  @override
  Widget build(BuildContext context) {
     switch(widget.userRole) {
       case 'Super Admin' :
         return SuperAdminHomePage(widget.userModel,widget.userRepository);
         break;
       case 'Admin' :
        return AdminHomePage(widget.userModel,widget.userRepository);
         break;
       case 'Player' :
         return HomePage(widget.userModel,widget.userRepository);
         break;
    }
  }
}
