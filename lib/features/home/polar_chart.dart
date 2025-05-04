import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:graphic/graphic.dart';
import 'package:graphic/src/chart/size.dart';
import 'package:graphic/src/chart/view.dart';
import 'package:graphic/src/coord/coord.dart';
import 'package:graphic/src/data/data_set.dart';
import 'package:graphic/src/guide/annotation/annotation.dart';
import 'package:graphic/src/guide/axis/axis.dart';
import 'package:graphic/src/guide/interaction/crosshair.dart';
import 'package:graphic/src/guide/interaction/tooltip.dart';
import 'package:graphic/src/interaction/gesture.dart';
import 'package:graphic/src/interaction/selection/selection.dart';
import 'package:graphic/src/mark/mark.dart';
import 'package:graphic/src/util/collection.dart';
import 'package:graphic/src/variable/transform/transform.dart';
import 'package:graphic/src/variable/variable.dart';

class PolarChartWidget<D> extends StatefulWidget {
  const PolarChartWidget({
    required this.data, required this.variables, required this.marks, super.key,
    this.changeData,
    this.transforms,
    this.coord,
    this.padding,
    this.axes,
    this.tooltip,
    this.crosshair,
    this.annotations,
    this.selections,
    this.rebuild,
    this.gestureStream,
    this.resizeStream,
    this.changeDataStream,
    this.onSegmentTapped,
  });

  final List<D> data;
  final Map<String, Variable<D, dynamic>> variables;
  final List<VariableTransform>? transforms;
  final List<Mark> marks;
  final Coord? coord;
  final EdgeInsets Function(Size)? padding;
  final List<AxisGuide>? axes;
  final TooltipGuide? tooltip;
  final CrosshairGuide? crosshair;
  final List<Annotation>? annotations;
  final Map<String, Selection>? selections;
  final bool? rebuild;
  final bool? changeData;
  final StreamController<GestureEvent>? gestureStream;
  final StreamController<ResizeEvent>? resizeStream;
  final StreamController<ChangeDataEvent<D>>? changeDataStream;
  final void Function(D dataItem)? onSegmentTapped;

  bool equalSpecTo(Object other) =>
      other is PolarChartWidget<D> &&
      deepCollectionEquals(variables, other.variables) &&
      deepCollectionEquals(transforms, other.transforms) &&
      deepCollectionEquals(marks, other.marks) &&
      coord == other.coord &&
      deepCollectionEquals(axes, other.axes) &&
      tooltip == other.tooltip &&
      crosshair == other.crosshair &&
      deepCollectionEquals(annotations, other.annotations) &&
      deepCollectionEquals(selections, other.selections) &&
      rebuild == other.rebuild &&
      changeData == other.changeData &&
      gestureStream == other.gestureStream &&
      resizeStream == other.resizeStream &&
      changeDataStream == other.changeDataStream;

  @override
  PolarChartWidgetState<D> createState() => PolarChartWidgetState<D>();
}

