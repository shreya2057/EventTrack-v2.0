import 'package:eventtrack/model/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eventCard.dart';

class PopularList extends StatefulWidget {
  final List<EventModel> listPopular;

  const PopularList({
    Key key,
    @required this.listPopular,
  }) : super(key: key);
  @override
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 45, 15, 1.0),
            child: Text(
              "EventList",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Get.width * 0.095,
              ),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.listPopular.length,
            itemBuilder: (context, index) => buildPopularCard(index),
          ),
        ],
      ),
    );
  }

  Widget buildPopularCard(int index) {
    return EventCard(
      recent: widget.listPopular[index], onPress: null,
      // () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return EventDetailMain(
      //           eventModel: widget.listPopular[index],
      //         );
      //       },
      //     ),
      //   );
      // },
    );
  }
}
