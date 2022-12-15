import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FearMeter extends StatefulWidget {
  String timeRange;
  String fearString;
  double value;
  FearMeter({
    Key? key,
    required this.timeRange,
    required this.fearString,
    required this.value,
  }) : super(key: key);

  @override
  State<FearMeter> createState() => _FearMeterState();
}

class _FearMeterState extends State<FearMeter> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          interval: 10,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 30,
              color: AppColors.red,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 60,
              color: AppColors.navy,
            ),
            GaugeRange(
              startValue: 60,
              endValue: 100,
              color: AppColors.green,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: widget.value,
              enableAnimation: true,
              needleColor: AppColors.navy,
              knobStyle: KnobStyle(color: AppColors.navy),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                widget.timeRange,
                style: TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width * 0.04,
                  letterSpacing: 1,
                ),
              ),
              positionFactor: 0.5,
              angle: 270,
            ),
            GaugeAnnotation(
              widget: Text(
                widget.value.toString().substring(0, 4),
                style: TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width * 0.035,
                  letterSpacing: 1,
                ),
              ),
              positionFactor: 0.25,
              angle: 90,
            ),
            GaugeAnnotation(
              widget: Text(
                widget.fearString,
                style: TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width * 0.035,
                  letterSpacing: 1,
                ),
              ),
              positionFactor: 0.5,
              angle: 90,
            ),
          ],
        ),
      ],
    );
  }
}
