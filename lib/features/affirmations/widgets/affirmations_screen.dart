import 'package:flutter/material.dart';
import '../view_model/affirmations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'category_selector.dart';
import 'theme_selector.dart';
import 'music_selector.dart';
import 'package:flutter/rendering.dart';

class AffirmationsScreen extends StatelessWidget {
  const AffirmationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AffirmationsCubit(),
      child: BlocBuilder<AffirmationsCubit, AffirmationsState>(
        builder: (context, state) {
          return Scaffold(
            body: PageView(
              scrollDirection: Axis.vertical,
              controller: PageController(
                initialPage: state.selectedAffirmationIndex,
              ),
              onPageChanged: (index) {
                context.read<AffirmationsCubit>().selectAffirmation(index);
              },
              children: [
                _buildAffirmationPage(
                  context,
                  'I receive all feedback with kindness but make the final call myself.',
                  state,
                ),
                _buildAffirmationPage(
                  context,
                  'The goal is progress over perfection.',
                  state,
                ),
                _buildAffirmationPage(
                  context,
                  'Believe in yourself and all that you are.',
                  state,
                ),
                _buildAffirmationPage(
                  context,
                  'Every day is a second chance.',
                  state,
                ),
                _buildAffirmationPage(
                  context,
                  'You are stronger than you think.',
                  state,
                ),
                _buildAffirmationPage(
                  context,
                  'Your potential is endless.',
                  state,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureButton(
    IconData icon,
    String label, {
    bool hasNotification = false,
    VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, {VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.2),
      ),
      child: IconButton(
        onPressed: onPressed ?? () {},
        icon: Icon(icon, size: 24, color: Colors.white),
      ),
    );
  }

  Widget _buildPlayButton({
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.play_arrow, size: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildAffirmationPage(
    BuildContext context,
    String text,
    AffirmationsState state,
  ) {
    final theme = state.selectedTheme;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              theme.isNetworkImage
                  ? NetworkImage(theme.backgroundImage)
                  : AssetImage(theme.backgroundImage) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.overlayColor.withOpacity(theme.overlayOpacity),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top feature buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildFeatureButton(
                      Icons.music_note,
                      'MUSIC',
                      onPressed: () => _showMusicSelector(context),
                    ),
                    const SizedBox(width: 16),
                    _buildFeatureButton(
                      Icons.color_lens,
                      'THEME',
                      onPressed: () => _showThemeSelector(context),
                    ),
                  ],
                ),
              ),

              // Main affirmation text
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: theme.textColor,
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildActionButton(Icons.bookmark_border),
                          const SizedBox(width: 24),
                          _buildActionButton(Icons.share),
                          const SizedBox(width: 24),
                          _buildActionButton(Icons.favorite_border),
                          const SizedBox(width: 24),
                          _buildActionButton(Icons.play_arrow),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Categories and Play button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category button aligned left
                    GestureDetector(
                      onTap: () => _showCategorySelector(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.grid_view, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'CATEGORIES',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'General',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Play button aligned right
                    _buildPlayButton(
                      onPressed: () => _showPracticeOptions(context),
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategorySelector(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double statusBarHeight = mediaQuery.padding.top;
    // Get the current cubit instance
    final cubit = context.read<AffirmationsCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      constraints: BoxConstraints(maxHeight: mediaQuery.size.height),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: mediaQuery.size.height,
            padding: EdgeInsets.only(top: statusBarHeight),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
            ),
            // Wrap CategorySelector with BlocProvider
            child: BlocProvider.value(value: cubit, child: CategorySelector()),
          ),
        );
      },
    );
  }

  void _showThemeSelector(BuildContext context) {
    // Get the current cubit instance
    final cubit = context.read<AffirmationsCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: BlocProvider.value(value: cubit, child: ThemeSelector()),
          ),
        );
      },
    );
  }

  void _showMusicSelector(BuildContext context) {
    // Get the current cubit instance
    final cubit = context.read<AffirmationsCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: BlocProvider.value(value: cubit, child: MusicSelector()),
          ),
        );
      },
    );
  }

  void _showPracticeOptions(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        // Calculate the width of each option (accounting for spacing and padding)
        final double optionWidth =
            (screenWidth - 76) /
            3; // 96 = (2 * edge padding) + (2 * spacing between items)

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        margin: const EdgeInsets.only(bottom: 32),
                      ),
                    ),

                    // Headphones icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFF493C37),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.headphones,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      'Practice sessions',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Whether you want a quick boost or a deeper dive, we\'ve got you covered.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Session options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: optionWidth,
                          child: _buildSessionOption(
                            icon: Icons.person,
                            title: 'Personalized',
                            description: 'For you',
                            onTap: () => Navigator.pop(context),
                          ),
                        ),

                        const SizedBox(width: 12),

                        SizedBox(
                          width: optionWidth,
                          child: _buildSessionOption(
                            icon: Icons.collections_bookmark,
                            title: 'Collections',
                            description: 'Themed sets',
                            onTap: () => Navigator.pop(context),
                          ),
                        ),

                        const SizedBox(width: 12),

                        SizedBox(
                          width: optionWidth,
                          child: _buildSessionOption(
                            icon: Icons.psychology,
                            title: 'AI Reframe',
                            description: 'Specific',
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSessionOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
