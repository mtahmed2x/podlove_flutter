import 'package:flutter/material.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class DynamicRangeSlider extends StatefulWidget {
  final double min;
  final double max;
  final double initialValue;
  final String unit;

  const DynamicRangeSlider({
    super.key,
    this.min = 1.0,
    this.max = 100.0,
    this.initialValue = 65.0,
    this.unit = "Miles",
  });

  @override
  State<DynamicRangeSlider> createState() => _DynamicRangeSliderState();
}

class _DynamicRangeSliderState extends State<DynamicRangeSlider> {
  late double _currentValue = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    double sliderWidth = 340.0;
    double thumbRadius = 8.0;

    return Center(
      child: SizedBox(
        width: sliderWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "${widget.min.toInt()} ${widget.unit}",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(92, 92, 92, 1),
                  ),
                  CustomText(
                    text: "${widget.max.toInt()} ${widget.unit}",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(92, 92, 92, 1),
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 23.0,
                  top: 14.0,
                  child: Container(
                    width: 1.0,
                    height: 20.0,
                    color: AppColors.accent,
                  ),
                ),
                Positioned(
                  right: 23.0,
                  top: 14.0,
                  child: Container(
                    width: 1.0,
                    height: 20.0,
                    color: AppColors.accent,
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Color.fromARGB(230, 255, 161, 117),
                    inactiveTrackColor: Color.fromARGB(255, 254, 227, 212),
                    thumbColor: Color.fromARGB(230, 255, 161, 117),
                    trackHeight: 8,
                  ),
                  child: Slider(
                    value: _currentValue,
                    min: widget.min,
                    max: widget.max,
                    divisions: (widget.max - widget.min).toInt(),
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: ((_currentValue - widget.min) /
                              (widget.max - widget.min)) *
                          (sliderWidth - 2 * thumbRadius) +
                      thumbRadius -
                      15,
                  child: Transform.translate(
                    offset: Offset(-15, 0),
                    child: SizedBox(
                      width: 65,
                      child: CustomText(
                        text: "${_currentValue.toInt()} ${widget.unit}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(92, 92, 92, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
