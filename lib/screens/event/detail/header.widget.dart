import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/event.dart';

class DetailScreen extends StatefulWidget {
  final EventModel eventModel;

  const DetailScreen({
    Key key,
    @required this.eventModel,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // HeaderDetail(
              //   image: "assets/images/detail.png",
              //   onBackPress: () {
              //     Navigator.pop(context);
              //   },
              //   onLikePress: () {
              //     widget.eventModel.isSaved = !widget.eventModel.isSaved;
              //     setState(() {});
              //   },
              //   isLike: widget.eventModel.isSaved,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetails extends StatefulWidget {
  final String title, location, description;
  final Function onPress;

  const EventDetails({
    Key key,
    this.title,
    this.location,
    this.description,
    this.onPress,
  }) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final EventModel passedeventModel = Get.arguments;

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            passedeventModel.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.06,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 13,
                  color: Colors.green,
                ),
                SizedBox(width: 5),
                Text(
                  'hdgytgtyfdftyd',
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Text(
            passedeventModel.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.05,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'h',
            style: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.black.withOpacity(0.6),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
