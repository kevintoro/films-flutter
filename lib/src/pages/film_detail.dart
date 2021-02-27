import 'package:flutter/material.dart';
import 'package:peliculas/src/models/film_model.dart';

class FilmDetail extends StatelessWidget {
  const FilmDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        // sliver es como children
        slivers: [
          _createAppBar(film),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              _posterTitle(film, context),
              _filmDescription(film),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(Film film) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      // que tan ancho quiero que sea la expansión
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          film.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(
            film.getBackdropPath(),
          ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }

  Widget _posterTitle(Film film, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              image: NetworkImage(film.getPosterPath()),
              height: 150,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  film.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      film.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _filmDescription(Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        film.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
