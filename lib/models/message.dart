class Message {
  int messageId;
  int senderId;
  int receiverId;
  String sendDate;
  String content;

  Message(
      {this.messageId,
      this.senderId,
      this.receiverId,
      this.sendDate,
      this.content});

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    sendDate = json['sendDate'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['sendDate'] = this.sendDate;
    data['content'] = this.content;
    return data;
  }
}
