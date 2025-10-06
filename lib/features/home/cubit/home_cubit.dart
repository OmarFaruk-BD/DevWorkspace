import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:workspace/core/service/location_service.dart';
import 'package:workspace/features/area/model/my_area_model.dart';
import 'package:workspace/features/home/service/home_service.dart';
import 'package:workspace/features/history/service/attendance_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    updateTime();
    _checkPunchIn();
    updateMyArea();
  }

  void updateTime() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      emit(
        state.copyWith(
          time: DateTime.now().toDateString('hh:mm a'),
          date: DateTime.now().toDateString('dd MMMM yyyy, EEEE'),
        ),
      );
    });
  }

  void updateMyArea() async {
    final myAreaModel = await HomeService().getMyArea();
    emit(state.copyWith(myArea: myAreaModel));
    final address = await LocationService().getMyLocation();
    emit(state.copyWith(address: address?.fullAddress));
  }

  void _checkPunchIn() async {
    final attendanceDetail = await AttendanceService().getAttendanceDetails();
    if (attendanceDetail?.punchIn != null &&
        attendanceDetail?.punchOut == null) {
      punch(true);
    }
  }

  void punch(bool isPunchIn) {
    emit(state.copyWith(punchedIn: isPunchIn));
    updateMyArea();
  }
}
