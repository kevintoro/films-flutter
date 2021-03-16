import 'package:flutter/material.dart';
import 'package:peliculas/src/models/film_model.dart';
import 'package:peliculas/src/providers/film_provider.dart';

class DataSearch extends SearchDelegate {
  final filmProvider = new FilmProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones que aparecerán en el search box
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del search box
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que se mostrarán
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen cuando se escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: filmProvider.searchFilm(query),
        builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _createListTile(context, data[index]);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }

  Widget _createListTile(BuildContext context, Film film) {
    film.uniqueId = '${film.id}-list';
    return ListTile(
      leading: FadeInImage(
        fit: BoxFit.cover,
        image: NetworkImage(film.getPosterPath()),
        placeholder: AssetImage('assets/img/no-image.jpg'),
      ),
      title: Text(film.title),
      subtitle: Text(film.releaseDate),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: film);
      },
    );
  }
}
