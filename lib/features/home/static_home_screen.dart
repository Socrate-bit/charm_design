import '../../../ui/home/battery_indcator.dart';
import '../../../ui/home/polar_grid_mock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StaticHomePage extends StatefulWidget {
  const StaticHomePage({super.key});

  @override
  State<StaticHomePage> createState() => _StaticHomePageState();
}

class _StaticHomePageState extends State<StaticHomePage>
    with WidgetsBindingObserver {
  final List<dynamic> homeMenus = [
    {
      'title': 'Moments',
      'icon': 'assets/icons/ic_moments.png',
      'icon_gray': 'assets/icons/ic_moments_gray.png',
      'hasNotif': true,
      'goToPath': RouteConstant.MOMENT_ROUTE_PATH,
    },
    {
      'title': 'Mantras',
      'icon': 'assets/icons/ic_mantras.png',
      'icon_gray': 'assets/icons/ic_mantras_gray.png',
      'hasNotif': false,
      'goToPath': RouteConstant.MANTRA_ROUTE_PATH,
    },
    {
      'title': 'Alignment',
      'icon': 'assets/icons/ic_alignment.png',
      'icon_gray': 'assets/icons/ic_alignment_gray.png',
      'hasNotif': false,
      'goToPath': RouteConstant.ALIGNMENT_ROUTE_PATH,
    },
    {
      'title': 'Wisdom',
      'icon': 'assets/icons/ic_wisdom.png',
      'icon_gray': 'assets/icons/ic_wisdom_gray.png',
      'hasNotif': false,
      'goToPath': RouteConstant.WISDOM_ROUTE_PATH,
    },
  ];

  // Static dummy data for illustration
  final String primaryEmotion = "Contemplation";
  final Color primaryEmotionColor = Colors.green;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _buildEmotionInsightCard({
    required String title,
    required String emotion,
    required String percentage,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                emotion,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                percentage,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:
                      percentage.contains('+') ? Colors.green : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: Row(
                  children: [SizedBox(width: 12), renderBTConnected()],
                ),
              ),
              HorizontalCalendarWidget(
                date: DateTime.now(),
                textColor: Colors.black,
                backgroundColor: Colors.white,
                selectedColor: Colors.transparent,
                onDateSelected: (date) {},
              ),
              const SizedBox(height: 16),

              Image.asset('assets/IMG_2545.jpg', fit: BoxFit.cover),
              // EmotionalPolarGridMock(),
              // const Text(
              //   'Primary State',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 14,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              // Text(
              //   primaryEmotion,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: primaryEmotionColor,
              //     fontSize: 32,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 100,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final items = homeMenus[index];
                    final menuTitle = items['title'] as String;
                    final bool hasData =
                        index < 2; // Dummy condition: first two items have data
                    final bool hasNotification =
                        index ==
                        0; // Dummy condition: only first item has notification

                    return Material(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          if (hasData) {
                            // Navigation would go here
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  items['icon'] as String,

                                  width: 80,
                                  height: 41,
                                  fit: BoxFit.fitHeight,
                                ),
                                if (hasData && hasNotification)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Image.asset(
                                      'assets/icons/ic_notif.png',
                                      width: 16,
                                      height: 16,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              menuTitle,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 24),
              // Community Pulse Component
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Community Pulse',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You\'re part of a global community. See how others are feeling today.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                )),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            // Community Emotion Map
                            CommunityEmotionMap(),

                            // Current User Indicator
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: primaryEmotionColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'You: $primaryEmotion',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Stats Banner
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.people,
                                      size: 16,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      '2,458 active',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildEmotionInsightCard(
                            title: 'Most Common',
                            emotion: 'Joy',
                            percentage: '38%',
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildEmotionInsightCard(
                            title: 'Growing Trend',
                            emotion: 'Calm',
                            percentage: '+12%',
                            color: Colors.blue.shade300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityEmotionMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: CommunityEmotionMapPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class CommunityEmotionMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the emotions with their positions and colors
    final emotions = [
      // Define as (x, y, radius, color, name)
      [0.2, 0.3, 16.0, Colors.yellow, 'Joy'],
      [0.8, 0.7, 12.0, Colors.red, 'Anger'],
      [0.5, 0.2, 10.0, Colors.purple, 'Fear'],
      [0.7, 0.4, 14.0, Colors.blue, 'Sadness'],
      [0.3, 0.8, 9.0, Colors.green, 'Disgust'],
      [0.6, 0.6, 11.0, Colors.orange, 'Surprise'],
      [0.4, 0.5, 15.0, Colors.yellow.shade700, 'Joy'],
      [0.1, 0.6, 8.0, Colors.orange.shade300, 'Surprise'],
      [0.9, 0.2, 13.0, Colors.yellow.shade300, 'Joy'],
      [0.5, 0.8, 10.0, Colors.blue.shade300, 'Calm'],
      [0.2, 0.4, 7.0, Colors.red.shade300, 'Anger'],
      [0.8, 0.3, 9.0, Colors.purple.shade300, 'Fear'],
      [0.4, 0.7, 11.0, Colors.green.shade300, 'Disgust'],
      [0.7, 0.1, 8.0, Colors.blue.shade700, 'Sadness'],
      [0.1, 0.2, 9.0, Colors.blue.shade200, 'Calm'],
      [0.3, 0.1, 7.0, Colors.yellow.shade600, 'Joy'],
      [0.9, 0.5, 12.0, Colors.blue.shade200, 'Calm'],
      [0.6, 0.9, 10.0, Colors.yellow.shade600, 'Joy'],
    ];

    // Draw background gradient
    final backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue.shade50, Colors.purple.shade50],
    );

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final backgroundPaint =
        Paint()..shader = backgroundGradient.createShader(rect);
    canvas.drawRect(rect, backgroundPaint);

    // Draw connection lines between emotions (like a network)
    final linePaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.3)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    for (int i = 0; i < emotions.length; i++) {
      for (int j = i + 1; j < emotions.length; j++) {
        if ((i + j) % 3 == 0) {
          // Only draw some connections for clarity
          final startX = (emotions[i][0] as double) * size.width;
          final startY = (emotions[i][1] as double) * size.height;
          final endX = (emotions[j][0] as double) * size.width;
          final endY = (emotions[j][1] as double) * size.height;

          canvas.drawLine(
            Offset(startX, startY),
            Offset(endX, endY),
            linePaint,
          );
        }
      }
    }

    // Draw emotion circles
    for (var emotion in emotions) {
      final x = (emotion[0] as double) * size.width;
      final y = (emotion[1] as double) * size.height;
      final radius = emotion[2] as double;
      final color = emotion[3] as Color;

      // Outer glow
      final outerPaint =
          Paint()
            ..color = color.withOpacity(0.3)
            ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), radius * 1.5, outerPaint);

      // Main circle
      final circlePaint =
          Paint()
            ..color = color.withOpacity(0.7)
            ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), radius, circlePaint);

      // Inner highlight
      final highlightPaint =
          Paint()
            ..color = Colors.white.withOpacity(0.7)
            ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x - radius * 0.3, y - radius * 0.3),
        radius * 0.3,
        highlightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple circular chart to replace the PolarChartWidgetV2
class CircularChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularChartPainter(),
      size: const Size(342, 342),
    );
  }
}

class CircularChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background circle
    final backgroundPaint =
        Paint()
          ..color = Colors.grey.shade100
          ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw emotion segments
    final emotions = [
      {'name': 'Joy', 'color': Colors.yellow, 'percentage': 0.25},
      {'name': 'Anger', 'color': Colors.red, 'percentage': 0.15},
      {'name': 'Fear', 'color': Colors.purple, 'percentage': 0.2},
      {'name': 'Sadness', 'color': Colors.blue, 'percentage': 0.1},
      {'name': 'Disgust', 'color': Colors.green, 'percentage': 0.05},
      {'name': 'Surprise', 'color': Colors.orange, 'percentage': 0.25},
    ];

    double startAngle = 0;
    for (var emotion in emotions) {
      final sweepAngle = 2 * 3.14159 * (emotion['percentage'] as double);
      final segmentPaint =
          Paint()
            ..color = (emotion['color'] as Color).withOpacity(0.7)
            ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        segmentPaint,
      );

      startAngle += sweepAngle;
    }

    // Draw inner circle
    final innerCirclePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.4, innerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Mock implementation of the MainButtonWidget if it's not accessible
class MainButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? width;
  final TextStyle? titleStyle;

  const MainButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.width,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          title,
          style: titleStyle ?? const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class HorizontalCalendarWidget extends StatefulWidget {
  HorizontalCalendarWidget({
    required this.date,
    required this.onDateSelected,
    super.key,
    DateTime? initialDate,
    DateTime? lastDate,
    this.textColor,
    this.backgroundColor,
    this.selectedColor,
    this.showMonth = false,
    this.locale = const Locale('en', ''),
  }) : initialDate = DateUtils.dateOnly(initialDate ?? DateTime.now()),
       lastDate = DateUtils.dateOnly(
         lastDate ?? DateTime.now().add(const Duration(days: 90)),
       ) {
    assert(
      !this.lastDate.isBefore(this.initialDate),
      'lastDate ${this.lastDate} must be on or after initialDate ${this.initialDate}.',
    );
    assert(
      !this.initialDate.isBefore(this.initialDate),
      'initialDate ${this.initialDate} must be on or after initialDate ${this.initialDate}.',
    );
    assert(
      !this.initialDate.isAfter(this.lastDate),
      'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.',
    );
  }

  /// The initially selected [DateTime] that the picker should display.
  final DateTime date;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime initialDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The [Color] to represent unselected [DateTime] color
  final Color? textColor;

  /// The [Color] to represent calendar background color
  final Color? backgroundColor;

  /// The [Color] to represent selected [DateTime] color
  final Color? selectedColor;

  /// Condition [boolean] to show the month's name
  final bool showMonth;

  /// Change the locale of the calendar
  final Locale locale;

  /// Called when the user selects a date in the picker.
  final void Function(DateTime date) onDateSelected;

  @override
  State<HorizontalCalendarWidget> createState() =>
      HorizontalCalendarWidgetState();
}

