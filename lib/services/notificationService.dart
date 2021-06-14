import 'package:http/http.dart' as http;

import 'package:thepeti/models/message.dart';
import 'package:thepeti/models/user.dart';

class NotificationService {
  Future<bool> sendNotification(
      Message sendNotification, User sender, String token) async {
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAAgt1pPWw:APA91bEWjf5kLQ6-xwn5HEGioeEoWQDAQ3aaMASP7Lurb6GS3g7i-tSTuN9qBo33K2QpTTpkrJG9BbIDpLjD2jzsoakUCCOrvrGUW_1_CFSB9xSf79tBcIZTii95hlhXQs-p2PepDtE9";
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    String json =
        '{ "to" : "$token", "data" : { "message" : "${sendNotification.message}", "title": "${sender.firstName} yeni mesaj", "imageURL": "${sender.imageURL}", "senderId" : "${sender.userId}" } }';

    http.Response response =
        await http.post(endURL, headers: headers, body: json);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
