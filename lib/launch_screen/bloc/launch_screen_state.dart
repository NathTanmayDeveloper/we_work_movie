import '../../utility/location/location.dart';

abstract class LaunchScreenState {}

class LaunchScreenInitialState extends LaunchScreenState {}

class LaunchScreenAfterTryingPositionState extends LaunchScreenState {
  final CustomLocationDetails locationDetails;

  LaunchScreenAfterTryingPositionState({required this.locationDetails});
}
