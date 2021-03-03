class Request {
  int id;
  int pettingId;
  int petiId;
  String createdDate;
  String imageURL;

  Request(
      {this.id, this.pettingId, this.petiId, this.createdDate, this.imageURL});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pettingId = json['pettingId'];
    petiId = json['petiId'];
    createdDate = json['createdDate'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pettingId'] = this.pettingId;
    data['petiId'] = this.petiId;
    data['createdDate'] = this.createdDate;
    data['imageURL'] = this.imageURL;
    return data;
  }
}
