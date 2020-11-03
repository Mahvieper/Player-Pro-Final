import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player_pro_final/authentication/authentication.dart';
import 'package:player_pro_final/common/common.dart';
import 'package:player_pro_final/superAdminHome/bloc/superAdmin_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:video_player/video_player.dart';

import 'bloc/superAdmin_bloc.dart';
import 'bloc/superAdmin_state.dart';

class UploadVideosPage extends StatefulWidget {
  final UserRepository userRepository;
  final UserModel userModel;
  UploadVideosPage(this.userModel,this.userRepository);
  @override
  _UploadVideosPageState createState() => _UploadVideosPageState();
}

class _UploadVideosPageState extends State<UploadVideosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String _videoName, _desc;
  File _video;
  VideoPlayerController _videoPlayerController;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _pickVideo() async {
      File file = await FilePicker.getFile();
      _video = file;
      _videoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
          Future.delayed(new Duration(seconds: 1));
        });
    }

    Widget buildInputs(String title) {
      return Container(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(211, 172, 43, 1), width: 0.5)),
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(211, 172, 43, 1),
                            width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Color.fromRGBO(211, 172, 43, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: "MontserratRegular",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(color: Color(0xFF3a3a3f)),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: title.contains("Description") ? 5 : 1,
                  maxLines: 8,
                  onSaved: (val) {
                    if (title.contains("Video NAME"))
                      _videoName = val;
                    else if (title.contains("Description"))
                      _desc = val;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "MontserratRegular",
                  ),
                ),
              ),

            ],
          ));
    }

    _getToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = "";
      token = prefs.getString('token');
      if (token == null || token.isEmpty) {
        token = await prefs.getString('token');
      }
      return token;
    }

    Future<void> _addPathToDatabase(String text) async {
      try {
        // Get image URL from firebase
        final ref = FirebaseStorage().ref().child(text);
        var imageString = await ref.getDownloadURL();
        print("URL for the Video : "+ imageString);
        String token = await _getToken();
        Map data;
        data = {
          "Name" : _videoName,
          "Description" : _desc,
          "isActive" : "true",
          "videoLink": imageString,
        };
        var body = json.encode(data);
       VideoModel video = await widget.userRepository.postPracticeVideo(token, widget.userModel.id.toString(), body);
       if(video !=null) {
         print(video.toString());
       }
      } catch (e) {
        print(e.message);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message),
              );
            });
      }
    }

    Future<void> _uploadImageToFirebase(File video) async {
      try {
        // Make random image name.
        int randomNumber = Random().nextInt(100000);
        String imageLocation = 'PracticeVideos/${_videoName}';

        // Upload image to firebase.
        final StorageReference storageReference =
        FirebaseStorage().ref().child(imageLocation);

        final StorageUploadTask uploadTask = storageReference.putFile(video);
        uploadTask.isInProgress;
        CircularProgressIndicator();
        await uploadTask.onComplete;
        _addPathToDatabase(imageLocation).whenComplete(() {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Alert"),
                  content: Text("Post Uploaded"),
                );
              });
        });
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e.message);
      }
    }



    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Stack(
                children: [
                  Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/homeBack.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back, color: Colors.white,),
                        onPressed: () {
                          if(_videoPlayerController !=null)
                          _videoPlayerController.pause();
                          Navigator.pop(context);
                          //BlocProvider.of<SuperAdminHomeBloc>(context).add(SuperAdminHomeInitEvent());
                        },
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 250,
                      child: RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            print('Form is valid');
                            if(_video !=null) {
                              setState(() {
                                isLoading = true;
                              });
                              _uploadImageToFirebase(_video).whenComplete(() {

                              });
                            }
                            // BlocProvider.of<SuperAdminHomeBloc>(context).add(ContactUsRequested(userModel,_name,_contactEmail,_message));
                          } else {
                            print(
                                formKey.currentState.validate());
                            print(formKey.currentState);
                            print('Form is Not valid');
                          }
                        },
                        child: isLoading ? CircularProgressIndicator() : Text(
                          "SEND",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "MontserratRegular",
                              letterSpacing: 3),
                        ),
                        color: Color(0xFFbf2431),
                        disabledColor:
                        Color.fromARGB(191, 36, 49, 1),
                        shape: Border.all(
                            color: Color.fromRGBO(
                                211, 172, 43, 1)),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.15),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.8,
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          buildInputs("Video NAME"),
                          buildInputs("Description"),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            margin: EdgeInsets.only(top: 20),
                            child: RaisedButton(child: Text("Pick a Video"),
                                onPressed: () {
                                  _pickVideo();
                                },),
                          ),

                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: _video != null
                                    ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: VideoPlayer(_videoPlayerController)
                                    )
                                    : Container(),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
        ),
      );
  }
}
