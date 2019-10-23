class NewMovieEntityEntity {
	int total;
	List<NewMovieEntitySubject> subjects;
	int count;
	int start;
	String title;

	NewMovieEntityEntity({this.total, this.subjects, this.count, this.start, this.title});

	NewMovieEntityEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['subjects'] != null) {
			subjects = new List<NewMovieEntitySubject>();(json['subjects'] as List).forEach((v) { subjects.add(new NewMovieEntitySubject.fromJson(v)); });
		}
		count = json['count'];
		start = json['start'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.subjects != null) {
      data['subjects'] =  this.subjects.map((v) => v.toJson()).toList();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		data['title'] = this.title;
		return data;
	}
}

class NewMovieEntitySubject {
	NewMovieEntitySubjectsImages images;
	String originalTitle;
	String year;
	List<NewMovieEntitySubjectsDirector> directors;
	NewMovieEntitySubjectsRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<NewMovieEntitySubjectsCast> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	NewMovieEntitySubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	NewMovieEntitySubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new NewMovieEntitySubjectsImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<NewMovieEntitySubjectsDirector>();(json['directors'] as List).forEach((v) { directors.add(new NewMovieEntitySubjectsDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new NewMovieEntitySubjectsRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates']?.cast<String>();
		if (json['casts'] != null) {
			casts = new List<NewMovieEntitySubjectsCast>();(json['casts'] as List).forEach((v) { casts.add(new NewMovieEntitySubjectsCast.fromJson(v)); });
		}
		subtype = json['subtype'];
		genres = json['genres']?.cast<String>();
		if (json['durations'] != null) {
			durations = new List<String>();
		}
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
      data['directors'] =  this.directors.map((v) => v.toJson()).toList();
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
      data['casts'] =  this.casts.map((v) => v.toJson()).toList();
    }
		data['subtype'] = this.subtype;
		data['genres'] = this.genres;
		if (this.durations != null) {
      data['durations'] =  [];
    }
		data['mainland_pubdate'] = this.mainlandPubdate;
		data['id'] = this.id;
		return data;
	}
}

class NewMovieEntitySubjectsImages {
	String small;
	String large;
	String medium;

	NewMovieEntitySubjectsImages({this.small, this.large, this.medium});

	NewMovieEntitySubjectsImages.fromJson(Map<String, dynamic> json) {
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

class NewMovieEntitySubjectsDirector {
	String name;
	String alt;
	String id;
	NewMovieEntitySubjectsDirectorsAvatars avatars;
	String nameEn;

	NewMovieEntitySubjectsDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	NewMovieEntitySubjectsDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new NewMovieEntitySubjectsDirectorsAvatars.fromJson(json['avatars']) : null;
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

class NewMovieEntitySubjectsDirectorsAvatars {
	String small;
	String large;
	String medium;

	NewMovieEntitySubjectsDirectorsAvatars({this.small, this.large, this.medium});

	NewMovieEntitySubjectsDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class NewMovieEntitySubjectsRating {
//	int average;
	int min;
	int max;
//	NewMovieEntitySubjectsRatingDetails details;
	String stars;

//	NewMovieEntitySubjectsRating({this.average, this.min, this.max, this.details, this.stars});
	NewMovieEntitySubjectsRating({ this.min, this.max,  this.stars});

	NewMovieEntitySubjectsRating.fromJson(Map<String, dynamic> json) {
//		average = json['average'];
		min = json['min'];
		max = json['max'];
//		details = json['details'] != null ? new NewMovieEntitySubjectsRatingDetails.fromJson(json['details']) : null;
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['average'] = this.average;
		data['min'] = this.min;
		data['max'] = this.max;
//		if (this.details != null) {
//      data['details'] = this.details.toJson();
//    }
		data['stars'] = this.stars;
		return data;
	}
}



class NewMovieEntitySubjectsCast {
	String name;
	String alt;
	String id;
	NewMovieEntitySubjectsCastsAvatars avatars;
	String nameEn;

	NewMovieEntitySubjectsCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	NewMovieEntitySubjectsCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new NewMovieEntitySubjectsCastsAvatars.fromJson(json['avatars']) : null;
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

class NewMovieEntitySubjectsCastsAvatars {
	String small;
	String large;
	String medium;

	NewMovieEntitySubjectsCastsAvatars({this.small, this.large, this.medium});

	NewMovieEntitySubjectsCastsAvatars.fromJson(Map<String, dynamic> json) {
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
