import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_provider.dart';

import '../../constants/my_app_icons.dart';

class FavoriteBtnWidget extends ConsumerWidget {
  const FavoriteBtnWidget({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //don't do this, this reload method build
    // final favoritesState = ref.read(favoritesProvider);
    //do this instead
    final favoritesList = ref.watch(
      favoritesProvider.select(
        (state) => state.favoritesList,
      ),
    );
    final isFavorite = favoritesList.any((favoriteMovie) => favoriteMovie.id == movie.id);
    return IconButton(
      onPressed: () {
        ref.read(favoritesProvider.notifier).addOrRemoveFavorite(movie);
      },
      icon: Icon(
        isFavorite ? MyAppIcons.favoriteRounded : MyAppIcons.favoriteOutlineRounded,
        color: isFavorite ? Colors.red : null,
        size: 20,
      ),
    );
  }
}
