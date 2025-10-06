import 'package:logger/logger.dart';
import 'package:workspace/core/api/api_client.dart';
import 'package:workspace/features/home/model/notification_model.dart';

class NotificationService {
  Future<List<NotificationModel>> getNotificationList({
    int? page,
    int? perPage,
  }) async {
    try {
      Map<String, dynamic> params = {'page': page, 'per_page': perPage};
      final response = await ApiClient().get(
        path: 'Endpoints.notification',
        params: params,
      );
      response.print();
      Logger().e(response.response?.data);
      NotificationResModel notificationModel = NotificationResModel.fromMap(
        response.response?.data,
      );
      List<NotificationModel> dataList = notificationModel.data?.data ?? [];
      return dataList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<NotificationModel?> getNotificationDetail(String? id) async {
    try {
      Map<String, dynamic> params = {'alert_id': id};
      final response = await ApiClient().get(
        path: 'Endpoints.notificationDetail',
        params: params,
      );
      response.print();
      NotificationModel notificationModel = NotificationModel.fromMap(
        response.response?.data['data'],
      );
      return notificationModel;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
