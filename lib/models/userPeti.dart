class UserPeti {
  int userPetiId;
  int userId;
  int petiId;

  UserPeti({this.userPetiId, this.userId, this.petiId});

  UserPeti.fromJson(Map<String, dynamic> json) {
    userPetiId = json['userPetiId'];
    userId = json['userId'];
    petiId = json['petiId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPetiId'] = this.userPetiId;
    data['userId'] = this.userId;
    data['petiId'] = this.petiId;
    return data;
  }
}
