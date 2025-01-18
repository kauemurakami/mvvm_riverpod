import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/stream_provider/weather_repository.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(streamWeatherProvider);
    return Scaffold(
      body: initWatch.when(
        data: (data) {
          return Center(
            child: Text(
              data,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
            ),
          );
        },
        error: (error, stackTracec) => MyErrorWidget(
          errorText: error.toString(),
          retryFunction: () async => ref.refresh(streamWeatherProvider),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