class PolarChartWidgetState<D> extends State<PolarChartWidget<D>>
    with TickerProviderStateMixin {
  ChartView<D>? view;
  Size size = Size.zero;
  Offset gestureLocalPosition = Offset.zero;
  PointerDeviceKind gestureKind = PointerDeviceKind.unknown;
  Offset? gestureLocalMoveStart;
  ScaleUpdateDetails? gestureScaleDetail;

  void repaint() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant PolarChartWidget<D> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rebuild ?? !widget.equalSpecTo(oldWidget)) {
      view?.dispose();
      view = null;
    } else if (widget.changeData == true ||
        (widget.changeData == null && widget.data != oldWidget.data)) {
      view!.changeData(widget.data);
    }
  }

  /// NOTE: don't use this as a reference, the data still wrong
  void _handleSegmentTap() {
    if (widget.onSegmentTapped == null || view == null) return;

    final center = Offset(size.width / 2, size.height / 2);
    final tapOffset = gestureLocalPosition - center;
    final rawTapAngle = tapOffset.direction;
    final tapRadius = tapOffset.distance;

    // 1. Adjust coordinate system to match polar chart orientation
    final tapAngle = (rawTapAngle - pi / 2 + 2 * pi) % (2 * pi);

    // 2. Calculate actual chart radius and scaling factor
    final chartRadius = center.dx;
    const maxDataValue = 51;
    final scaleFactor = maxDataValue / chartRadius;
    final scaledTapRadius = tapRadius * scaleFactor;

    D? closestData;
    var minDistance = double.infinity;

    final mainCategoryVar = widget.variables['Happy'];
    final subCategoryVar = widget.variables['Expression'];
    final valueVar = widget.variables['Peak at'];

    if (mainCategoryVar == null || subCategoryVar == null || valueVar == null) {
      return;
    }

    for (final dataItem in widget.data) {
      // 3. Parse original data values from string representations
      final mainCategory =
          int.parse(mainCategoryVar.accessor(dataItem) as String);
      final subCategory =
          int.parse(subCategoryVar.accessor(dataItem) as String);
      final value = valueVar.accessor(dataItem) as int;

      // print('data 1: ${mainCategory}');
      // print('data 2: ${subCategory}');
      // print('data 3: ${value}');

      // 4. Calculate expected angle position for data point
      const sectorWidth = 2 * pi / 13; // 13 main categories
      const subSectorWidth = sectorWidth / 4; // 4 sub-categories

      // Base angle for main category (clockwise from top)
      final baseAngle = mainCategory * sectorWidth;

      // Offset within main category sector
      final subAngle = subCategory * subSectorWidth;

      // Center of the sub-sector
      final dataAngle = (baseAngle + subAngle + subSectorWidth / 2) % (2 * pi);

      // 5. Calculate angular distance
      var angleDiff = (dataAngle - tapAngle).abs();
      angleDiff = min(angleDiff, 2 * pi - angleDiff);

      // 6. Calculate radial distance
      final radiusDiff = (value - scaledTapRadius).abs();

      // 7. Combined weighted distance
      final distance = angleDiff * 100 + radiusDiff;

      if (distance < minDistance) {
        minDistance = distance;
        closestData = dataItem;
      }
    }

    if (closestData != null) {
      widget.onSegmentTapped!(closestData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _ChartLayoutDelegate<D>(this),
      child: MouseRegion(
        child: Listener(
          child: GestureDetector(
            child: RepaintBoundary(
              child: CustomPaint(
                size: Size.infinite,
                painter: _ChartPainter<D>(this),
              ),
            ),
            onTap: () {
              view!.gesture(Gesture(
                GestureType.tap,
                gestureKind,
                gestureLocalPosition,
                size,
                null,
                chartKey: widget.key,
              ),);
              _handleSegmentTap();
            },
            onTapCancel: () {
              view!.gesture(Gesture(
                GestureType.tapCancel,
                gestureKind,
                gestureLocalPosition,
                size,
                null,
                chartKey: widget.key,
              ),);
            },
            onTapDown: (detail) {
              gestureLocalPosition = detail.localPosition;
              view!.gesture(Gesture(
                GestureType.tapDown,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
              ),);
            },
            onTapUp: (detail) {
              gestureLocalPosition = detail.localPosition;
              view!.gesture(Gesture(
                GestureType.tapUp,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
              ),);
            },
            onTertiaryLongPress: () {
              view!.gesture(Gesture(
                GestureType.tertiaryLongPress,
                gestureKind,
                gestureLocalPosition,
                size,
                null,
                chartKey: widget.key,
              ),);
            },
            onTertiaryLongPressCancel: () {
              view!.gesture(Gesture(
                GestureType.tertiaryLongPressCancel,
                gestureKind,
                gestureLocalPosition,
                size,
                null,
                chartKey: widget.key,
              ),);
            },
            onTertiaryLongPressDown: (detail) {
              gestureLocalPosition = detail.localPosition;
              view!.gesture(Gesture(
                GestureType.tertiaryLongPressDown,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
              ),);
            },
            onTertiaryLongPressEnd: (detail) {
              gestureLocalPosition = detail.localPosition;
              gestureLocalMoveStart = null;
              view!.gesture(Gesture(
                GestureType.tertiaryLongPressEnd,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
                localMoveStart: gestureLocalMoveStart,
              ),);
            },
            onTertiaryLongPressMoveUpdate: (detail) {
              gestureLocalPosition = detail.localPosition;
              view!.gesture(Gesture(
                GestureType.tertiaryLongPressMoveUpdate,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
                localMoveStart: gestureLocalMoveStart,
              ),);
            },
            onTertiaryLongPressStart: (detail) {
              gestureLocalPosition = detail.localPosition;
              gestureLocalMoveStart = detail.localPosition;
              view!.gesture(Gesture(
                GestureType.tertiaryLongPressStart,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
              ),);
            },
            onTertiaryLongPressUp: () {
              view!.gesture(Gesture(
                GestureType.tertiaryLongPressUp,
                gestureKind,
                gestureLocalPosition,
                size,
                null,
                chartKey: widget.key,
              ),);
            },
            onTertiaryTapCancel: () {
              view!.gesture(Gesture(
                GestureType.tertiaryTapCancel,
                gestureKind,
                gestureLocalPosition,
                size,
                null,
                chartKey: widget.key,
              ),);
            },
            onTertiaryTapDown: (detail) {
              gestureLocalPosition = detail.localPosition;
              view!.gesture(Gesture(
                GestureType.tertiaryTapDown,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
              ),);
            },
            onTertiaryTapUp: (detail) {
              gestureLocalPosition = detail.localPosition;
              view!.gesture(Gesture(
                GestureType.tertiaryTapUp,
                gestureKind,
                gestureLocalPosition,
                size,
                detail,
                chartKey: widget.key,
              ),);
            },
          ),
          onPointerHover: (event) {
            gestureKind = event.kind;
            gestureLocalPosition = event.localPosition;
            view!.gesture(Gesture(
              GestureType.hover,
              gestureKind,
              gestureLocalPosition,
              size,
              null,
              chartKey: widget.key,
            ),);
          },
          onPointerSignal: (event) {
            gestureLocalPosition = event.localPosition;
            if (event is PointerScrollEvent) {
              view!.gesture(Gesture(
                GestureType.scroll,
                gestureKind,
                gestureLocalPosition,
                size,
                event.scrollDelta,
                chartKey: widget.key,
              ),);
            }
          },
        ),
        onEnter: (event) {
          gestureKind = event.kind;
          gestureLocalPosition = event.localPosition;
          view!.gesture(Gesture(
            GestureType.mouseEnter,
            gestureKind,
            gestureLocalPosition,
            size,
            null,
            chartKey: widget.key,
          ),);
        },
        onExit: (event) {
          gestureKind = event.kind;
          gestureLocalPosition = event.localPosition;
          view!.gesture(Gesture(
            GestureType.mouseExit,
            gestureKind,
            gestureLocalPosition,
            size,
            null,
            chartKey: widget.key,
          ),);
        },
      ),
    );
  }

  @override
  void dispose() {
    view?.dispose();
    super.dispose();
  }
}

class _ChartLayoutDelegate<D> extends SingleChildLayoutDelegate {
  _ChartLayoutDelegate(this.state);
  final PolarChartWidgetState<D> state;

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => true;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    if (state.view == null) {
      state.view = ChartView<D>(
        _buildChartSpec(),
        size,
        state,
        state.repaint,
      );
    } else if (size != state.size) {
      state.view!.resize(size);
    }
    state.size = size;
    return Offset.zero;
  }

  Chart<D> _buildChartSpec() {
    return Chart(
      data: state.widget.data,
      variables: state.widget.variables,
      transforms: state.widget.transforms,
      marks: state.widget.marks,
      coord: state.widget.coord,
      axes: state.widget.axes,
      annotations: state.widget.annotations,
      selections: state.widget.selections,
      tooltip: state.widget.tooltip,
      crosshair: state.widget.crosshair,
    );
  }
}

class _ChartPainter<D> extends CustomPainter {
  _ChartPainter(this.state);
  final PolarChartWidgetState<D> state;

  @override
  void paint(Canvas canvas, Size size) {
    if (state.view != null) {
      state.view!.graffiti.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      this != oldDelegate;
}
