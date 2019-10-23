class MovieEntity {
  int total;
  List<MovieSubject> subjects;
  int count;
  int start;
  String title;

  MovieEntity({this.total, this.subjects, this.count, this.start, this.title});


  MovieEntity.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['subjects'] != null) {
      subjects = new List<MovieSubject>();
      (json['subjects'] as List).forEach((v) {
        subjects.add(new MovieSubject.fromJson(v));
      });
    }
    count = json['count'];
    start = json['start'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.subjects != null) {
      data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['start'] = this.start;
    data['title'] = this.title;
    return data;
  }
}

class MovieSubject {
  MovieSubjectsImages images;
  String originalTitle;
  String year;
  List<MovieSubjectsDirector> directors;
  MovieSubjectsRating rating;
  String alt;
  String title;
  int collectCount;
  bool hasVideo;
  List<String> pubdates;
  List<MovieSubjectsCast> casts;
  String subtype;
  List<String> genres;
  List<String> durations;
  String mainlandPubdate;
  String id;

  MovieSubject(
      {this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

  MovieSubject.fromJson(Map<String, dynamic> json) {
    images = json['images'] != null
        ? new MovieSubjectsImages.fromJson(json['images'])
        : null;
    originalTitle = json['original_title'];
    year = json['year'];
    if (json['directors'] != null) {
      directors = new List<MovieSubjectsDirector>();
      (json['directors'] as List).forEach((v) {
        directors.add(new MovieSubjectsDirector.fromJson(v));
      });
    }
    rating = json['rating'] != null
        ? new MovieSubjectsRating.fromJson(json['rating'])
        : null;
    alt = json['alt'];
    title = json['title'];
    collectCount = json['collect_count'];
    hasVideo = json['has_video'];
    pubdates = json['pubdates']?.cast<String>();
    if (json['casts'] != null) {
      casts = new List<MovieSubjectsCast>();
      (json['casts'] as List).forEach((v) {
        casts.add(new MovieSubjectsCast.fromJson(v));
      });
    }
    subtype = json['subtype'];
    genres = json['genres']?.cast<String>();
    durations = json['durations']?.cast<String>();
    mainlandPubdate = json['mainland_pubdate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    data['original_title'] = this.originalTitle;
    data['year'] = this.year;
    if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['alt'] = this.alt;
    data['title'] = this.title;
    data['collect_count'] = this.collectCount;
    data['has_video'] = this.hasVideo;
    data['pubdates'] = this.pubdates;
    if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
    data['subtype'] = this.subtype;
    data['genres'] = this.genres;
    data['durations'] = this.durations;
    data['mainland_pubdate'] = this.mainlandPubdate;
    data['id'] = this.id;
    return data;
  }
}

class MovieSubjectsImages {
  String small;
  String large;
  String medium;

  MovieSubjectsImages({this.small, this.large, this.medium});

  MovieSubjectsImages.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class MovieSubjectsDirector {
  String name;
  String alt;
  String id;
  MovieSubjectsDirectorsAvatars avatars;
  String nameEn;

  MovieSubjectsDirector(
      {this.name, this.alt, this.id, this.avatars, this.nameEn});

  MovieSubjectsDirector.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alt = json['alt'];
    id = json['id'];
    avatars =
    json['avatars'] != null ? new MovieSubjectsDirectorsAvatars.fromJson(
        json['avatars']) : null;
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['id'] = this.id;
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name_en'] = this.nameEn;
    return data;
  }
}

class MovieSubjectsDirectorsAvatars {
  String small;
  String large;
  String medium;

  MovieSubjectsDirectorsAvatars({this.small, this.large, this.medium});

  MovieSubjectsDirectorsAvatars.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class MovieSubjectsRating {
//  double average;
  int min;
  int max;

//	MovieSubjectsRatingDetails details;
  String stars;

//	MovieSubjectsRating({this.average, this.min, this.max, this.details, this.stars});
  MovieSubjectsRating({ this.min, this.max, this.stars});

  MovieSubjectsRating.fromJson(Map<String, dynamic> json) {
//    average =  json['average'];
    min = json['min'];
    max = json['max'];
//		details = json['details'] != null ? new MovieSubjectsRatingDetails.fromJson(json['details']) : null;
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['average'] = this.average;
    data['min'] = this.min;
    data['max'] = this.max;
    data['stars'] = this.stars;
    return data;
  }
}


class MovieSubjectsCast {
  String name;
  String alt;
  String id;
  MovieSubjectsCastsAvatars avatars;
  String nameEn;

  MovieSubjectsCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

  MovieSubjectsCast.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alt = json['alt'];
    id = json['id'];
    avatars = json['avatars'] != null ? new MovieSubjectsCastsAvatars.fromJson(
        json['avatars']) : null;
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['id'] = this.id;
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name_en'] = this.nameEn;
    return data;
  }
}

class MovieSubjectsCastsAvatars {
  String small;
  String large;
  String medium;

  MovieSubjectsCastsAvatars({this.small, this.large, this.medium});

  MovieSubjectsCastsAvatars.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}
