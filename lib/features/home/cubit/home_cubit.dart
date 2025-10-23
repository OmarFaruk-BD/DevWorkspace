import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:workspace/core/service/location_service.dart';
import 'package:workspace/features/area/model/my_area_model.dart';
import 'package:workspace/features/home/service/home_service.dart';
import 'package:workspace/features/history/service/attendance_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    updateTime();
    checkPunchIn();
  }

  final AttendanceService _attendanceService = AttendanceService();
  final LocationService _locationService = LocationService();
  final HomeService _homeService = HomeService();

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

  void updateMyArea(BuildContext context) async {
    final myAreaModel = await _homeService.getAssignLocationByEmployee(context);
    emit(state.copyWith(myArea: myAreaModel));
    final address = await _locationService.getMyLocation();
    emit(state.copyWith(address: address?.fullAddress));
  }

  void checkPunchIn() async {
    final attendanceDetail = await _attendanceService.getAttendanceDetails();
    if (attendanceDetail?.punchIn != null &&
        attendanceDetail?.punchOut == null) {
      punch(true);
    }
  }

  void punch(bool isPunchIn) {
    emit(state.copyWith(punchedIn: isPunchIn));
  }
}
