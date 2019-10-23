class PhotosEntity {
	int total;
	PhotosSubject subject;
	int count;
	int start;
	List<PhotosPhoto> photos;

	PhotosEntity({this.total, this.subject, this.count, this.start, this.photos});

	PhotosEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		subject = json['subject'] != null ? new PhotosSubject.fromJson(json['subject']) : null;
		count = json['count'];
		start = json['start'];
		if (json['photos'] != null) {
			photos = new List<PhotosPhoto>();(json['photos'] as List).forEach((v) { photos.add(new PhotosPhoto.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		if (this.photos != null) {
      data['photos'] =  this.photos.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class PhotosSubject {
	PhotosSubjectImages images;
	String originalTitle;
	String year;
	List<PhotosSubjectDirector> directors;
	PhotosSubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<PhotosSubjectCast> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	PhotosSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	PhotosSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new PhotosSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<PhotosSubjectDirector>();(json['directors'] as List).forEach((v) { directors.add(new PhotosSubjectDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new PhotosSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates']?.cast<String>();
		if (json['casts'] != null) {
			casts = new List<PhotosSubjectCast>();(json['casts'] as List).forEach((v) { casts.add(new PhotosSubjectCast.fromJson(v)); });
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

class PhotosSubjectImages {
	String small;
	String large;
	String medium;

	PhotosSubjectImages({this.small, this.large, this.medium});

	PhotosSubjectImages.fromJson(Map<String, dynamic> json) {
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

class PhotosSubjectDirector {
	String name;
	String alt;
	String id;
	PhotosSubjectDirectorsAvatars avatars;
	String nameEn;

	PhotosSubjectDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	PhotosSubjectDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new PhotosSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
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

class PhotosSubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	PhotosSubjectDirectorsAvatars({this.small, this.large, this.medium});

	PhotosSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class PhotosSubjectRating {
//	double average;
	int min;
	int max;
//	PhotosSubjectRatingDetails details;
	String stars;

//	PhotosSubjectRating({this.average, this.min, this.max, this.details, this.stars});
	PhotosSubjectRating({ this.min, this.max,  this.stars});

	PhotosSubjectRating.fromJson(Map<String, dynamic> json) {
//		average = json['average'];
		min = json['min'];
		max = json['max'];
//		details = json['details'] != null ? new PhotosSubjectRatingDetails.fromJson(json['details']) : null;
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

//class PhotosSubjectRatingDetails {
//	double 1;
//	double 2;
//	double 3;
//	double 4;
//	double 5;
//
//	PhotosSubjectRatingDetails({this.1, this.2, this.3, this.4, this.5});
//
//	PhotosSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
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

class PhotosSubjectCast {
	String name;
	String alt;
	String id;
	PhotosSubjectCastsAvatars avatars;
	String nameEn;

	PhotosSubjectCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	PhotosSubjectCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new PhotosSubjectCastsAvatars.fromJson(json['avatars']) : null;
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

class PhotosSubjectCastsAvatars {
	String small;
	String large;
	String medium;

	PhotosSubjectCastsAvatars({this.small, this.large, this.medium});

	PhotosSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
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

class PhotosPhoto {
	String subjectId;
	String image;
	String nextPhoto;
	String thumb;
	PhotosPhotosAuthor author;
	String icon;
	String alt;
	String createdAt;
	int recsCount;
	String prevPhoto;
	String cover;
	int commentsCount;
	String albumId;
	String id;
	int position;
	String albumUrl;
	int photosCount;
	String albumTitle;
	String desc;

	PhotosPhoto({this.subjectId, this.image, this.nextPhoto, this.thumb, this.author, this.icon, this.alt, this.createdAt, this.recsCount, this.prevPhoto, this.cover, this.commentsCount, this.albumId, this.id, this.position, this.albumUrl, this.photosCount, this.albumTitle, this.desc});

	PhotosPhoto.fromJson(Map<String, dynamic> json) {
		subjectId = json['subject_id'];
		image = json['image'];
		nextPhoto = json['next_photo'];
		thumb = json['thumb'];
		author = json['author'] != null ? new PhotosPhotosAuthor.fromJson(json['author']) : null;
		icon = json['icon'];
		alt = json['alt'];
		createdAt = json['created_at'];
		recsCount = json['recs_count'];
		prevPhoto = json['prev_photo'];
		cover = json['cover'];
		commentsCount = json['comments_count'];
		albumId = json['album_id'];
		id = json['id'];
		position = json['position'];
		albumUrl = json['album_url'];
		photosCount = json['photos_count'];
		albumTitle = json['album_title'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['subject_id'] = this.subjectId;
		data['image'] = this.image;
		data['next_photo'] = this.nextPhoto;
		data['thumb'] = this.thumb;
		if (this.author != null) {
      data['author'] = this.author.toJson();
    }
		data['icon'] = this.icon;
		data['alt'] = this.alt;
		data['created_at'] = this.createdAt;
		data['recs_count'] = this.recsCount;
		data['prev_photo'] = this.prevPhoto;
		data['cover'] = this.cover;
		data['comments_count'] = this.commentsCount;
		data['album_id'] = this.albumId;
		data['id'] = this.id;
		data['position'] = this.position;
		data['album_url'] = this.albumUrl;
		data['photos_count'] = this.photosCount;
		data['album_title'] = this.albumTitle;
		data['desc'] = this.desc;
		return data;
	}
}

class PhotosPhotosAuthor {
	String uid;
	String signature;
	String alt;
	String name;
	String avatar;
	String id;

	PhotosPhotosAuthor({this.uid, this.signature, this.alt, this.name, this.avatar, this.id});

	PhotosPhotosAuthor.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		signature = json['signature'];
		alt = json['alt'];
		name = json['name'];
		avatar = json['avatar'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['signature'] = this.signature;
		data['alt'] = this.alt;
		data['name'] = this.name;
		data['avatar'] = this.avatar;
		data['id'] = this.id;
		return data;
	}
}
