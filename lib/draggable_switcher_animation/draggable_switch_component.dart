import 'package:flutter/material.dart';

class DraggableSwitchComponent extends StatefulWidget {
  const DraggableSwitchComponent(
      {super.key, required this.ballSize, required this.componentWidth});
  final double ballSize;
  final double componentWidth;

  @override
  State<DraggableSwitchComponent> createState() =>
      _DraggableSwitchComponentState();
}

class _DraggableSwitchComponentState extends State<DraggableSwitchComponent> {
  late final double _ballSize = widget.ballSize;
  late final double componentWidth = widget.componentWidth;
  late double componentCenterPos = (componentWidth - _ballSize) / 2;
  late double _x = componentCenterPos;
  double opacity = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: _ballSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: componentWidth,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: _x != 0,
                    child: GestureDetector(
                      onTap: () {
                        _x = 0;
                        setState(() {});
                      },
                      child: const Text(
                        "Male",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _x != componentWidth - _ballSize,
                    child: GestureDetector(
                      onTap: () {
                        _x = componentWidth - _ballSize;
                        setState(() {});
                      },
                      child: const Text(
                        "Female",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: _x,
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  if (details.localPosition.dx > _x) {
                    _x = componentWidth - _ballSize;
                  } else if (details.localPosition.dx < _x) {
                    _x = 0;
                  }
                },
                onPanEnd: (details) => setState(() {}),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  width: _ballSize,
                  height: _ballSize,
                  alignment: Alignment.center,
                  child: Visibility(
                    visible: _x != componentCenterPos,
                    child:  AnimatedCrossFade(
                      crossFadeState: _x == 0
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: FittedBox(
                          child: Text(
                            "Male",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      secondChild: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: FittedBox(
                          child: Text(
                            "Female",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      duration: const Duration(milliseconds: 400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
