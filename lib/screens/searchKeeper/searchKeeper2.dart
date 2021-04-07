import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/searchCard.dart';

class SearchKeeper2 extends StatefulWidget {
  final String city;
  final Peti peti;
  final DateTime requestDate;

  const SearchKeeper2({Key key, this.city, this.peti, this.requestDate})
      : super(key: key);
  @override
  _SearchKeeper2State createState() => _SearchKeeper2State();
}

class _SearchKeeper2State extends State<SearchKeeper2> {
  List<Petting> pettingList = [];

  getData() async {
    List<Petting> pettings = await FireStoreService()
        .getPettingforSearch(widget.city, widget.requestDate);
    setState(() {
      pettingList = pettings;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          formatter.format(widget.requestDate).toString(),
          style: textBlackC,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Center(
          child: pettingList.length == 0
              ? Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Text(
                        "MAALESEF ARADIĞIN KRİTERLERDE BİR İLAN BULAMADIK.",
                        textAlign: TextAlign.center,
                        style: text50,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: pettingList.length,
                  itemBuilder: (context, index) {
                    Petting petting = pettingList[index];
                    return FutureBuilder(
                      future: FireStoreService().getUser(petting.userId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(40.0),
                          );
                        }
                        User user = snapshot.data;
                        return SearchCard(
                          petting: petting,
                          user: user,
                          peti: widget.peti,
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
