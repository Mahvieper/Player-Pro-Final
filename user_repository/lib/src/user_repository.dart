import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';


class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    var url = 'https://akyproplayer.herokuapp.com/token/';
    Map data = {
      "email":username,
      "password":password
    };
    //encode Map to JSON
    var body = json.encode(data);
    // final result = await http.Client().get('https://akyproplayer.herokuapp.com/token/');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");

    final parsed = json.decode(response.body);
    Token_Model token_model =  Token_Model.fromJson(parsed);

    if(response.statusCode != 200) {
      throw Exception();
    }

    return token_model.token;

    //return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<UserModel> getUser(String token) async {
    var url = 'https://akyproplayer.herokuapp.com/me/';
    print("Token Header " + token);
    var response = await http.get(url,
      headers: {"Authorization" : "Token "+token},
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 200) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    UserModel user = UserModel.fromJson(parsed);

    return user;
  }

//Fetching List of Users a Player,Admin or SuperAdmin
  Future<List<PlayerPoints>> getUsers(String token,String userType) async {
    var url = 'https://akyproplayer.herokuapp.com/filter/'+ userType;
    print("Token Header " + token);
    var response = await http.get(url,
      headers: {"Authorization" : "Token "+token},
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 200) {
      throw Exception();
    }

    final parsed = json.decode(response.body) as List;
    List<PlayerPoints> users = new List<PlayerPoints>();

    for(Map i in parsed){
      users.add(PlayerPoints.fromJson(i));
    }

    print("Users Before List ==> ");
    print(users);
    users.sort((a, b) => int.parse(a.fields.points).compareTo(int.parse(b.fields.points)));
    users = users.reversed.toList();
    print("Users after List ==> ");
    print(users);
    return users;
  }


//Sending Contact US Request
  Future<String> sendContactUs(String name,String email,String message,String token) async {
    var url = 'https://akyproplayer.herokuapp.com/sendcontact/';
    print("Token Header " + token);

    Map data = {
      "name":name,
      "email":email,
      "message":message
    };
    //encode Map to JSON
    print(data);
    var body = json.encode(data);

    var response = await http.post(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
      body: body
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 200) {
      throw Exception();
    }

    final parsed = json.decode(response.body);

    return parsed.toString();
  }

  //Sending Report Problem US Request
  Future<String> sendReportProblemRequest(String name,String title,String problem,String token) async {
    var url = 'https://akyproplayer.herokuapp.com/sendcomplaint/';
    print("Token Header " + token);

    Map data = {
      "name":name,
      "title":title,
      "problem":problem
    };
    //encode Map to JSON
    print(data);
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Authorization" : "Token "+token,
          "Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 200) {
      throw Exception();
    }

    final parsed = json.decode(response.body);

    return parsed.toString();
  }

  Future<List<IndividualLearningModel>> getIndiPlan(String token) async {
    var url = 'https://akyproplayer.herokuapp.com/individual/';
    print("Token Header " + token);
    var response = await http.get(url,
      headers: {"Authorization" : "Token "+token},
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 200) {
      throw Exception();
    }

    final parsed = json.decode(response.body) as List;
    List<IndividualLearningModel> indiLearnList = new List<IndividualLearningModel>();

    for(Map i in parsed){
      indiLearnList.add(IndividualLearningModel.fromJson(i));
    }

    return indiLearnList;
  }

}

class Token_Model {
  String token;

  Token_Model({this.token});

