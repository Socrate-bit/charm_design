import 'package:flutter/material.dart';
import 'affirmation_theme.dart';
import 'affirmation_music.dart';

class Affirmation {
  final String id;
  final String text;
  final DateTime createdAt;
  final String? authorId;
  final bool isFavorite;
  final AffirmationTheme theme;
  final AffirmationMusic? music;
  final int viewCount;
  final bool isPremium;

  const Affirmation({
    required this.id,
    required this.text,
    required this.createdAt,
    this.authorId,
    this.isFavorite = false,
    required this.theme,
    this.music,
    this.viewCount = 0,
    this.isPremium = false,
  });

  Affirmation copyWith({
    String? id,
    String? text,
    DateTime? createdAt,
    String? authorId,
    bool? isFavorite,
    AffirmationTheme? theme,
    AffirmationMusic? music,
    int? viewCount,
    bool? isPremium,
  }) {
    return Affirmation(
      id: id ?? this.id,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      authorId: authorId ?? this.authorId,
      isFavorite: isFavorite ?? this.isFavorite,
      theme: theme ?? this.theme,
      music: music ?? this.music,
      viewCount: viewCount ?? this.viewCount,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'authorId': authorId,
      'isFavorite': isFavorite,
      'themeType': theme.type.toString(),
      'musicPath': music?.assetPath,
      'viewCount': viewCount,
      'isPremium': isPremium,
    };
  }

  factory Affirmation.fromJson(Map<String, dynamic> json) {
    final themeType = AffirmationThemeType.values.firstWhere(
      (e) => e.toString() == json['themeType'],
      orElse: () => AffirmationThemeType.minimal,
    );
    
    final theme = AffirmationTheme.allThemes.firstWhere(
      (t) => t.type == themeType,
      orElse: () => AffirmationTheme.minimal,
    );
    
    AffirmationMusic? music;
    if (json['musicPath'] != null) {
      music = AffirmationMusic.allMusic.firstWhere(
        (m) => m.assetPath == json['musicPath'],
        orElse: () => AffirmationMusic.none,
      );
    }

    return Affirmation(
      id: json['id'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
      authorId: json['authorId'],
      isFavorite: json['isFavorite'] ?? false,
      theme: theme,
      music: music,
      viewCount: json['viewCount'] ?? 0,
      isPremium: json['isPremium'] ?? false,
    );
  }
} 