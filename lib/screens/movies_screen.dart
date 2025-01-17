import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';

import '../constants/my_app_icons.dart';
import '../service/init_getit.dart';
import '../service/navigation_service.dart';
import '../widgets/movies/movies_widget.dart';
import 'favorites_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {
              // getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(MoviesWidget());
              getIt<NavigationService>().navigate(const FavoritesScreen());
            },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          Consumer(builder: (context, ref, child) {
            // final themeState = ref.watch(themeProvider);
            return IconButton(
              onPressed: () async {
                await ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(
                ref.watch(themeProvider) == ThemeEnums.dark ? MyAppIcons.lightMode : MyAppIcons.darkMode,
                // themeState == ThemeEnums.dark ? MyAppIcons.lightMode : MyAppIcons.darkMode,
              ),
            );
          }),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return MoviesWidget();
        },
      ),
    );
  }
}
