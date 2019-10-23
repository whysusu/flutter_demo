class WeeklyMovieEntityEntity {
	List<WeeklyMovieEntitySubject> subjects;
	String title;

	WeeklyMovieEntityEntity({this.subjects, this.title});

	WeeklyMovieEntityEntity.fromJson(Map<String, dynamic> json) {
		if (json['subjects'] != null) {
			subjects = new List<WeeklyMovieEntitySubject>();(json['subjects'] as List).forEach((v) { subjects.add(new WeeklyMovieEntitySubject.fromJson(v)); });
		}
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.subjects != null) {
      data['subjects'] =  this.subjects.map((v) => v.toJson()).toList();
    }
		data['title'] = this.title;
		return data;
	}
}

class WeeklyMovieEntitySubject {
	WeeklyMovieEntitySubjectsSubject subject;
	int delta;
	int rank;

	WeeklyMovieEntitySubject({this.subject, this.delta, this.rank});

	WeeklyMovieEntitySubject.fromJson(Map<String, dynamic> json) {
		subject = json['subject'] != null ? new WeeklyMovieEntitySubjectsSubject.fromJson(json['subject']) : null;
		delta = json['delta'];
		rank = json['rank'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['delta'] = this.delta;
		data['rank'] = this.rank;
		return data;
	}
}

class WeeklyMovieEntitySubjectsSubject {
	WeeklyMovieEntitySubjectsSubjectImages images;
	String originalTitle;
	String year;
	List<WeeklyMovieEntitySubjectsSubjectDirector> directors;
	WeeklyMovieEntitySubjectsSubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<WeeklyMovieEntitySubjectsSubjectCast> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	WeeklyMovieEntitySubjectsSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	WeeklyMovieEntitySubjectsSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new WeeklyMovieEntitySubjectsSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<WeeklyMovieEntitySubjectsSubjectDirector>();(json['directors'] as List).forEach((v) { directors.add(new WeeklyMovieEntitySubjectsSubjectDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new WeeklyMovieEntitySubjectsSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates']?.cast<String>();
		if (json['casts'] != null) {
			casts = new List<WeeklyMovieEntitySubjectsSubjectCast>();(json['casts'] as List).forEach((v) { casts.add(new WeeklyMovieEntitySubjectsSubjectCast.fromJson(v)); });
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
		data['durations'] = this.durations;
		data['mainland_pubdate'] = this.mainlandPubdate;
		data['id'] = this.id;
		return data;
	}
}

class WeeklyMovieEntitySubjectsSubjectImages {
	String small;
	String large;
	String medium;

	WeeklyMovieEntitySubjectsSubjectImages({this.small, this.large, this.medium});

	WeeklyMovieEntitySubjectsSubjectImages.fromJson(Map<String, dynamic> json) {
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

class WeeklyMovieEntitySubjectsSubjectDirector {
	String name;
	String alt;
	String id;
	WeeklyMovieEntitySubjectsSubjectDirectorsAvatars avatars;
	String nameEn;

	WeeklyMovieEntitySubjectsSubjectDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	WeeklyMovieEntitySubjectsSubjectDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new WeeklyMovieEntitySubjectsSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
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

class WeeklyMovieEntitySubjectsSubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	WeeklyMovieEntitySubjectsSubjectDirectorsAvatars({this.small, this.large, this.medium});

	WeeklyMovieEntitySubjectsSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class WeeklyMovieEntitySubjectsSubjectRating {
//	double average;
	int min;
	int max;
//	WeeklyMovieEntitySubjectsSubjectRatingDetails details;
	String stars;

//	WeeklyMovieEntitySubjectsSubjectRating({this.average, this.min, this.max, this.details, this.stars});
	WeeklyMovieEntitySubjectsSubjectRating({ this.min, this.max,  this.stars});

	WeeklyMovieEntitySubjectsSubjectRating.fromJson(Map<String, dynamic> json) {
//		average = json['average'];
		min = json['min'];
		max = json['max'];
//		details = json['details'] != null ? new WeeklyMovieEntitySubjectsSubjectRatingDetails.fromJson(json['details']) : null;
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

//class WeeklyMovieEntitySubjectsSubjectRatingDetails {
//	double 1;
//	double 2;
//	double 3;
//	double 4;
//	double 5;
//
//	WeeklyMovieEntitySubjectsSubjectRatingDetails({this.1, this.2, this.3, this.4, this.5});
//
//	WeeklyMovieEntitySubjectsSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
//		1 = json['1'];
//		2 = json['2'];
//		3 = json['3'];
//		4 = json['4'];
//		5 = json['5'];
//	}
//
//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['1'] = this.1;
//		data['2'] = this.2;
//		data['3'] = this.3;
//		data['4'] = this.4;
//		data['5'] = this.5;
//		return data;
//	}
//}

class WeeklyMovieEntitySubjectsSubjectCast {
	String name;
	String alt;
	String id;
	WeeklyMovieEntitySubjectsSubjectCastsAvatars avatars;
	String nameEn;

	WeeklyMovieEntitySubjectsSubjectCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	WeeklyMovieEntitySubjectsSubjectCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new WeeklyMovieEntitySubjectsSubjectCastsAvatars.fromJson(json['avatars']) : null;
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

class WeeklyMovieEntitySubjectsSubjectCastsAvatars {
	String small;
	String large;
	String medium;

	WeeklyMovieEntitySubjectsSubjectCastsAvatars({this.small, this.large, this.medium});

	WeeklyMovieEntitySubjectsSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
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
