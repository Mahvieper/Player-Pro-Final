class UserModels {
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
  String weekPoints;

  UserModels(
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
        this.adminDetails,
        this.weekPoints});

  UserModels.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
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
    data['weekPoints'] = this.weekPoints;
    return data;
  }
}