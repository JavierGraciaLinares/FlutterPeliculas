// Generated by https://quicktype.io
class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {

  String uniqueIDHero;

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    adult = json['adult'];
    title = json['title'];
    overview = json['overview'];
    voteCount = json['vote_count'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'] / 1;
    originalTitle = json['original_title'];
    voteAverage = json['vote_average'] / 1;
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
  }

  getPostedImg() {
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59606710-d544-0136-1d6e-61fd63e82e44/e/0fa64ac0-0314-0137-cf43-1554cd16a871/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  }

 getBackgroundImg() {
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59606710-d544-0136-1d6e-61fd63e82e44/e/0fa64ac0-0314-0137-cf43-1554cd16a871/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }
  }

}
