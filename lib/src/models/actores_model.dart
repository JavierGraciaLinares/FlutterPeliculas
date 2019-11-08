class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item){
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    castId = json['cast_id'];
    gender = json['gender'];
    creditId = json['credit_id'];
    character = json['character'];
    profilePath = json['profile_path'];
  }

  getFotoActor() {
    if (profilePath == null) {
      return 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
  }
}
