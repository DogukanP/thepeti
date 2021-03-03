class Complaint {
  int complaintId;
  int senderId;
  int receiverId;
  String content;
  String sendDate;

  Complaint(
      {this.complaintId,
      this.senderId,
      this.receiverId,
      this.content,
      this.sendDate});

  Complaint.fromJson(Map<String, dynamic> json) {
    complaintId = json['complaintId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    content = json['content'];
    sendDate = json['sendDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complaintId'] = this.complaintId;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['content'] = this.content;
    data['sendDate'] = this.sendDate;
    return data;
  }
}
