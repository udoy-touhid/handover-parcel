import 'package:flutter/material.dart';

class VerticalStepperView extends StatelessWidget {
  final circleSize = 5.0;
  final textSize = 10.0;

  static const stepHeight = 25.0;
  final stepWidth = 2.0;

  final selectedColor = Colors.black;
  final unselectedColor = Colors.white.withOpacity(.75);

  final int selectedIndex;

  final List<String> list;

  VerticalStepperView({super.key, required this.list, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // list.map((e) => itemOptions(e., length))
      for (int i = 0; i < list.length; i++) itemOptions(i, list.length)
    ]);
  }

  Widget itemOptions(int index, int length) {
    var isSelected = index <= selectedIndex;
    var color = isSelected ? selectedColor : unselectedColor;
    var invertedColor = !isSelected ? selectedColor : unselectedColor;
    var invisibleColor = Colors.transparent;
    var isFirstItem = index == 0;
    var isLastItem = index == length - 1;
    var isPrevItemSelected = index == selectedIndex;
    return Positioned(
      left: 10,
      top: index * stepHeight,
      child: Container(
        height: stepHeight,
        padding: const EdgeInsets.only(left: 20),
        child: Stack(
          children: [
            //line half, before circle
            Container(
                margin: EdgeInsets.only(
                  left: (circleSize - stepWidth) / 2,
                ),
                height: stepHeight / 2,
                width: stepWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    shape: BoxShape.rectangle,
                    color: isFirstItem ? invisibleColor : color)),

            //line half, after circle
            Container(
                margin: EdgeInsets.only(
                  top: stepHeight / 2,
                  left: (circleSize - stepWidth) / 2,
                ),
                height: stepHeight / 2, //- ((isFirstItem || isLastItem) ? textSize : 0),
                width: stepWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    shape: BoxShape.rectangle,
                    color: isLastItem
                        ? invisibleColor
                        : isPrevItemSelected
                            ? invertedColor
                            : color)),

            //circle & text
            Container(
              margin: EdgeInsets.only(top: textSize / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    height: circleSize,
                    width: circleSize,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      list[index],
                      style: TextStyle(fontSize: textSize, color: color),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
