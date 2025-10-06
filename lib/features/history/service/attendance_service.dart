import 'package:logger/logger.dart';
import 'package:workspace/core/api/api_client.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:workspace/features/history/model/attendance_detail_model.dart';
import 'package:workspace/features/history/model/attendance_history_model.dart';

class AttendanceService {
  Future<void> getAttendanceOverview() async {
    try {
      final date = DateTime.now().toDateString('yyyy-MM-dd');
      Map<String, dynamic> params = {'date': date};
      final response = await ApiClient().get(
        path: 'Endpoints.overview',
        params: params,
      );
      Logger().e(params);
      response.print();
    } catch (e) {
      Logger().e(e);
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
      Logger().e(params);
      response.print();
      AttendanceDetailModel attendanceModel = AttendanceDetailModel.fromMap(
        response.response?.data,
      );
      return attendanceModel;
    } catch (e) {
      Logger().e(e);
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
