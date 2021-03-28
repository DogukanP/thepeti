import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';

class PetiCardProfile extends StatefulWidget {
  final Peti peti;

  const PetiCardProfile({Key key, this.peti}) : super(key: key);
  @override
  _PetiCardProfileState createState() => _PetiCardProfileState();
}

class _PetiCardProfileState extends State<PetiCardProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.grey,
            backgroundImage: widget.peti.imageURL.isNotEmpty
                ? NetworkImage(widget.peti.imageURL)
                : AssetImage("assets/profile_photo.png"),
          ),
          SizedBox(
            width: 25.0,
          ),
          Column(
            children: [
              Text(
                widget.peti.name,
                style: text18,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(widget.peti.genus, style: text18),
            ],
          ),
        ],
      ),
    );
  }
}
