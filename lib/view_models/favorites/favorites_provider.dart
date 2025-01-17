import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesProvider = StateNotifierProvider<FavoritesProvider, FavoritesState>(
  (_) => FavoritesProvider(),
);

class FavoritesProvider extends StateNotifier<FavoritesState> {
  FavoritesProvider() : super(FavoritesState());

  bool isFavorite(MovieModel movieModel) {
    return state.favoritesList.any(
      (movie) => movie.id == movieModel.id,
    );
  }

  Future<void> addOrRemoveFavorite(MovieModel movieModel) async {
    bool wasFavorite = isFavorite(movieModel);
    List<MovieModel> updatedFavorites = wasFavorite
        ? state.favoritesList.where((element) => element.id != movieModel.id).toList()
        : [...state.favoritesList, movieModel];
    state = state.copyWith(favoritesList: updatedFavorites);
    // if (isFavorite(movieModel)) {
    //   state.favoritesList.removeWhere(
    //     (movie) => movie.id == movieModel.id,
    //   );
    // } else {
    //   state.favoritesList.add(movieModel);
    // }
    await saveFavorites();
  }

  Future<void> saveFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> stringList = state.favoritesList
        .map(
          (movie) => json.encode(
            movie.toJson(),
          ),
        )
        .toList();
    await prefs.setStringList(MyAppConstants.favoritesKey, stringList);
  }

  Future<void> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> stringList = prefs.getStringList(MyAppConstants.favoritesKey) ?? [];
    state.favoritesList.clear();
    state.favoritesList.addAll(
      stringList.map(
        (movie) => MovieModel.fromJson(
          json.decode(movie),
        ),
      ),
    );
  }

  void clearFavorites() async {
    state.favoritesList.clear();
    await saveFavorites();
  }
}
