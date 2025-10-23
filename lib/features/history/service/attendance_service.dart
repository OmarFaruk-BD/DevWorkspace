import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/api/api_client.dart';
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

  Future<AttendanceDetailModel?> getAttendanceDetails() async {
    try {
      final date = DateTime.now().toDateString('yyyy-MM-dd');
      Map<String, dynamic> params = {'date': date};
      final response = await ApiClient().get(
        path: 'Endpoints.attendanceDetails',
        params: params,
      );
      // Logger().e(params);
      // response.print();
      AttendanceDetailModel attendanceModel = AttendanceDetailModel.fromMap(
        response.response?.data,
      );
      return attendanceModel;
    } catch (e) {
      // Logger().e(e);
      return null;
    }
  }

  Future<List<AttendanceHistoryModel>> getAttendanceHistory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      Map<String, dynamic> params = {
        'start_date': startDate.toDateString('yyyy-MM-dd'),
        'end_date': endDate.toDateString('yyyy-MM-dd'),
      };
      final response = await ApiClient().get(
        path: 'Endpoints.attendanceHistory',
        params: params,
      );
      Logger().e(params);
      response.print();
      List<AttendanceHistoryModel> attendanceModel =
          AttendanceHistoryResModel.fromMap(response.response?.data).data ?? [];
      return attendanceModel;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
