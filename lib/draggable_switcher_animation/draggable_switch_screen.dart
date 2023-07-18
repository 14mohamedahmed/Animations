import 'package:animations/draggable_switcher_animation/draggable_switch_component.dart';
import 'package:flutter/material.dart';

class DraggableSwitchScreen extends StatelessWidget {
  const DraggableSwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DraggableSwitchComponent(ballSize: 50, componentWidth: 200),
          ],
        ),
      ),
    );
  }
}
