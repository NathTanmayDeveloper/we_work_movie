import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: Stack(
                children: [
                  // Logo
                  Positioned.fill(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/wework_logo.png'),
                  )),
                  // Circular Progress Indicator
                  const Positioned.fill(
                    // Adjust this value to position the indicator correctly
                    child: CircularProgressWithDuration(
                      duration: Duration(seconds: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircularProgressWithDuration extends StatefulWidget {
  final Duration duration;
  const CircularProgressWithDuration({
    super.key,
    required this.duration,
  });

  @override
  State<CircularProgressWithDuration> createState() =>
      _CircularProgressWithDurationState();
}

class _CircularProgressWithDurationState
    extends State<CircularProgressWithDuration>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Start the animation
    _animationController
      ..forward()
      ..addListener(() {
        if (_animationController.isCompleted) {
          _animationController.repeat();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, _) {
        return RotatedBox(
          quarterTurns: 1,
          child: CircularProgressIndicator(
            color: Colors.black,
            // Calculate the progress based on the animation value
            value: _animationController.value,
          ),
        );
      },
    );
  }
}
