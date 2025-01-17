import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_provider.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

final initializationProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  await Future.microtask(() async {
    await ref.read(moviesProvider.notifier).getMovies();
    await ref.read(favoritesProvider.notifier).loadFavorites();
  });
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(initializationProvider);
    return Scaffold(
      body: initWatch.when(
        data: (_) {
          //fix error :Fix the setState() or markNeedsBuild() called during build
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              getIt<NavigationService>().navigateReplace(
                const MoviesScreen(),
              );
            },
          );

          return const SizedBox.shrink();
        },
        error: (error, stackTracec) => MyErrorWidget(
          errorText: error.toString(),
          retryFunction: () async => ref.refresh(initializationProvider),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}


//using the future builder with riverpod
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mvvm_statemanagements/screens/movies_screen.dart';
// import 'package:mvvm_statemanagements/service/init_getit.dart';
// import 'package:mvvm_statemanagements/service/navigation_service.dart';
// import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';
// import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

// class SplashScreen extends ConsumerWidget {
//   const SplashScreen({super.key});

//   Future<void> _loadInitialData(WidgetRef ref) async {
//     await Future.microtask(() async {
//       await ref.read(moviesProvider.notifier).getMovies();
//     });
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final moviesState = ref.watch(moviesProvider);
//     return Scaffold(
//       body: FutureBuilder(
//         future: _loadInitialData(ref),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator.adaptive(),
//             );
//           } else if (snapshot.hasError) {
//             if (ref.watch(moviesProvider).genresList.isNotEmpty) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 getIt<NavigationService>().navigateReplace(
//                   const MoviesScreen(),
//                 );
//               });
//             }
//             return MyErrorWidget(
//               errorText: snapshot.error.toString(),
//               retryFunction: () async {
//                 await _loadInitialData(ref);
//               },
//             );
//           } else {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               getIt<NavigationService>().navigateReplace(
//                 const MoviesScreen(),
//               );
//             });
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
