import 'package:flutter/material.dart';
import 'dart:ui';

class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar for bottom sheet
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            // Back button
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),

            // Title and subtitle
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select the areas of your life you would like to focus on',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search the categories',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _buildCategoryCard(
                                title: 'General',
                                isSelected: true,
                                imagePath: 'assets/images/img_archetype_5.jpg',
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _buildCategoryCard(
                                title: 'Add your own\naffirmations',
                                isLocked: true,
                                imagePath: 'assets/images/img_archetype_7.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Popular section heading
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Popular',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Affirmations that are resonating with the masses',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Popular affirmations
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: _buildAffirmationCard(
                                    title: 'Think positively',
                                    imagePath:
                                        'assets/images/img_archetype_9.jpg',
                                    isLocked: true,
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: _buildAffirmationCard(
                                    title: 'Build self-confidence',
                                    imagePath:
                                        'assets/images/img_archetype_10.jpg',
                                    isLocked: true,
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: _buildAffirmationCard(
                                    title: 'Calm your anxiety',
                                    imagePath:
                                        'assets/images/img_archetype_12.jpg',
                                    isLocked: true,
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: _buildAffirmationCard(
                                    title: 'Nurture self-love',
                                    imagePath:
                                        'assets/images/img_archetype_14.jpg',
                                    isLocked: true,
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Empower yourself section
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Empower yourself',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Overcome self-doubt and increase your self-confidence',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Empowerment affirmations
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: _buildAffirmationCard(
                                    title: 'Build self-confidence',
                                    imagePath:
                                        'assets/images/img_archetype_16.jpg',
                                    isLocked: true,
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: _buildAffirmationCard(
                                    title: 'Be yourself',
                                    imagePath:
                                        'assets/images/img_archetype_19.jpg',
                                    isLocked: true,
                                    onTap: () => Navigator.pop(context),
                                  ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    bool isSelected = false,
    bool isLocked = false,
    String? imagePath,
    VoidCallback? onTap,
  }) {
    // Use existing images from the assets folder
    final String finalImagePath =
        imagePath ?? 'assets/images/img_archetype_5.jpg';

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(finalImagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(isLocked ? 0.7 : 0.4),
              BlendMode.darken,
            ),
          ),
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
        child: Stack(
          children: [
            // Category title
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            // Lock icon if category is locked
            if (isLocked)
              const Positioned(
                top: 16,
                right: 16,
                child: Icon(Icons.lock, color: Colors.white, size: 24),
              ),
            // Selected check if category is selected
            if (isSelected)
              const Positioned(
                top: 16,
                right: 16,
                child: Icon(Icons.check_circle, color: Colors.white, size: 24),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAffirmationCard({
    required String title,
    bool isLocked = false,
    String? imagePath,
    VoidCallback? onTap,
  }) {
    // Use existing images from the assets folder
    final String finalImagePath =
        imagePath ?? 'assets/images/img_archetype_10.jpg';

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(finalImagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(isLocked ? 0.7 : 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Affirmation title
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            // Lock icon if affirmation is locked
            if (isLocked)
              const Positioned(
                top: 16,
                right: 16,
                child: Icon(Icons.lock, color: Colors.white, size: 24),
              ),
          ],
        ),
      ),
    );
  }
}
