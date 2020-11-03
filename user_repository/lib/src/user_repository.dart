import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:user_repository/fetchPlayersModel.dart';
import 'package:user_repository/IndividualPlayersModel.dart';
import 'package:user_repository/user_repository.dart';

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

 Future<String> forgetPasssword(String email) async {
    var url = "https://akyproplayer.herokuapp.com/forgetpassword/";


    Map data = {
      "email":email,
    };
    //encode Map to JSON
    print(data);
    var body = json.encode(data);
    var response = await http.put(url,
      headers: {"Content-Type" : "application/json"},
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

  Future<String> updatePassword(String oldPass,String newPass,String token) async {
    var url = "https://akyproplayer.herokuapp.com/updatepassword/";

    Map data = {
      "old_password":oldPass,
      "new_password" : newPass
    };
    //encode Map to JSON
    print(data);
    var body = json.encode(data);
    var response = await http.put(url,
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
    for(PlayerPoints user in users) {
      if(user.fields.points == null || user.fields.points.isEmpty) {
        user.fields.points = "0";
      }
    }
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

  Future<List<IndividualLearningModel>> getIndiPlanForPlayer(String token,String playerId) async {
    var url = 'https://akyproplayer.herokuapp.com/individual/' + playerId + '/';
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
    List<IndividualLearningModel> indiLearn = new List<IndividualLearningModel>();

    for(Map i in parsed){
      indiLearn.add(IndividualLearningModel.fromJson(i));
    }

    return indiLearn;
  }

  Future<List<FetchPlayersModel>> fetchPlayersUnderAdmin(String token,String adminId) async {
    var url = 'https://akyproplayer.herokuapp.com/playerunderadmin/'+ adminId + '/';
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
    List<FetchPlayersModel> fetchedPlayesList = new List<FetchPlayersModel>();

    for(Map i in parsed){
      fetchedPlayesList.add(FetchPlayersModel.fromJson(i));
    }

    return fetchedPlayesList;
  }

  Future<UserModel> updateUser(String token,String playerId,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/user/' + playerId + '/';
    print("Token Header " + token);

    var response = await http.patch(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
      body : body,
    );


    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    UserModel user = UserModel.fromJson(parsed);

    return user;
  }

  Future<VideoModel> postPracticeVideo(String token,String playerId,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/assignment/';
    print("Token Header " + token);

    var response = await http.post(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
      body : body,
    );


    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    VideoModel video = VideoModel.fromJson(parsed);

    return video;
  }

  Future<ShoppingItemModel> postGoodies(String token,String playerId,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/goodies/';
    print("Token Header " + token);

    var response = await http.post(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
      body : body,
    );


    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    ShoppingItemModel goodie = ShoppingItemModel.fromJson(parsed);

    return goodie;
  }

  Future<UserModel> createUser(String token,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/create/';
    print("Token Header " + token);

    var response = await http.post(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
      body : body,
    );


    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    UserModel user = UserModel.fromJson(parsed);

    return user;
  }


  Future<UserModel> assignPointsToUser(String token,String playerId,String pointsAssigned) async {
    var url = 'https://akyproplayer.herokuapp.com/user/' + playerId + '/';
    print("Token Header " + token);

    Map data = {
      "points":pointsAssigned
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.patch(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
       body : body,
    );


    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    UserModel user = UserModel.fromJson(parsed);

    return user;
  }

  Future<List<VideoModel>> getVideos(String token) async {
    var url = 'https://akyproplayer.herokuapp.com/assignment/';
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
    List<VideoModel> videosList = new List<VideoModel>();

    for(Map i in parsed){
      videosList.add(VideoModel.fromJson(i));
    }

    return videosList;
  }


  Future<List<ShoppingItemModel>> getShoppingItems(String token) async {
    var url = 'https://akyproplayer.herokuapp.com/goodies/';
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
    List<ShoppingItemModel> shoppingItemsList = new List<ShoppingItemModel>();

    for(Map i in parsed){
      shoppingItemsList.add(ShoppingItemModel.fromJson(i));
    }

    return shoppingItemsList;
  }



  Future<List<PurchasedModel>> getGoodiesRequests(String token) async {
    var url = 'https://akyproplayer.herokuapp.com/redeem/';
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
    List<PurchasedModel> shoppingItemsList = new List<PurchasedModel>();

    for(Map i in parsed){
      shoppingItemsList.add(PurchasedModel.fromJson(i));
    }

    return shoppingItemsList;
  }


  Future<PurchasedModel> updateGoodiesRequest(String token,String requestId,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/redeem/' + requestId + '/';
    print("Token Header " + token);
    var response = await http.put(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
      body: body
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    PurchasedModel shoppingItem = new PurchasedModel.fromJson(parsed);

    return shoppingItem;
  }

  Future<PurchasedModel> makePurchase(String token,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/redeem/';
    print("Token Header " + token);
    var response = await http.post(url,
      headers: {"Authorization" : "Token "+token,
        "Content-Type": "application/json"},
        body :body
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    PurchasedModel purchasedItem = PurchasedModel.fromJson(parsed);

    return purchasedItem;
  }

  Future<IndividualLearningModel> postIndiPlanForPlayer(String token,String playerId,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/individual/';
    print("Token Header " + token);
    var response = await http.post(url,
        headers: {"Authorization" : "Token "+token,
          "Content-Type": "application/json"},
        body :body
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    IndividualLearningModel individualLearningModel = IndividualLearningModel.fromJson(parsed);

    return individualLearningModel;
  }

  Future<IndividualLearningModel> putIndiPlanForPlayer(String token,String playerId,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/individual/' + playerId + '/';
    print("Token Header " + token);
    var response = await http.put(url,
        headers: {"Authorization" : "Token "+token,
          "Content-Type": "application/json"},
        body :body
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    IndividualLearningModel individualLearningModel =
    //IndividualLearningModel.fromJson(parsed);

    new IndividualLearningModel(model: "individualLearning.individuallearning",
    pk:parsed['id']);
    individualLearningModel.pk = parsed['id'];
    individualLearningModel.model = "individualLearning.individuallearning";
    individualLearningModel.fields.target = parsed['Target'];
    individualLearningModel.fields.technical = parsed['Technical'];
    individualLearningModel.fields.physical = parsed['Physical'];
    individualLearningModel.fields.psychology = parsed['Psychology'];
    individualLearningModel.fields.social = parsed['Social'];
    individualLearningModel.fields.tactical = parsed['Tactical'];
    individualLearningModel.fields.information = parsed['Information'];
    individualLearningModel.fields.playerId =parsed['playerId'];
    individualLearningModel.fields.name =parsed['Name'];
    individualLearningModel.fields.date =parsed['date'];
    individualLearningModel.fields.id =parsed['id'];

    return individualLearningModel;
  }


  Future<AllotModel> postAllotmentToPlayer(String token,String playerId,var body) async {
    var url = 'https://akyproplayer.herokuapp.com/allot/';
    print("Token Header " + token);
    var response = await http.post(url,
        headers: {"Authorization" : "Token "+token,
          "Content-Type": "application/json"},
        body :body
    );
    print("${response.statusCode}");
    print("${response.body}");

    if(response.statusCode != 201) {
      throw Exception();
    }

    final parsed = json.decode(response.body);
    AllotModel allotment = AllotModel.fromJson(parsed);

    return allotment;
  }


  //----------------------SuperAdmin API Calls-------------------------
  Future<List<UserModel>> getAllUsers(String token) async {
    var url = 'https://akyproplayer.herokuapp.com/users/';
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
    List<UserModel> allUsersList = new List<UserModel>();

    for(Map i in parsed){
      if(UserModel.fromJson(i).role.contains("Super"))
        continue;
      allUsersList.add(UserModel.fromJson(i));
    }

    return allUsersList;
  }


  Future<List<FetchPlayersModel>> getAllUsersUnderSuperAdmin(String token) async {
    var url = 'https://akyproplayer.herokuapp.com/users/';
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
    List<FetchPlayersModel> allUsersList = new List<FetchPlayersModel>();

    for(Map i in parsed){
      if(UserModel.fromJson(i).role.contains("Super"))
        continue;
      allUsersList.add(FetchPlayersModel.fromJson(i));
    }

    return allUsersList;
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
  String videoId;
  String password;
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
  String dateComplete;
  String weekPoints;
  bool isComplete;
  UserModel(
      {this.email,
        this.id,
        this.videoId,
        this.password,
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
        this.adminDetails,
        this.weekPoints,
      this.isComplete,
      this.dateComplete});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    videoId = json['videoId'];
    name = json['name'];
    role = json['role'];
    superAdminName = json['superAdminName'];
    adminName = json['AdminName'];
    points = json['points'];
    userActive = json['userActive'];
    superAdminDeviceRegId = json['superAdminDeviceRegId'];
    adminDeviceRegId = json['adminDeviceRegId'];
    userDeviceRegId = json['userDeviceRegId'];
    superAdminId = json['super_admin_id'];
    adminId = json['admin_id'];
    image = json['image'];
    videoUrl = json['videoUrl'];
    designation = json['designation'];
    level = json['level'];
    experience = json['experience'];
    adminDetails = json['adminDetails'];
    weekPoints = json['weekPoints'];
    isComplete = json['isComplete'];
    dateComplete = json['dateComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['password'] = this.password;
    data['superAdminName'] = this.superAdminName;
    data['AdminName'] = this.adminName;
    data['points'] = this.points;
    data['userActive'] = this.userActive;
    data['superAdminDeviceRegId'] = this.superAdminDeviceRegId;
    data['adminDeviceRegId'] = this.adminDeviceRegId;
    data['videoId'] = this.videoId;
    data['dateComplete'] = this.dateComplete;
    data['userDeviceRegId'] = this.userDeviceRegId;
    data['super_admin_id'] = this.superAdminId;
    data['admin_id'] = this.adminId;
    data['image'] = this.image;
    data['videoUrl'] = this.videoUrl;
    data['designation'] = this.designation;
    data['level'] = this.level;
    data['experience'] = this.experience;
    data['adminDetails'] = this.adminDetails;
    data['weekPoints'] = this.weekPoints;
    data['isComplete'] = this.isComplete;
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



/*class IndividualLearningModel {
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
        this.date}) {
    this.target  = "";
    this.technical = "";
    this.social = "";
    this.physical = "";
    this.psychology ="";
    this.information  ="";
    this.tactical ="";
    this.date = "";
  }

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
}*/

class VideoModel {
  int id;
  String name;
  String description;
  bool isActive;
  String videoLink;

  VideoModel(
      {this.id, this.name, this.description, this.isActive, this.videoLink});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
    isActive = json['isActive'];
    videoLink = json['videoLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['isActive'] = this.isActive;
    data['videoLink'] = this.videoLink;
    return data;
  }
}


class ShoppingItemModel {
  int id;
  String name;
  String description;
  int pointsRequired;
  bool isActive;
  String image;

  ShoppingItemModel(
      {this.id,
        this.name,
        this.description,
        this.pointsRequired,
        this.isActive,
        this.image});

  ShoppingItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
    pointsRequired = json['PointsRequired'];
    isActive = json['isActive'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['PointsRequired'] = this.pointsRequired;
    data['isActive'] = this.isActive;
    data['image'] = this.image;
    return data;
  }
}

class PurchasedModel {
  int id;
  String userName;
  String userId;
  String points;
  String goodiesName;
  String goodiesId;
  String dateRaised;
  String status;
  PurchasedModel(
      {this.id,
        this.userName,
        this.userId,
        this.points,
        this.goodiesName,
        this.goodiesId,
        this.dateRaised,
      this.status});

  PurchasedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userId = json['userId'];
    points = json['points'];
    goodiesName = json['goodiesName'];
    goodiesId = json['goodiesId'];
    dateRaised = json['dateRaised'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['userId'] = this.userId;
    data['points'] = this.points;
    data['goodiesName'] = this.goodiesName;
    data['goodiesId'] = this.goodiesId;
    data['dateRaised'] = this.dateRaised;
    data['status'] = this.status;
    return data;
  }
}

class AllotModel {
  String assigName;
  String assigId;
  String playerName;
  String playerId;
  String assignByName;
  String assignById;
  String assignLink;
  bool assignStatus;
  Null dateComplete;

  AllotModel(
      {this.assigName,
        this.assigId,
        this.playerName,
        this.playerId,
        this.assignByName,
        this.assignById,
        this.assignLink,
        this.assignStatus,
        this.dateComplete});

  AllotModel.fromJson(Map<String, dynamic> json) {
    assigName = json['assigName'];
    assigId = json['assigId'];
    playerName = json['playerName'];
    playerId = json['playerId'];
    assignByName = json['assignByName'];
    assignById = json['assignById'];
    assignLink = json['assignLink'];
    assignStatus = json['assignStatus'];
    dateComplete = json['dateComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assigName'] = this.assigName;
    data['assigId'] = this.assigId;
    data['playerName'] = this.playerName;
    data['playerId'] = this.playerId;
    data['assignByName'] = this.assignByName;
    data['assignById'] = this.assignById;
    data['assignLink'] = this.assignLink;
    data['assignStatus'] = this.assignStatus;
    data['dateComplete'] = this.dateComplete;
    return data;
  }
}