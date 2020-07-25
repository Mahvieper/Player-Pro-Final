import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class PracticePage extends StatefulWidget {
  final UserModel userModel;
  PracticePage(this.userModel);
  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
                
            ],
          ),
      ),
    );
  }
}
