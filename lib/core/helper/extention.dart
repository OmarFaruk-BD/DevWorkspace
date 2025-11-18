import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String? {
  String? capitalize() {
    if (this == null || this!.isEmpty) return null;
    return "${this![0].toUpperCase()}${this!.substring(1)}";
  }

  String? shorten([int count = 15]) {
    if (this == null || this!.isEmpty) return null;
    return this!.length >= count ? this!.substring(0, count) : this!;
  }

  String? ellipsis([int count = 15]) {
    if (this == null || this!.isEmpty) return null;
    return this!.length >= count ? '${this!.substring(0, count)}...' : this!;
  }

  String? truncateFromEnd([int count = 15]) {
    if (this == null || this!.isEmpty) return null;
    final bool isLong = this!.length > count;
    return isLong ? '...${this!.substring(this!.length - count)}' : this!;
  }

  String? toDateString() {
    if (this == null || this!.isEmpty) return null;
    final time = DateFormat("HH:mm:ss").tryParse(this!);
    return time != null ? DateFormat.jm().format(time) : null;
  }

  TimeOfDay? toTimeOfDay() {
    if (this == null || this!.isEmpty) return null;
    final format = DateFormat('hh:mm a');
    DateTime? dateTime = format.tryParse(this!);
    if (dateTime == null) return null;
    return TimeOfDay.fromDateTime(dateTime);
  }

  DateTime? stringToDate() {
    if (this == null || this!.isEmpty) return null;
    final formatter = DateFormat('MM-dd-yyyy');
    DateTime? dateTime = formatter.tryParse(this!);
    return dateTime;
  }
}

extension DateTimeFormatting on DateTime? {
  String? toDateString([String? format]) {
    if (this == null) return null;
    String getFormat = format ?? 'MM-dd-yyyy';
    final DateFormat formatter = DateFormat(getFormat);
    return formatter.format(this!);
  }

  String? showDate([String? format]) {
    if (this == null) return null;
    String getFormat = format ?? 'dd MMM yyyy';
    final DateFormat formatter = DateFormat(getFormat);
    return formatter.format(this!);
  }

  /// - `'yyyy-MM-dd'` → `2024-01-01`
  /// - `'dd-MM-yyyy'` → `01-01-2024`
  /// - `'dd-MM-yyyy hh:mm a'` → `01-01-2024 12:30 PM`
  /// - `'dd-MM-yyyy hh:mm:ss a'` → `01-01-2024 12:30:45 PM`
}
