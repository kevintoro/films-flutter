import 'package:flutter/material.dart';
import 'package:peliculas/src/models/film_model.dart';
import 'package:peliculas/src/providers/film_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final filmProvider = new FilmProvider();

  @override
  Widget build(BuildContext context) {
    filmProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Cinema Films'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _swiperCards(),
          _topRated(context),
        ],
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: filmProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(films: snapshot.data);
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _topRated(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 5),
          StreamBuilder(
            builder: (context, AsyncSnapshot<List<Film>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  films: snapshot.data,
                  nextFilms: filmProvider.getPopular,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            stream: filmProvider.popularesStream,
          ),
        ],
      ),
    );
  }
}
