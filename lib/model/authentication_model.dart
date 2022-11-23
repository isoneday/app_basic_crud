class AuthenticationModel {
  String? pesan;
  bool? sukses;
  UserData? userData;

  AuthenticationModel({this.pesan, this.sukses, this.userData});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    pesan = json['pesan'];
    sukses = json['sukses'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pesan'] = this.pesan;
    data['sukses'] = this.sukses;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? userId;
  String? userNama;
  String? userEmail;
  String? userHp;
  String? userPassword;
  String? userStatus;

  UserData(
      {this.userId,
      this.userNama,
      this.userEmail,
      this.userHp,
      this.userPassword,
      this.userStatus});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userNama = json['user_nama'];
    userEmail = json['user_email'];
    userHp = json['user_hp'];
    userPassword = json['user_password'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_nama'] = this.userNama;
    data['user_email'] = this.userEmail;
    data['user_hp'] = this.userHp;
    data['user_password'] = this.userPassword;
    data['user_status'] = this.userStatus;
    return data;
  }
}
