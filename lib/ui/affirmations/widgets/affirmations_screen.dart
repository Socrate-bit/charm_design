import 'package:flutter/material.dart';
import '../view_model/affirmations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_selector.dart';

class AffirmationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          _buildAffirmationPage('The goal is progress over perfection.'),
          _buildAffirmationPage('Believe in yourself and all that you are.'),
          _buildAffirmationPage('Every day is a second chance.'),
          _buildAffirmationPage('You are stronger than you think.'),
          _buildAffirmationPage('Your potential is endless.'),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    String label, {
    bool hasNotification = false,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(icon, color: Colors.grey[800]),
              onPressed: onPressed,
            ),
          ),
          if (hasNotification)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(minWidth: 16, minHeight: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 24, color: Colors.grey[800]),
      ),
    );
  }

  Widget _buildAffirmationPage(String text) {
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFE0B2), // Muted peach
                Color(0xFFFFF3E0), // Pale pink
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildIconButton(Icons.music_note, 'MUSIC', onPressed: () {}),
                    _buildIconButton(Icons.category, 'CATEGORY', onPressed: () => _showCategorySelector(context)),
                  ],
                ),
              ),
              Spacer(),
              Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontFamily: 'Serif',
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(Icons.favorite, 'Like'),
                  _buildActionButton(Icons.add, 'Add to Routine'),
                  _buildActionButton(Icons.play_arrow, 'Practice'),
                  _buildActionButton(Icons.share, 'Share'),
                ],
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }

  void _showCategorySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CategorySelector();
      },
    );
  }

  Widget _buildCategoryItem(String title, IconData icon) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
