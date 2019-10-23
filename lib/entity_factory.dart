import 'package:flutter_demo/entity/movie_detail_entity.dart';
import 'package:flutter_demo/entity/movie_entity.dart';
import 'package:flutter_demo/entity/new_movie_entity_entity.dart';
import 'package:flutter_demo/entity/photos_entity.dart';
import 'package:flutter_demo/entity/weekly_movie_entity_entity.dart';
import 'package:flutter_demo/widget/menu_bean_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "MovieDetailEntity") {
      return MovieDetailEntity.fromJson(json) as T;
    } else if (T.toString() == "MovieEntity") {
      return MovieEntity.fromJson(json) as T;
    } else if (T.toString() == "NewMovieEntityEntity") {
      return NewMovieEntityEntity.fromJson(json) as T;
    } else if (T.toString() == "PhotosEntity") {
      return PhotosEntity.fromJson(json) as T;
    } else if (T.toString() == "WeeklyMovieEntityEntity") {
      return WeeklyMovieEntityEntity.fromJson(json) as T;
    } else if (T.toString() == "MenuBeanEntity") {
      return MenuBeanEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}