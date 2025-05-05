import 'package:flutter/material.dart';

enum AffirmationThemeType {
  nature,
  sunset,
  ocean,
  mountain,
  galaxy,
  minimal
}

class AffirmationTheme {
  final String name;
  final String backgroundImage;
  final bool isNetworkImage;
  final AffirmationThemeType type;
  final Color primaryColor;
  final Color textColor;
  final Color overlayColor;
  final double overlayOpacity;
  
  const AffirmationTheme({
    required this.name,
    required this.backgroundImage,
    this.isNetworkImage = false,
    required this.type,
    required this.primaryColor,
    required this.textColor,
    required this.overlayColor,
    this.overlayOpacity = 0.5,
  });
  
  static const AffirmationTheme nature = AffirmationTheme(
    name: 'Forest',
    backgroundImage: 'https://images.unsplash.com/photo-1448375240586-882707db888b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    isNetworkImage: true,
    type: AffirmationThemeType.nature,
    primaryColor: Color(0xFF2E7D32),
    textColor: Colors.white,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
  );
  
  static const AffirmationTheme sunset = AffirmationTheme(
    name: 'Sunset',
    backgroundImage: 'https://images.unsplash.com/photo-1475924156734-496f6cac6ec1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    isNetworkImage: true,
    type: AffirmationThemeType.sunset,
    primaryColor: Color(0xFFFF9800),
    textColor: Colors.white,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
  );
  
  static const AffirmationTheme ocean = AffirmationTheme(
    name: 'Ocean',
    backgroundImage: 'https://images.unsplash.com/photo-1483683804023-6ccdb62f86ef?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    isNetworkImage: true,
    type: AffirmationThemeType.ocean,
    primaryColor: Color(0xFF1976D2),
    textColor: Colors.white,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
  );
  
  static const AffirmationTheme mountain = AffirmationTheme(
    name: 'Mountain',
    backgroundImage: 'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    isNetworkImage: true,
    type: AffirmationThemeType.mountain,
    primaryColor: Color(0xFF455A64),
    textColor: Colors.white,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
  );
  
  static const AffirmationTheme galaxy = AffirmationTheme(
    name: 'Galaxy',
    backgroundImage: 'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    isNetworkImage: true,
    type: AffirmationThemeType.galaxy,
    primaryColor: Color(0xFF512DA8),
    textColor: Colors.white,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
  );
  
  static const AffirmationTheme minimal = AffirmationTheme(
    name: 'Minimal',
    backgroundImage: 'https://images.unsplash.com/photo-1541140134513-85a161dc4a00?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    isNetworkImage: true,
    type: AffirmationThemeType.minimal,
    primaryColor: Color(0xFF616161),
    textColor: Colors.white,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
  );
  
  static List<AffirmationTheme> get allThemes => [
    nature, sunset, ocean, mountain, galaxy, minimal
  ];
} 