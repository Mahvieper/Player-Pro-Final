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
        this.adminDetails});

  UserModels.fromJson(Map<String, dynamic> json) {
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