import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  Padding paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Padding paddingSym({double? h, double? v}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h ?? 0, vertical: v ?? 0),
      child: this,
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String shorten([int count = 15]) {
    return length >= count ? substring(0, count) : this;
  }

  String ellipsis([int count = 15]) {
    return length >= count ? '${substring(0, count)}...' : this;
  }

  String truncateFromEnd([int count = 15]) {
    return length >= count ? '...${substring(length - count)}' : this;
  }
}

extension DateTimeFormatting on DateTime? {
  String? toDateString(String format) {
    if (this == null) return null;
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this!);
  }

  /// - `'yyyy-MM-dd'` → `2024-01-01`
  /// - `'dd-MM-yyyy'` → `01-01-2024`
  /// - `'dd-MM-yyyy hh:mm a'` → `01-01-2024 12:30 PM`
  /// - `'dd-MM-yyyy hh:mm:ss a'` → `01-01-2024 12:30:45 PM`
}

extension DateTimeFormatting2 on DateTimeRange? {
  String? toDateRangeString() {
    if (this == null) return null;
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return '${formatter.format(this!.start)} - ${formatter.format(this!.end)}';
  }
}
