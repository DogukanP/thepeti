import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';

class SearchKeeper2 extends StatefulWidget {
  final String city, petiId;
  final DateTime requestDate;

  const SearchKeeper2({Key key, this.city, this.petiId, this.requestDate})
      : super(key: key);
  @override
  _SearchKeeper2State createState() => _SearchKeeper2State();
}

class _SearchKeeper2State extends State<SearchKeeper2> {
  List<Petting> pettingList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          formatter.format(widget.requestDate).toString(),
          style: textBlackC,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
          // children: [
          //   Text(
          //     pettinglist[1].city.toString(),
          //   ),
          // ],
          ),
    );
  }
}
