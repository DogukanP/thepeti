import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';

class PettingRequestCard extends StatefulWidget {
  @override
  _PettingRequestCardState createState() => _PettingRequestCardState();
}

class _PettingRequestCardState extends State<PettingRequestCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(-3, 1),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
