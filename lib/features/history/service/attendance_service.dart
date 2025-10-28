import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspace/core/helper/extention.dart';
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

      if (attendanceList.isNotEmpty) {
        List<AttendanceHistoryModel> dataList = [];
        for (final item in attendanceList) {
          final punchDate = DateTime.tryParse(item['date']);
          final day = punchDate?.day.toString() ?? '';
          final dayName = punchDate?.toDateString('EE');
          if (item['assignTo'] != assignedTo) continue;
          final getData = AttendanceHistoryModel(
            punchDate: punchDate,
            punchIn: item['time'],
            punchOut: item['time'],
            totalHours: '????',
            day: day,
            dayName: dayName,
            monthYear: '',
          );
          dataList.add(getData);
        }
        return dataList;
      }
      return [];
    } on FirebaseException catch (e) {
      _logger.e('TodayAttendanceEmployee: ${e.message}');
      return [];
    } catch (e) {
      _logger.e('TodayAttendanceEmployee: $e');
      return [];
    }
  }
}
