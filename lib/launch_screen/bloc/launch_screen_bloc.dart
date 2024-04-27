import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utility/location/location.dart';
import 'launch_screen_event.dart';
import 'launch_screen_state.dart';

class LaunchScreenBloc extends Bloc<LaunchScreenEvent, LaunchScreenState> {
  LaunchScreenBloc() : super(LaunchScreenInitialState()) {
    on<LaunchScreenInitialEvent>(launchScreenInitialEvent);
  }

  FutureOr<void> launchScreenInitialEvent(
      LaunchScreenEvent event, Emitter<LaunchScreenState> emit) async {
    final locationDetails = await CustomLocation.getLocation();

    emit(
        LaunchScreenAfterTryingPositionState(locationDetails: locationDetails));
  }
}
