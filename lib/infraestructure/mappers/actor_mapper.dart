import 'package:cinemapedia/domain/entities/actor.dart';

import '../models/creadits_response.dart';

class ActorMapper {
  ActorMapper._();
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null
      ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
      : 'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
    character: cast.character
  );
}