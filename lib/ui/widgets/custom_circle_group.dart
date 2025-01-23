import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleLabel extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const CircleLabel({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 136.w, // Use ScreenUtil scaling
        height: 136.w, // Use ScreenUtil scaling
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 161, 117, 1),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18.sp, // Scale font size based on screen size
            color: isActive
                ? const Color.fromARGB(255, 0, 0, 255)
                : const Color.fromARGB(255, 254, 254, 254),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CustomCircleGroup extends StatefulWidget {
  final List<String> labels;
  final double circleSize;
  final Color activeColor;
  final Color inactiveColor;
  final Function(int)? onCircleSelected;

  const CustomCircleGroup({
    super.key,
    required this.labels,
    this.circleSize = 136.0,
    this.activeColor = const Color.fromARGB(39, 87, 166, 1),
    this.inactiveColor = const Color.fromARGB(255, 254, 254, 254),
    this.onCircleSelected,
  });

  @override
  State<CustomCircleGroup> createState() => _CircleGroupState();
}

class _CircleGroupState extends State<CustomCircleGroup> {
  int activeIndex = -1;

  void setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });

    if (widget.onCircleSelected != null) {
      widget.onCircleSelected!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 15.h, // Use ScreenUtil scaling for spacing
      children: List.generate(
        widget.labels.length,
        (index) => CircleLabel(
          label: widget.labels[index],
          isActive: activeIndex == index,
          onTap: () => setActiveIndex(index),
        ),
      ),
    );
  }
}
