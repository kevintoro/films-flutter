import 'package:flutter/material.dart';
import 'package:peliculas/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal({
    Key key,
    @required this.films,
    @required this.nextFilms,
  }) : super(key: key);

  final List<Film> films;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  /// esta función se ejecutará como callback en el constructor del Widget,
  /// el cual vamos a ejecutar cuando el pageController cumpla la función
  /// que se especifica en su listener
  final Function nextFilms;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 150) {
        nextFilms();
      }
    });

    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.28,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return _card(context, films[index]);
        },
        controller: _pageController,
        pageSnapping: false,
        itemCount: films.length,
      ),
    );
  }

  Widget _card(BuildContext context, Film film) {
    final card = Container(
      margin: EdgeInsets.only(
        right: 10.0,
      ),
      child: Column(
        children: [
          Hero(
            tag: film.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  film.getPosterPath(),
                ),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),
          Text(
            film.title,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: film);
      },
      child: card,
    );
  }
}
