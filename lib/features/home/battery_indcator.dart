import 'package:flutter/material.dart';

Widget renderBTConnected() {
  return Material(
    color: const Color(0XFFF5F5F5),
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image.asset(
              'assets/icons_2/ic_pendant_purple.png',
              height: 20,
              width: 20,
              color: const Color(0xFF7f41ba),
            ),
            const SizedBox(width: 8),
            Container(width: 1, height: 8, color: const Color(0xFFD6D6D6)),
            const SizedBox(width: 8),
            BasedBatteryIndicator(
              status: BasedBatteryStatus(
                value: 77,
                type: BasedBatteryStatusType.charging,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '77%',
              style: const TextStyle(
                color: Color(0xFF141414),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// [BasedBatteryIndicator] shows a iOS-like battery indicator with
class BasedBatteryIndicator extends StatelessWidget {
  const BasedBatteryIndicator({
    super.key,
    required this.status,
    this.trackHeight = 10.0,
    this.trackAspectRatio = 2.0,
    this.curve = Curves.ease,
    this.duration = const Duration(seconds: 1),
  }) : assert(trackAspectRatio >= 1, 'width:height must >= 1');

  /// battery status
  final BasedBatteryStatus status;

  /// The height of the track (i.e. container).
  final double trackHeight;

  /// width:height must >= 1
  final double trackAspectRatio;

  /// animation curve
  final Curve curve;

  /// animation duration
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final track = _buildTrack(context, colorScheme);
    final knob = _buildKnob(context, colorScheme);

    return Row(mainAxisSize: MainAxisSize.min, children: [track, knob]);
  }

  Widget _buildTrack(BuildContext context, ColorScheme colorScheme) {
    final borderRadius = BorderRadius.circular(trackHeight / 4);
    final borderColor = colorScheme.outline;

    final bar = _buildBar(context, trackHeight * 5 / 6, colorScheme);
    final icon = _buildIcon();

    final children = [bar, icon];

    return Container(
      height: trackHeight,
      width: trackHeight * trackAspectRatio,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: borderColor),
      ),
      child: Stack(children: children),
    );
  }

  Widget _buildBar(
    BuildContext context,
    double barHeight,
    ColorScheme colorScheme,
  ) {
    final barWidth = trackHeight * trackAspectRatio;
    final borderRadius = barHeight / 5;
    final currentColor = status.getBatteryColor(colorScheme);

    return Padding(
      padding: EdgeInsets.all(trackHeight / 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            const SizedBox.expand(),
            AnimatedContainer(
              duration: duration,
              width: (barWidth - trackHeight / 6) * status.value / 100,
              height: double.infinity,
              curve: curve,
              decoration: BoxDecoration(color: currentColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: duration.inMilliseconds ~/ 5),
            switchInCurve: curve,
            switchOutCurve: curve,
            child:
                status.type.isCharing
                    ? Icon(
                      Icons.electric_bolt,
                      color: Colors.white,
                      size: constraints.maxHeight,
                      shadows: const [
                        Shadow(blurRadius: 0.5),
                        Shadow(color: Colors.white, blurRadius: 1),
                      ],
                    )
                    : null,
          );
        },
      ),
    );
  }

  Widget _buildKnob(BuildContext context, ColorScheme colorScheme) {
    final knobHeight = trackHeight / 3;
    final knobWidth = knobHeight / 2;
    final borderColor = colorScheme.outline;

    return Padding(
      padding: EdgeInsets.only(left: trackHeight / 20),
      child: SizedBox(
        width: knobWidth,
        height: knobHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(knobWidth / 3),
            ),
          ),
        ),
      ),
    );
  }
}

class BasedBatteryStatus {
  const BasedBatteryStatus({
    required int value,
    BasedBatteryStatusType type = BasedBatteryStatusType.normal,
  }) : _value = value,
       _type = type;

  final int _value;
  int get value => type != BasedBatteryStatusType.error ? _value : 100;

  final BasedBatteryStatusType _type;
  BasedBatteryStatusType get type {
    if (_type.isError || !(0 <= _value && _value <= 100)) {
      return BasedBatteryStatusType.error;
    }
    return _type;
  }

  Color getBatteryColor(ColorScheme colorScheme) {
    if (type.isError) return Colors.red[900]!;
    if (type.isCharing) return Colors.green[500]!;
    if (type.isLow) return Colors.orange[700]!;
    return 0 <= _value && _value <= 20 ? Colors.red[500]! : colorScheme.outline;
  }
}

/// [BasedBatteryStatusType]
enum BasedBatteryStatusType {
  error,
  low,
  charging,
  normal;

  bool get isError => this == BasedBatteryStatusType.error;
  bool get isLow => this == BasedBatteryStatusType.low;
  bool get isCharing => this == BasedBatteryStatusType.charging;
  bool get isNormal => this == BasedBatteryStatusType.normal;
}
