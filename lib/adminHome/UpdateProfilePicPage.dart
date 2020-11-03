import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

class UpdateProfilePicPage extends StatefulWidget {
  final UserRepository userRepository;
  final UserModel userModel;
  UpdateProfilePicPage(this.userModel,this.userRepository);
  @override
  _UpdateProfilePicPageState createState() => _UpdateProfilePicPageState();
}

class _UpdateProfilePicPageState extends State<UpdateProfilePicPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  bool isLoading = false;
  File _image;


  _pickVideo() async {
    File file = await FilePicker.getFile();
    setState(() {
      _image = file;
    });
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'Profile/${randomNumber}';

      // Upload image to firebase.
      final StorageReference storageReference =
      FirebaseStorage().ref().child(imageLocation);

      final StorageUploadTask uploadTask = storageReference.putFile(image);
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

        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print(e.message);
    }
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
        "image": imageString,
      };
      var body = json.encode(data);
      UserModel goodie = await widget.userRepository.updateUser(token, widget.userModel.id.toString(), body);
      if(goodie !=null) {
        print(goodie.toString());
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

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Please Select an Image First'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
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
                    //_videoPlayerController.pause();
                    Navigator.pop(context);
                    //BlocProvider.of<SuperAdminHomeBloc>(context).add(SuperAdminHomeInitEvent());
                  },
                ),
              ),
            ),


            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _image != null
                          ? Container(
                          padding:
                          EdgeInsets.zero,
                          height: MediaQuery.of(context).size.height * 5,
                          width: MediaQuery.of(context).size.width * 2,
                          child: Image.file(_image)
                      )
                          : Container(),
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(child: Text("Pick an Image for the Goodie"),
                    onPressed: () {
                      _pickVideo();
                    },),
                ),

                  SizedBox(
                    width: 250,
                    child: RaisedButton(
                      onPressed: () {
                        if (_image !=null) {
                          // formKey.currentState.save();
                          print('Form is valid');
                          // BlocProvider.of<SuperAdminHomeBloc>(context).add(ContactUsRequested(userModel,_name,_contactEmail,_message));
                          if(_image !=null) {
                            setState(() {
                              isLoading = true;
                            });
                            _uploadImageToFirebase(_image).whenComplete(() {
                            });
                          }

                        } else {
                          /*  print(
                          formKey.currentState.validate());
                      print(formKey.currentState);
                      print('Form is Not valid');*/
                          _displaySnackBar(context);
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
              ],),
            ),





          ],
        ),
      ),
    );
  }
}
