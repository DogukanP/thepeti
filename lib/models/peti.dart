class Peti {
  int petiId;
  String name;
  String genus;
  String createdDate;
  String imageURL;

  Peti({this.petiId, this.name, this.genus, this.createdDate, this.imageURL});

  Peti.fromJson(Map<String, dynamic> json) {
    petiId = json['petiId'];
    name = json['name'];
    genus = json['genus'];
    createdDate = json['createdDate'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petiId'] = this.petiId;
    data['name'] = this.name;
    data['genus'] = this.genus;
    data['createdDate'] = this.createdDate;
    data['imageURL'] = this.imageURL;
    return data;
  }
}
