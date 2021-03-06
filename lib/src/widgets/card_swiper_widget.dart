import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/film_model.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({
    Key key,
    @required this.films,
  }) : super(key: key);

  final List<Film> films;

  @override
  Widget build(BuildContext context) {
    //Tamaño de la pantalla del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemCount: films.length,
        layout: SwiperLayout.STACK,
        itemBuilder: (context, index) {
          films[index].uniqueId = '${films[index].id}-swiper';
          return Hero(
            tag: films[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'details',
                    arguments: films[index],
                  );
                },
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(
                    films[index].getPosterPath(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
