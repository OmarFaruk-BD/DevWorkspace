import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workspace/features/auth/cubit/auth_cubit.dart';
import 'package:workspace/features/history/model/attendance_detail_model.dart';
import 'package:workspace/features/history/model/attendance_history_model.dart';

class AttendanceService {
  final Logger _logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AttendanceDetailModel?> getTodayAttendanceEmployee(
    BuildContext context,
  ) async {
    try {
      final user = context.read<AuthCubit>().state.user;
      final assignedTo = user?.id ?? '';

      final querySnapshot = await _firestore.collection('eAttendance').get();

      final attendanceList = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      if (attendanceList.isEmpty) {
        return null;
      } else {
        final lastAttendance = attendanceList.last;
        final date = DateTime.tryParse(lastAttendance['date']);
        if (date?.day == DateTime.now().day &&
            lastAttendance['assignTo'] == assignedTo) {
          final punchedIn = attendanceList.length.isOdd;
          final getLast = AttendanceDetailModel(
            date: lastAttendance['date'],
            day: lastAttendance['time'],
            punchIn: lastAttendance['time'],
            punchOut: punchedIn ? lastAttendance['time'] : null,
            punchInLocation: lastAttendance['latitude'],
            punchOutLocation: punchedIn ? lastAttendance['longitude'] : null,
            dutyLocation: [
              DutyLocation(
                latitude: lastAttendance['latitude'],
                longitude: lastAttendance['longitude'],
                address: lastAttendance['longitude'],
                time: lastAttendance['time'],
              ),
            ],
          );
          _logger.e('Last: ${getLast.toMap()}');
          return getLast;
        }
        return null;
      }
    } on FirebaseException catch (e) {
      _logger.e('TodayAttendanceEmployee: ${e.message}');
      return null;
    } catch (e) {
      _logger.e('TodayAttendanceEmployee: $e');
      return null;
    }
  }

  Future<List<AttendanceHistoryModel>> getAttendanceHistory({
    required BuildContext context,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final user = context.read<AuthCubit>().state.user;
      final assignedTo = user?.id ?? '';

      final querySnapshot = await _firestore.collection('eAttendance').get();

      final attendanceList = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      if (attendanceList.isEmpty) return [];

      // Step 1: Filter by assignedTo
      final filteredList = attendanceList
          .where((item) => item['assignTo'] == assignedTo)
          .toList();

      // Step 2: Group by date
      final Map<String, List<Map<String, dynamic>>> groupedByDate = {};

      for (final item in filteredList) {
        final date = item['date'];
        if (date == null) continue;
        groupedByDate.putIfAbsent(date, () => []);
        groupedByDate[date]!.add(item);
      }

      // Step 3: Process each date group
      final List<AttendanceHistoryModel> dataList = [];

      groupedByDate.forEach((date, entries) {
        // Parse times and sort them
        final times = entries.map((e) => e['time'] as String).toList();

        // Sort times to find earliest and latest
        times.sort((a, b) => a.compareTo(b));

        final punchIn = times.first; // earliest time
        final punchOut = times.last; // latest time

        final punchDate = DateTime.tryParse(date);
        final day = punchDate?.day.toString() ?? '';
        final dayName = punchDate?.toDateString('EE');
        final monthYear = punchDate?.toDateString('MM');

        // Optional: compute total hours difference
        final totalHours = _calculateTotalHours(punchIn, punchOut);

        final inTime = DateFormat("HH:mm:ss").parse(punchIn);
        final outTime = DateFormat("HH:mm:ss").parse(punchOut);

        dataList.add(
          AttendanceHistoryModel(
            punchDate: punchDate,
            punchIn: inTime.toDateString('hh:mm a'),
            punchOut: outTime.toDateString('hh:mm a'),
            totalHours: totalHours,
            day: day,
            dayName: dayName,
            monthYear: monthYear,
          ),
        );
      });

      return dataList;
    } on FirebaseException catch (e) {
      _logger.e('TodayAttendanceEmployee: ${e.message}');
      return [];
    } catch (e) {
      _logger.e('TodayAttendanceEmployee: $e');
      return [];
    }
  }

  String _calculateTotalHours(String punchIn, String punchOut) {
    try {
      final inTime = DateFormat("HH:mm:ss").parse(punchIn);
      final outTime = DateFormat("HH:mm:ss").parse(punchOut);

      final duration = outTime.difference(inTime);
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);

      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    } catch (e) {
      return '00:00';
    }
  }
}
