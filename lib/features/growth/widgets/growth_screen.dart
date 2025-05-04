import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class GrowthScreen extends StatelessWidget {
  const GrowthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Explore section header
                Text(
                  'Explore',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Find content that helps you grow and achieve your goals',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Search bar
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search, 
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search entire library',
                            hintStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onChanged: (value) {
                            // Search functionality would be implemented here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Category buttons
                _buildCategoryRow(
                  context,
                  [
                    CategoryButtonData(
                      icon: Icons.sentiment_satisfied_alt,
                      color: const Color(0xFFFFD166),
                      label: 'Mood',
                    ),
                    CategoryButtonData(
                      icon: Icons.favorite,
                      color: const Color(0xFFF8AFA6),
                      label: 'Love',
                    ),
                    CategoryButtonData(
                      icon: Icons.emoji_events,
                      color: const Color(0xFF7ED957),
                      label: 'Success',
                    ),
                  ],
                ),
                
                _buildCategoryRow(
                  context,
                  [
                    CategoryButtonData(
                      icon: Icons.self_improvement,
                      color: const Color(0xFF6FB6FF),
                      label: 'Confidence',
                    ),
                    CategoryButtonData(
                      icon: Icons.spa,
                      color: const Color(0xFFB87AFF),
                      label: 'Relaxation',
                    ),
                    CategoryButtonData(
                      icon: Icons.nightlight_round,
                      color: const Color(0xFF5E72EB),
                      label: 'Sleep',
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Featured section
                Text(
                  'Featured',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Trending content just for you',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Featured content cards (horizontally scrollable)
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
                        title: 'Morning Motivation',
                        subtitle: 'NARRATIVE SESSION',
                        duration: '5 MIN',
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1552693673-1bf958298935',
                        title: 'Sunset Reflection',
                        subtitle: 'GUIDED MEDITATION',
                        duration: '10 MIN',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Upcoming workshops section (moved here as requested)
                Text(
                  'Upcoming Workshops',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildWorkshopItem(
                  context,
                  title: 'Journaling Workshop',
                  date: 'May 15, 2023 • 2:00 PM',
                  participants: 28,
                ),
                
                const SizedBox(height: 12),
                
                _buildWorkshopItem(
                  context,
                  title: 'Positive Affirmations',
                  date: 'May 22, 2023 • 3:30 PM',
                  participants: 42,
                ),
                
                const SizedBox(height: 12),
                
                _buildWorkshopItem(
                  context,
                  title: 'Visualization Techniques',
                  date: 'June 5, 2023 • 1:00 PM',
                  participants: 15,
                ),
                
                const SizedBox(height: 32),
                
                // Recently added section
                Text(
                  'Recently added',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Check out our newest content',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Recent content cards (horizontally scrollable)
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1519834785169-98be25ec3f84',
                        title: 'New Beginnings',
                        subtitle: 'VISUALIZATION',
                        duration: '8 MIN',
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1490730141103-6cac27aaab94',
                        title: 'Dawn of Possibilities',
                        subtitle: 'MORNING ROUTINE',
                        duration: '12 MIN',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Affirmations sets section
                Text(
                  'Affirmations sets',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Positive words to transform your mindset',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Affirmations content cards
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7',
                        title: 'Self-Love Journey',
                        subtitle: '30 AFFIRMATIONS',
                        duration: '5 MIN',
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1553729459-efe14ef6055d',
                        title: 'Abundance Mindset',
                        subtitle: '25 AFFIRMATIONS',
                        duration: '4 MIN',
                        isPremium: true,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Contents section
                Text(
                  'Contents',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore our full library of resources',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Contents cards
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1512438248247-f0f2a5a8b7f0',
                        title: 'Gratitude Practice',
                        subtitle: 'JOURNALING GUIDE',
                        duration: '15 MIN',
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1528319725582-ddc096101511',
                        title: 'Inner Peace',
                        subtitle: 'AUDIO COURSE',
                        duration: '45 MIN',
                        isPremium: true,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Manifestations section
                Text(
                  'Manifestations',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, 
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bring your dreams into reality',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Manifestations cards
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1501139083538-0139583c060f',
                        title: 'Vision Board',
                        subtitle: 'GUIDED PRACTICE',
                        duration: '20 MIN',
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1517960413843-0aee8e2b3285',
                        title: 'Law of Attraction',
                        subtitle: 'VISUALIZATION TECHNIQUE',
                        duration: '15 MIN',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Meditations section
                Text(
                  'Meditations',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Find your inner calm and balance',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Meditations cards
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1518199266791-5375a83190b7',
                        title: 'Body Scan',
                        subtitle: 'MINDFULNESS PRACTICE',
                        duration: '10 MIN',
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1593811167562-9cef47bfc4d7',
                        title: 'Loving-Kindness',
                        subtitle: 'GUIDED MEDITATION',
                        duration: '15 MIN',
                        isPremium: true,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Breathing exercises section
                Text(
                  'Breathing exercises',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Harness the power of your breath',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Breathing exercises cards
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1517021897933-0e0319cfbc28',
                        title: '4-7-8 Technique',
                        subtitle: 'CALMING BREATH',
                        duration: '5 MIN',
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
                        title: 'Box Breathing',
                        subtitle: 'FOCUS EXERCISE',
                        duration: '8 MIN',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Challenges section
                Text(
                  'Challenges',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Push yourself to grow with guided challenges',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Challenges cards
                SizedBox(
                  height: 200,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1484627147104-f5197bcd6651',
                        title: '30 Days of Gratitude',
                        subtitle: 'DAILY CHALLENGE',
                        duration: '5 MIN/DAY',
                        isPremium: true,
                      ),
                      const SizedBox(width: 16),
                      _buildContentCard(
                        image: 'https://images.unsplash.com/photo-1508672019048-805c876b67e2',
                        title: '7-Day Mindfulness',
                        subtitle: 'BEGINNER CHALLENGE',
                        duration: '10 MIN/DAY',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryRow(BuildContext context, List<CategoryButtonData> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: categories.map((category) {
          if (category.icon == null) {
            return const Expanded(child: SizedBox()); // Empty space for third column
          }
          
          return _buildCategoryButton(
            context,
            icon: category.icon!,
            color: category.color,
            label: category.label,
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildCategoryButton(
    BuildContext context, {
    required IconData icon, 
    required Color color,
    required String label,
  }) {
    final theme = Theme.of(context);
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContentCard({
    required String image,
    required String title,
    required String subtitle,
    required String duration,
    bool isPremium = false,
  }) {
    return Container(
      width: 280,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: image.startsWith('http') 
              ? NetworkImage(image) as ImageProvider
              : AssetImage(image),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            debugPrint('Error loading image: $image');
            // Use a fallback image in case of error
          },
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          
          // Lock icon
          if (isPremium)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          
          // Duration badge
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.headphones,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content info
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWorkshopItem(
    BuildContext context, {
    required String title,
    required String date,
    required int participants,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '$participants',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'joined',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper class for category buttons
class CategoryButtonData {
  final IconData? icon;
  final Color color;
  final String label;
  
  CategoryButtonData({
    required this.icon,
    required this.color,
    required this.label,
  });
} 