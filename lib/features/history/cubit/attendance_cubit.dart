import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:workspace/features/history/service/attendance_service.dart';
import 'package:workspace/features/history/model/attendance_detail_model.dart';
import 'package:workspace/features/history/model/attendance_history_model.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());
  final AttendanceService _attendanceService = AttendanceService();

  void updateAttendanceDetails(BuildContext context) async {
    final attendanceDetail = await _attendanceService
        .getTodayAttendanceEmployee(context);
    emit(state.copyWith(attendanceDetail: attendanceDetail));
  }

  void updateAttendanceHistory({DateTime? startDate, DateTime? endDate}) async {
    if (startDate == null || endDate == null) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final dataList = await AttendanceService().getAttendanceHistory(
      startDate: startDate,
      endDate: endDate,
    );
    emit(state.copyWith(attendanceHistoryList: dataList, isLoading: false));
  }
}
