class Films {
  List<Film> films = [];
  Films();

  Films.fromJSONList(List<dynamic> data) {
    if (data == null) {
      throw new Exception('no data received');
    } else {
      for (var value in data) {
        final film = new Film.fromJSONMap(value);
        films.add(film);
      }
    }
  }
}

class Film {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Film({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Film.fromJSONMap(Map<String, dynamic> data) {
    adult = data['adult'];
    backdropPath = data['backdrop_path'];
    genreIds = data['genre_ids'].cast<int>();
    id = data['id'];
    originalLanguage = data['original_language'];
    originalTitle = data['original_title'];
    overview = data['overview'];
    popularity = data['popularity'] / 1;
    posterPath = data['poster_path'];
    releaseDate = data['release_date'];
    title = data['title'];
    video = data['video'];
    voteAverage = data['vote_average'] / 1;
    voteCount = data['vote_count'];
  }

  String getPosterPath() {
    if (posterPath == null) {
      return 'https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  }

  String getBackdropPath() {
    if (backdropPath == null) {
      return 'https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }
  }
}
