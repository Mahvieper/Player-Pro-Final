import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/adminHome/bloc/admin_bloc.dart';
import 'package:player_pro_final/adminHome/bloc/admin_event.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/superAdminHome/bloc/superAdmin_bloc.dart';
import 'package:user_repository/fetchPlayersModel.dart';
import 'package:user_repository/user_repository.dart';

import 'bloc/superAdmin_event.dart';

class UploadPracticeVideosPage extends StatefulWidget {
  final UserModel userModel;
  final UserRepository userRepository;
  UploadPracticeVideosPage(this.userModel,this.userRepository);

  @override
  _UploadPracticeVideosPageState createState() => _UploadPracticeVideosPageState();
}

class _UploadPracticeVideosPageState extends State<UploadPracticeVideosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            return SuperAdminHomeBloc(
              userModel: widget.userModel,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: widget.userRepository,
            )..add(UploadVideosPageEvent());
          },
         // child: BlocProvider,
        ),
      ),
    );
  }
}
