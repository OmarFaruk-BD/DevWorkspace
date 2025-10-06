import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:workspace/core/api/api_client.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:workspace/features/area/model/my_area_model.dart';

class HomeService {
  Future<Either<String, String>> punchIn({
    String? latitude,
    String? longitude,
    String? address,
    bool isPunchIn = true,
  }) async {
    try {
      final dateTime = DateTime.now();
      String? date = dateTime.toDateString('yyyy-MM-dd');
      String? time = dateTime.toDateString('hh:mm:ss');
      Map<String, dynamic> payload = {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'date': date,
        'time': time,
      };
      final path = isPunchIn ? 'Endpoints.punchOut' : 'Endpoints.punchIn';
      final response = await ApiClient().post(path: path, data: payload);
      Logger().e(payload);
      response.print();
      return response.fold((f) => left(f.message()), (s) => right(s.message()));
    } catch (e) {
      Logger().e(e);
      return left('Something went wrong.');
    }
  }

  Future<MyAreaModel?> getMyArea() async {
    try {
      final response = await ApiClient().get(path: 'Endpoints.myArea');
      response.print();
      MyAreaModel myAreaModel = MyAreaModel.fromMap(
        response.response?.data['data'],
      );
      return myAreaModel;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