class HorizontalCalendarWidgetState extends State<HorizontalCalendarWidget> {
  late DateTime _startDate;
  late DateTime selectedDate;
  PageController? pageController;
  int dateCount = 7;
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date;
    _startDate = widget.date.subtract(Duration(days: dateCount));
    pageController = PageController(initialPage: 8, viewportFraction: 0.4);
    pageController?.addListener(_onPageScrolled);
  }

  void _onPageScrolled() {
    if (pageController != null && pageController!.hasClients) {
      if (pageController!.page != null && pageController!.page! <= 0.1) {
        _addMoreDates();
      }
    }
  }

  void _addMoreDates() {
    final previousLastIndex = pageController?.page?.toInt() ?? 0;
    setState(() {
      dateCount = dateCount + 7;
      _startDate = widget.date.subtract(Duration(days: dateCount));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController?.jumpToPage(previousLastIndex + 7);
    });
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  Future<void> onSelectCurrent(int index, [bool notScrolling = false]) async {
    final date = await selectDate();
    if (date != null) {
      final dateIndex = getIndexForTargetDate(date);
      if (dateIndex > 0) {
        _isProgrammaticScroll = true;
        if (!notScrolling) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            pageController
                ?.animateToPage(
                  dateIndex + 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                )
                .then((_) => _isProgrammaticScroll = false);
          });
        }
        widget.onDateSelected(date);
        setState(() => selectedDate = date);
      } else {
        _isProgrammaticScroll = true;
        final dateCounts = DateTime.now().difference(date).inDays.abs();
        final roundedDateCount = ((dateCounts / 7).ceil()) * 7;
        setState(() {
          dateCount = roundedDateCount;
          _startDate = widget.date.subtract(Duration(days: roundedDateCount));
        });
        final dateIndex = getIndexForTargetDate(date);
        if (!notScrolling) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            pageController
                ?.animateToPage(
                  dateIndex + 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                )
                .then((_) => _isProgrammaticScroll = false);
          });
        }
        widget.onDateSelected(date);
        setState(() => selectedDate = date);
      }
    }
  }

  Future<void> onSelectNotCurrent(
    int index, [
    bool notScrolling = false,
  ]) async {
    _isProgrammaticScroll = true;
    onDatePressed(index);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController
          ?.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          )
          .then((_) => _isProgrammaticScroll = false);
    });
  }

  Future<void> onSelectedDate(
    int index,
    bool isCurrent, [
    bool notScrolling = false,
  ]) async {
    if (isCurrent) {
      await onSelectCurrent(index, notScrolling);
    } else {
      await onSelectNotCurrent(index, notScrolling);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;

    return Container(
      height: height * 6,
      color: widget.backgroundColor ?? Colors.white,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        subtitle: Row(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: dateCount + 1,
                onPageChanged: (index) {
                  if (_isProgrammaticScroll) return;
                  final date = _startDate.add(Duration(days: index));
                  setState(() {
                    selectedDate = date;
                  });
                  onSelectNotCurrent(index, true);
                },
                itemBuilder: (context, index) {
                  return CalendarItemsWidget(
                    index: index,
                    startDate: _startDate,
                    initialDate: widget.initialDate,
                    selectedDate: selectedDate,
                    textColor: widget.textColor ?? Colors.black45,
                    selectedColor:
                        widget.selectedColor ?? Theme.of(context).primaryColor,
                    backgroundColor: widget.backgroundColor ?? Colors.white,
                    locale: widget.locale,
                    onDatePressed: (isCurrent) async {
                      await onSelectedDate(index, isCurrent);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getIndexForTargetDate(DateTime targetDate) {
    // Ensure targetDate is after or the same as _startDate
    if (targetDate.isBefore(_startDate)) {
      return -1; // targetDate is before the _startDate, no valid index
    }

    // Calculate the difference in days between targetDate and _startDate
    final daysDifference = targetDate.difference(_startDate).inDays;

    // Ensure the target date does not go beyond the dateCount
    if (daysDifference > dateCount) {
      return -1; // targetDate is beyond the available range
    }

    // The index is simply the days difference
    return daysDifference;
  }

  Future<DateTime?> selectDate() async {}

  void onDatePressed(int index) {
    final date = DateUtils.dateOnly(_startDate.add(Duration(days: index)));
    widget.onDateSelected(date);
    setState(() {
      selectedDate = date;
    });
  }
}

// Mock RouteConstant if it's not accessible
class RouteConstant {
  static const String MOMENT_ROUTE_PATH = '/moments';
  static const String MANTRA_ROUTE_PATH = '/mantras';
  static const String ALIGNMENT_ROUTE_PATH = '/alignment';
  static const String WISDOM_ROUTE_PATH = '/wisdom';
}

class CalendarItemsWidget extends StatelessWidget {
  const CalendarItemsWidget({
    required this.index,
    required this.startDate,
    required this.initialDate,
    required this.selectedDate,
    required this.textColor,
    required this.selectedColor,
    required this.backgroundColor,
    required this.locale,
    required this.onDatePressed,
    super.key,
  });

  final int index;
  final DateTime startDate;
  final DateTime initialDate;
  final DateTime selectedDate;
  final Color textColor;
  final Color selectedColor;
  final Color backgroundColor;
  final Locale locale;
  final void Function(bool isCurrent) onDatePressed;

  @override
  Widget build(BuildContext context) {
    final date = startDate.add(Duration(days: index));
    final diffDays = DateUtils.dateOnly(date).difference(selectedDate).inDays;
    return Container(
      width: 200,
      color: diffDays != 0 ? backgroundColor : selectedColor,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => onDatePressed(diffDays == 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateHelper.formatDateWithRelative(date, locale.toString()),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: diffDays != 0 ? Colors.grey.shade300 : Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (diffDays == 0) const SizedBox(width: 8),
            if (diffDays == 0) Image.asset('assets/icons/ic_today_date.png'),
          ],
        ),
      ),
    );
  }
}

class DateHelper {
  static String formatDateWithRelative(DateTime date, String locale) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate == today) {
      return 'Today';
    } else if (targetDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (targetDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else {
      return DateFormat('E, MMM d', locale).format(date);
    }
  }

  static String convertToAmPm(String time) {
    final dateTime = DateFormat('HH:mm').parse(time);
    return DateFormat('hh:mma').format(dateTime).toLowerCase();
  }
}
