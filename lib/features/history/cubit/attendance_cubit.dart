import 'package:bloc/bloc.dart';
import 'package:workspace/features/history/service/attendance_service.dart';
import 'package:workspace/features/history/model/attendance_detail_model.dart';
import 'package:workspace/features/history/model/attendance_history_model.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  void updateAttendanceOverview() async {
    await AttendanceService().getAttendanceOverview();
  }

  void updateAttendanceDetails() async {
    final attendanceDetail = await AttendanceService().getAttendanceDetails();
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
