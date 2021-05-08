import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/rating.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/ratingCardProfile.dart';

class RatingScreen extends StatefulWidget {
  final User user;

  const RatingScreen({Key key, this.user}) : super(key: key);
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  List<Rating> ratingList = [];
  int rating = 0;

  Future<void> getRatings() async {
    List<Rating> ratings =
        await FireStoreService().getRatings(widget.user.userId);
    setState(() {
      ratingList = ratings;
    });
  }

  @override
  void initState() {
    super.initState();
    getRatings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DEĞERLENDİRMELER",
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ratingList.length == 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.report_problem_outlined,
                    size: 50.0,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "DAHA ÖNCE BU KULLANICI HAKKINDA HERHANGİ BİR DEĞERLENDİRME YAPILMAMIŞ ",
                    style: text23,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView(
              padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 40.0),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          (ratingList.map((e) => int.parse(e.rating)).reduce(
                                      (value, element) => value + element) /
                                  ratingList.length)
                              .toString(),
                          style: text50,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PUAN",
                          style: text50,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          "${ratingList.length} YORUM",
                          style: text23,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    Divider(
                      height: 50.0,
                      thickness: 3.4,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: ratingList.length,
                  itemBuilder: (context, index) {
                    Rating rating = ratingList[index];
                    return FutureBuilder(
                      future: FireStoreService().getUser(rating.senderId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            color: Colors.grey[100],
                            height: 0,
                          );
                        }
                        User user = snapshot.data;

                        return RatingCardProfile(
                          rating: rating,
                          user: user,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}
