import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';

class PetiCard extends StatefulWidget {
  final Peti peti;

  const PetiCard({Key key, this.peti}) : super(key: key);

  @override
  _PetiCardState createState() => _PetiCardState();
}

class _PetiCardState extends State<PetiCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.grey,
            backgroundImage: widget.peti.imageURL.isNotEmpty
                ? NetworkImage(widget.peti.imageURL)
                : AssetImage("assets/profile_photo.png"),
          ),
          SizedBox(
            width: 15.0,
          ),
          Column(
            children: [
              Text(
                widget.peti.name,
                style: text18,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(widget.peti.genus, style: text18),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            iconSize: 32.0,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
