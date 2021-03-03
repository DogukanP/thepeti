class Petting {
  int pettingId;
  int userId;
  int price;
  DateTime pettingDate;
  String district;
  String city;
  String note;

  Petting(
      {this.pettingId,
      this.userId,
      this.price,
      this.pettingDate,
      this.district,
      this.city,
      this.note});

  // Petting.fromJson(Map<String, dynamic> json) {
  //   pettingId = json['pettingId'];
  //   userId = json['userId'];
  //   price = json['price'];
  //   pettingDate = json['pettingDate'];
  //   district = json['district'];
  //   city = json['city'];
  //   note = json['note'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['pettingId'] = this.pettingId;
  //   data['userId'] = this.userId;
  //   data['price'] = this.price;
  //   data['pettingDate'] = this.pettingDate;
  //   data['district'] = this.district;
  //   data['city'] = this.city;
  //   data['note'] = this.note;
  //   return data;
  // }
}