  Token_Model.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class UserModel {
  String email;
  int id;
  String name;
  String role;
  String superAdminName;
  String adminName;
  String points;
  bool userActive;
  String superAdminDeviceRegId;
  String adminDeviceRegId;
  String userDeviceRegId;
  int superAdminId;
  int adminId;
  String image;
  String videoUrl;
  String designation;
  String level;
  String experience;
  String adminDetails;

  UserModel(
      {this.email,
        this.id,
        this.name,
        this.role,
        this.superAdminName,
        this.adminName,
        this.points,
        this.userActive,
        this.superAdminDeviceRegId,
        this.adminDeviceRegId,
        this.userDeviceRegId,
        this.superAdminId,
        this.adminId,
        this.image,
        this.videoUrl,
        this.designation,
        this.level,
        this.experience,
        this.adminDetails});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    role = json['role'];
    if(json['superAdminName'] != null)
      superAdminName = json['superAdminName'];
    else
      superAdminName = "";
    if(json['AdminName']  != null)
     adminName = json['AdminName'];
    else
      adminName = "";

    if(json['points'] !=null)
     points = json['points'];
    else
      points ="";

    if(json['userActive'])
    userActive = json['userActive'];
    else
      userActive = false;

    if(json['superAdminDeviceRegId'] !=null)
     superAdminDeviceRegId = json['superAdminDeviceRegId'];
    else
      superAdminDeviceRegId ="";
    if(json['adminDeviceRegId'] !=null)
     adminDeviceRegId = json['adminDeviceRegId'];
    else
      adminDeviceRegId = "";
    if(json['userDeviceRegId'] !=null)
    userDeviceRegId = json['userDeviceRegId'];
    else
      userDeviceRegId = "";

    if(json['super_admin_id'] != null)
     superAdminId = json['super_admin_id'];
    else
      superAdminId = 0;

    if(json['admin_id'] !=null)
     adminId = json['admin_id'];
    else
      adminId = 0;

    if(json['image']!=null)
     image = json['image'];
    else
      image ="";

    if(json['videoUrl'] !=null)
     videoUrl = json['videoUrl'];
    else
      videoUrl = "";

    if(json['designation'] !=null)
     designation = json['designation'];
    else
      designation = "";

    if(json['level'] !=null)
     level = json['level'];
    else
      level ="";

    if(json['experience'] !=null)
     experience = json['experience'];
    else
      experience ="";
    if(json['adminDetails'] !=null)
     adminDetails = json['adminDetails'];
    else
      adminDetails = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['superAdminName'] = this.superAdminName;
    data['AdminName'] = this.adminName;
    data['points'] = this.points;
    data['userActive'] = this.userActive;
    data['superAdminDeviceRegId'] = this.superAdminDeviceRegId;
    data['adminDeviceRegId'] = this.adminDeviceRegId;
    data['userDeviceRegId'] = this.userDeviceRegId;
    data['super_admin_id'] = this.superAdminId;
    data['admin_id'] = this.adminId;
    data['image'] = this.image;
    data['videoUrl'] = this.videoUrl;
    data['designation'] = this.designation;
    data['level'] = this.level;
    data['experience'] = this.experience;
    data['adminDetails'] = this.adminDetails;
    return data;
  }
}

class PlayerPoints {
  String model;
  int pk;
  Fields fields;

  PlayerPoints({this.model, this.pk, this.fields});

  PlayerPoints.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields =
    json['fields'] != null ? new Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['pk'] = this.pk;
    if (this.fields != null) {
      data['fields'] = this.fields.toJson();
    }
    return data;
  }
}

class Fields {
  String name;
  String points;
  int id;

  Fields({this.name, this.points, this.id});

  Fields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    points = json['points'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['points'] = this.points;
    data['id'] = this.id;
    return data;
  }
}

class IndividualLearningModel {
  int id;
  int playerId;
  String name;
  String target;
  String technical;
  String physical;
  String psychology;
  String social;
  String tactical;
  String information;
  String date;

  IndividualLearningModel(
      {this.id,
        this.playerId,
        this.name,
        this.target,
        this.technical,
        this.physical,
        this.psychology,
        this.social,
        this.tactical,
        this.information,
        this.date});

  IndividualLearningModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['playerId'];
    name = json['Name'];
    target = json['Target'];
    technical = json['Technical'];
    physical = json['Physical'];
    psychology = json['Psychology'];
    social = json['Social'];
    tactical = json['Tactical'];
    information = json['Information'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['playerId'] = this.playerId;
    data['Name'] = this.name;
    data['Target'] = this.target;
    data['Technical'] = this.technical;
    data['Physical'] = this.physical;
    data['Psychology'] = this.psychology;
    data['Social'] = this.social;
    data['Tactical'] = this.tactical;
    data['Information'] = this.information;
    data['date'] = this.date;
    return data;
  }
}