import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({
    Key key,
    @required this.films,
  }) : super(key: key);

  final List<dynamic> films;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemCount: 3,
        layout: SwiperLayout.STACK,
        itemWidth: 200.0,
        itemBuilder: (context, index) {
          return Image.network(
            'http://via.placeholder.com/350x150',
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
