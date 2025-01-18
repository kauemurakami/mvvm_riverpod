import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';

import '../repository/movies_repo.dart';
import '../service/init_getit.dart';

class GenreUtils {
  static List<MoviesGenre> movieGenresNames(List<int> genreIds, WidgetRef ref) {
    final moviesRepository = getIt<MoviesRepository>();
    final movieState = ref.watch(moviesProvider);
    final cachedGenres = movieState.genresList; //TODO: We need to get the correct cachedGenres
    List<MoviesGenre> genresNames = [];
    for (var genreId in genreIds) {
      var genre = cachedGenres.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenre(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}
