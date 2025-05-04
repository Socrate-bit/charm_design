import 'package:flutter/material.dart';

enum AffirmationMusicType {
  none,
  nature,
  meditation,
  ambient,
  piano,
  ocean,
  rainforest,
}

class AffirmationMusic {
  final String name;
  final String description;
  final String assetPath;
  final bool isNetworkAsset;
  final AffirmationMusicType type;
  final Color accentColor;
  final IconData icon;
  
  const AffirmationMusic({
    required this.name,
    required this.description,
    required this.assetPath,
    this.isNetworkAsset = false,
    required this.type,
    required this.accentColor,
    required this.icon,
  });
  
  static const AffirmationMusic none = AffirmationMusic(
    name: 'None',
    description: 'No background music',
    assetPath: '',
    type: AffirmationMusicType.none,
    accentColor: Colors.grey,
    icon: Icons.music_off,
  );
  
  static const AffirmationMusic nature = AffirmationMusic(
    name: 'Nature',
    description: 'Peaceful natural sounds',
    assetPath: 'assets/audio/nature.mp3',
    type: AffirmationMusicType.nature,
    accentColor: Color(0xFF4CAF50),
    icon: Icons.forest,
  );
  
  static const AffirmationMusic meditation = AffirmationMusic(
    name: 'Meditation',
    description: 'Calm meditation melody',
    assetPath: 'assets/audio/meditation.mp3',
    type: AffirmationMusicType.meditation,
    accentColor: Color(0xFF9C27B0),
    icon: Icons.self_improvement,
  );
  
  static const AffirmationMusic ambient = AffirmationMusic(
    name: 'Ambient',
    description: 'Gentle ambient tones',
    assetPath: 'assets/audio/ambient.mp3',
    type: AffirmationMusicType.ambient,
    accentColor: Color(0xFF2196F3),
    icon: Icons.waves,
  );
  
  static const AffirmationMusic piano = AffirmationMusic(
    name: 'Piano',
    description: 'Soft piano melodies',
    assetPath: 'assets/audio/piano.mp3',
    type: AffirmationMusicType.piano,
    accentColor: Color(0xFF795548),
    icon: Icons.piano,
  );
  
  static const AffirmationMusic ocean = AffirmationMusic(
    name: 'Ocean',
    description: 'Calming ocean waves',
    assetPath: 'assets/audio/ocean.mp3',
    type: AffirmationMusicType.ocean,
    accentColor: Color(0xFF03A9F4),
    icon: Icons.water,
  );
  
  static const AffirmationMusic rainforest = AffirmationMusic(
    name: 'Rainforest',
    description: 'Soothing rainforest sounds',
    assetPath: 'assets/audio/rainforest.mp3',
    type: AffirmationMusicType.rainforest,
    accentColor: Color(0xFF8BC34A),
    icon: Icons.terrain,
  );
  
  static List<AffirmationMusic> get allMusic => [
    none, nature, meditation, ambient, piano, ocean, rainforest
  ];
} 