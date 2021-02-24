import 'package:flutter/material.dart';
import 'package:peliculas/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal({
    Key key,
    @required this.films,
  }) : super(key: key);

  final List<Film> films;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.27,
      child: PageView(
        children: _cards(context),
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        pageSnapping: false,
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return films.map((e) {
      return Container(
        margin: EdgeInsets.only(
          right: 10.0,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  e.getPosterPath(),
                ),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            Text(
              e.title,
              style: Theme.of(context).textTheme.caption,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();
  }
}
