import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EventDetailMain extends StatelessWidget {
  final String image;
  final bool isLike;
  final Function onBackPress, onLikePress;

  const EventDetailMain({
    Key key,
    this.image =
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    this.isLike = false,
    this.onBackPress,
    this.onLikePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 2,
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipPath(
            clipper: RoundedClipper(),
            child: Image.asset(
              this.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 25,
            left: 3,
            child: Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: FlatButton(
                splashColor: Colors.green.withOpacity(0.3),
                padding: EdgeInsets.all(10),
                onPressed: null,
                child: Icon(Icons.arrow_back, size: 25),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 25,
            child: Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    offset: Offset(1, 5),
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: FlatButton(
                padding: EdgeInsets.all(10),
                onPressed: null,
                child: SvgPicture.asset(
                  "assets/icons/heart.svg",
                  color:
                      this.isLike ? Colors.red : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, Get.height - 40);
    path.quadraticBezierTo(
        Get.width / 1.5, Get.height, Get.width, Get.height - 40);
    path.lineTo(Get.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}
