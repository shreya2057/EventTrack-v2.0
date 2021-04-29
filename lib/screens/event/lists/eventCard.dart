import 'package:flutter/material.dart';

import '../../../components/bookmark_button.dart';
import '../../../model/event.dart';

class EventCard extends StatelessWidget {
  final EventModel recent;
  final Function onPress;
  final Function onSaved;
  final bool isSaved;

  const EventCard({
    Key key,
    @required this.recent,
    @required this.onPress,
    this.onSaved,
    this.isSaved = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.18),
              blurRadius: 8,
              offset: Offset(0, 1),
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            ImageCard(
              imageSource: recent.eventCoverUrl,
            ),
            BookmarkButton(
              active: this.isSaved,
              onPress: this.onSaved,
              top: 5,
              right: 5,
            ),
            ContentCard(
              title: recent.title,
              location: 'Location',
              description: recent.description,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Content List
class ContentCard extends StatelessWidget {
  const ContentCard({
    Key key,
    @required this.title,
    @required this.location,
    @required this.description,
  }) : super(key: key);

  final String title, location, description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.8,
      height: 100,
      margin: EdgeInsets.only(left: 110, top: 10),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: size.width * 0.035,
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 13,
                color: Colors.green,
              ),
              SizedBox(width: 5),
              Text(
                this.location,
                style: TextStyle(
                  fontSize: size.width * 0.03,
                ),
              ),
            ],
          ),
          Text(
            this.description,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.03,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

// Widget Image List
class ImageCard extends StatelessWidget {
  final String imageSource;
  const ImageCard({
    Key key,
    @required this.imageSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 120,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Image.asset(
        this.imageSource,
        fit: BoxFit.cover,
      ),
    );
  }
}
