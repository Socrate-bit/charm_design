import 'package:flutter/material.dart';

enum InteractionSessionStatus {
  inProgress,
  completed,
  analyzed
}

class InteractionSession {
  final String id;
  final DateTime dateTime;
  final String title;
  final String intention;
  final Duration duration;
  final InteractionSessionStatus status;
  final String? insightSummary;
  final double? alignmentScore;

  const InteractionSession({
    required this.id,
    required this.dateTime,
    required this.title,
    required this.intention,
    required this.duration,
    required this.status,
    this.insightSummary,
    this.alignmentScore,
  });

  InteractionSession copyWith({
    String? id,
    DateTime? dateTime,
    String? title,
    String? intention,
    Duration? duration,
    InteractionSessionStatus? status,
    String? insightSummary,
    double? alignmentScore,
  }) {
    return InteractionSession(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      title: title ?? this.title,
      intention: intention ?? this.intention,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      insightSummary: insightSummary ?? this.insightSummary,
      alignmentScore: alignmentScore ?? this.alignmentScore,
    );
  }
} 