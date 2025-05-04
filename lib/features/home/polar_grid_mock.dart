import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';
import 'package:path_drawing/path_drawing.dart';
import 'interaction_constant.dart';

class EmotionalPolarGridMock extends StatelessWidget {
  const EmotionalPolarGridMock({super.key});

  Future<List<_PlaceHolder>> _loadSvgImage(String svgImage) async {
    String svgString = await rootBundle.loadString(svgImage);
    XmlDocument document = XmlDocument.parse(svgString);
    final paths = document.findAllElements('path');

    return paths.map((element) {
      return _PlaceHolder(
        id: element.getAttribute('id') ?? '',
        path: element.getAttribute('d') ?? '',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<_PlaceHolder>>(
      future: _loadSvgImage('assets/Svg/drawing-4.svg'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading SVG'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        List<_PlaceHolder> placeHolderPaths = snapshot.data!;

        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const _AlignementCircle(),
                _PolarGridWidget(
                  placeholderList: placeHolderPaths,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const _PrimaryState(),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

class _PrimaryState extends StatelessWidget {
  const _PrimaryState();

  // Static dummy data
  double _getAlignementScore() {
    // Return a fixed alignment score
    return 0.75;
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    // Static dummy data
    const dominantEmotion = "Joy";
    final emotionColor = InteractionConstants.emotionColorMap[dominantEmotion] ?? Colors.transparent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              'Alignment Score',
              style: tt.bodyMedium,
            ),
            Text(
              '${(_getAlignementScore() * 100).toStringAsFixed(0)}%',
              style: tt.labelMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(width: 100),
        Column(
          children: [
            Text(
              'Primary State',
              style: tt.bodyMedium!,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: emotionColor),
              child: Text(
                dominantEmotion,
                style: tt.labelMedium!,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _AlignementCircle extends StatelessWidget {
  const _AlignementCircle();

  // Static dummy data
  double _getAlignementScore() {
    return 0.75;
  }

  @override
  Widget build(BuildContext context) {
    final double score = _getAlignementScore();
    
    return InkWell(
      onTap: () => _showAlignementModal(score: score, context: context),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 0, 0),
                  width: 20,
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 225, 255).withOpacity(score),
                  width: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
  void _showAlignementModal({required double score, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alignment Score'),
        content: Text('Your alignment score is ${(score * 100).toStringAsFixed(0)}%'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _PolarGridWidget extends StatelessWidget {
  const _PolarGridWidget({required this.placeholderList});
  final List<_PlaceHolder> placeholderList;
  static const double _angleCorrection = -pi / 110;
  static const double _brightnessCorrectingFactor = 3;
  static const double _minimumOpacity = 0.15;

  double _getOpacity(double score) {
    // Ensure opacity is never below minimum value of 0.1
    return max(min(score * _brightnessCorrectingFactor, 1), _minimumOpacity);
  }

  @override
  Widget build(BuildContext context) {
    // Use comprehensive mock data for all emotions
    final emotionAggregattedScores = _allEmotionScores;
    final emotionAggregattedScoresNormalized = _allEmotionScoresNormalized;

    return SizedBox(
      width: 313,
      height: 313,
      child: Transform.rotate(
        angle: _angleCorrection,
        child: Stack(
          children: [
            for (_PlaceHolder placeholder in placeholderList)
              _PlaceholderWidget(
                emotionName:
                    InteractionConstants.placeholderEmotions[placeholder.id] ?? 'no emotion',
                emotionScore: emotionAggregattedScores[InteractionConstants.placeholderEmotions[placeholder.id]] ?? 0,
                placeHolderColor:
                    InteractionConstants.placeHolderColorMap[placeholder.id] ?? Colors.transparent,
                placeHolderOpacity: _getOpacity(
                    emotionAggregattedScoresNormalized[InteractionConstants.placeholderEmotions[placeholder.id]] ?? 0.35),
                placeHolderPath: placeholder.path,
              ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderWidget extends StatelessWidget {
  const _PlaceholderWidget({
    required this.emotionName,
    required this.emotionScore,
    required this.placeHolderColor,
    required this.placeHolderOpacity,
    required this.placeHolderPath,
  });

  final String emotionName;
  final double emotionScore;
  final Color placeHolderColor;
  final double placeHolderOpacity;
  final String placeHolderPath;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CustomClipper(svgPath: placeHolderPath),
      child: GestureDetector(
        onTap: () => _showEmotionScorePage(emotionName: emotionName, context: context),
        child: Stack(children: [
          Container(color: Colors.grey.withOpacity(0.125)),
          Container(
            color: placeHolderColor.withOpacity(placeHolderOpacity),
          ),
        ]),
      ),
    );
  }
  
  void _showEmotionScorePage({required String emotionName, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(emotionName),
        content: Text('Score: ${(emotionScore * 100).toStringAsFixed(1)}%'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  _CustomClipper({required this.svgPath});
  final String svgPath;

  @override
  Path getClip(Size size) {
    var path = parseSvgPathData(svgPath);
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(1.2, 1.2);
    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class _PlaceHolder {
  final String id;
  final String path;

  _PlaceHolder({required this.id, required this.path});
}

// Original mock emotion scores with limited emotions
final LinkedHashMap<String, double> _mockEmotionScores = LinkedHashMap.from({
  'Joy': 0.85,
  'Trust': 0.65,
  'Anticipation': 0.55,
  'Surprise': 0.45,
  'Sadness': 0.35,
  'Disgust': 0.25,
  'Anger': 0.15,
  'Fear': 0.05,
});

// Original mock normalized emotion scores with limited emotions
final LinkedHashMap<String, double> _mockEmotionScoresNormalized = LinkedHashMap.from({
  'Joy': 1.0,
  'Trust': 0.76,
  'Anticipation': 0.65,
  'Surprise': 0.53,
  'Sadness': 0.41,
  'Disgust': 0.29,
  'Anger': 0.18,
  'Fear': 0.06,
});

// Comprehensive mock data for all emotions in InteractionConstants
final LinkedHashMap<String, double> _allEmotionScores = LinkedHashMap.from({
  // Emotions to highlight (Joy and closely related)
  'Joy': 0.85, // Keep Joy at maximum
  'Ecstasy': 0.75, // High value - closely related to Joy
  'Excitement': 0.70, // High value - closely related to Joy
  'Enthusiasm': 0.65, // High value - closely related to Joy
  'Love': 0.60, // High value - closely related to Joy
  
  // All other emotions with very low intensity
  'Trust': 0.15,
  'Satisfaction': 0.14,
  'Contentment': 0.13,
  'Pride': 0.12,
  'Anticipation': 0.11,
  'Surprise (positive)': 0.10,
  'Interest': 0.09,
  'Adoration': 0.08,
  'Admiration': 0.07,
  'Amusement': 0.06,
  'Aesthetic Appreciation': 0.05,
  'Gratitude': 0.05,
  'Realization': 0.04,
  'Awe': 0.04,
  'Entrancement': 0.04,
  'Relief': 0.03,
  'Nostalgia': 0.03,
  'Romance': 0.03,
  'Sympathy': 0.02,
  'Triumph': 0.02,
  'Concentration': 0.02,
  'Contemplation': 0.02,
  'Calmness': 0.01,
  'Determination': 0.01,
  'Desire': 0.01,
  'Craving': 0.01,
  'Sadness': 0.01,
  'Empathic Pain': 0.01,
  'Disappointment': 0.01,
  'Doubt': 0.01,
  'Tiredness': 0.01,
  'Disapproval': 0.01,
  'Boredom': 0.01,
  'Confusion': 0.01,
  'Anxiety': 0.01,
  'Surprise (negative)': 0.01,
  'Disgust': 0.01,
  'Anger': 0.01,
  'Fear': 0.01,
  'Distress': 0.01,
  'Shame': 0.01,
  'Guilt': 0.01,
  'Envy': 0.01,
  'Contempt': 0.01,
  'Embarrassment': 0.01,
  'Awkwardness': 0.01,
  'Annoyance': 0.01,
  'Horror': 0.01,
  'Pain': 0.01,
  'Sarcasm': 0.01,
});

// Normalized values for all emotions (calculated relative to the highest value of 0.85 for Joy)
final LinkedHashMap<String, double> _allEmotionScoresNormalized = LinkedHashMap.from({
  // Emotions to highlight (Joy and closely related)
  'Joy': 1.0, // Joy remains the most intense
  'Ecstasy': 0.88, // High value - closely related to Joy
  'Excitement': 0.82, // High value - closely related to Joy
  'Enthusiasm': 0.76, // High value - closely related to Joy  
  'Love': 0.71, // High value - closely related to Joy
  
  // All other emotions with minimal normalized scores
  'Trust': 0.18,
  'Satisfaction': 0.16,
  'Contentment': 0.15,
  'Pride': 0.14,
  'Anticipation': 0.13,
  'Surprise (positive)': 0.12,
  'Interest': 0.11,
  'Adoration': 0.09,
  'Admiration': 0.08,
  'Amusement': 0.07,
  'Aesthetic Appreciation': 0.06,
  'Gratitude': 0.06,
  'Realization': 0.05,
  'Awe': 0.05,
  'Entrancement': 0.05,
  'Relief': 0.04,
  'Nostalgia': 0.04,
  'Romance': 0.04,
  'Sympathy': 0.02,
  'Triumph': 0.02,
  'Concentration': 0.02,
  'Contemplation': 0.02,
  'Calmness': 0.01,
  'Determination': 0.01,
  'Desire': 0.01,
  'Craving': 0.01,
  'Sadness': 0.01,
  'Empathic Pain': 0.01,
  'Disappointment': 0.01,
  'Doubt': 0.01,
  'Tiredness': 0.01,
  'Disapproval': 0.01,
  'Boredom': 0.01,
  'Confusion': 0.01,
  'Anxiety': 0.01,
  'Surprise (negative)': 0.01,
  'Disgust': 0.01,
  'Anger': 0.01,
  'Fear': 0.01,
  'Distress': 0.01,
  'Shame': 0.01,
  'Guilt': 0.01,
  'Envy': 0.01,
  'Contempt': 0.01,
  'Embarrassment': 0.01,
  'Awkwardness': 0.01,
  'Annoyance': 0.01,
  'Horror': 0.01,
  'Pain': 0.01,
  'Sarcasm': 0.01,
}); 