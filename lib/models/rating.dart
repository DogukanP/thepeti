class Rating {
  int ratingId;
  int userId;
  double point;
  String comment;

  Rating({this.ratingId, this.userId, this.point, this.comment});

  Rating.fromJson(Map<String, dynamic> json) {
    ratingId = json['ratingId'];
    userId = json['userId'];
    point = json['point'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratingId'] = this.ratingId;
    data['userId'] = this.userId;
    data['point'] = this.point;
    data['comment'] = this.comment;
    return data;
  }
}
