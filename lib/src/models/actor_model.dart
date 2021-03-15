class Cast {
  List<Actor> actors = [];

  Cast.fromJsonList(List<dynamic> data) {
    if (data == null) {
      throw new Exception('no data received');
    } else {
      data.forEach((element) {
        final actor = new Actor.fromJSONMap(element);
        actors.add(actor);
      });
    }
  }
}

class Actor {
  int gender;
  int id;
  String name;
  String originalName;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actor({
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actor.fromJSONMap(Map<String, dynamic> data) {
    gender = data['gender'];
    id = data['id'];
    name = data['name'];
    originalName = data['original_name'];
    profilePath = data['profile_path'];
    castId = data['cast_id'];
    character = data['character'];
    creditId = data['credit_id'];
    order = data['order'];
    job = data['job'];
  }

  String getProfilePath() {
    if (profilePath == null) {
      return 'https://www.intra-tp.com/wp-content/uploads/2017/02/no-avatar.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
  }
}
