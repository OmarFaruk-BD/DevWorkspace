import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspace/features/area/model/my_area_model.dart';
import 'package:workspace/features/auth/cubit/auth_cubit.dart';

class HomeService {
  final Logger _logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, String>> createAttendance({
    required String longitude,
    required String latitude,
    required String assignTo,
    required String address,
    required bool isPunchIn,
  }) async {
    try {
      final dateTime = DateTime.now();
      String? date = dateTime.toDateString('yyyy-MM-dd');
      String? time = dateTime.toDateString('hh:mm:ss');
      Map<String, dynamic> payload = {
        'date': date,
        'time': time,
        'address': address,
        'latitude': latitude,
        'assignTo': assignTo,
        'longitude': longitude,
        'isPunchIn': isPunchIn,
        'createdAt': FieldValue.serverTimestamp(),
      };
      // _logger.e(payload);

      await _firestore.collection('eAttendance').add(payload);

      return const Right('Attendance created successfully.');
    } catch (e) {
      _logger.e('Error creating task: $e');
      return Left('Failed to create attendance: $e');
    }
  }

  // /// 📋 Get all assignLocation assigned to a specific employee
  // Future<List<Map<String, dynamic>>> getAssignLocationListByEmployee(
  //   String assignedTo,
  // ) async {
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection('assignLocation')
  //         .where('assignedTo', isEqualTo: assignedTo)
  //         .get();

  //     final assignLocation = querySnapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return {'taskId': doc.id, ...data};
  //     }).toList();

  //     return assignLocation;
  //   } on FirebaseException catch (e) {
  //     _logger.e('Firebase error fetching assignLocation: ${e.message}');
  //     return [];
  //   } catch (e) {
  //     _logger.e('Error fetching assignLocation: $e');
  //     return [];
  //   }
  // }

  Future<MyAreaModel?> getAssignLocationByEmployee(BuildContext context) async {
    try {
      final user = context.read<AuthCubit>().state.user;
      final assignedTo = user?.id ?? '';

      final querySnapshot = await _firestore
          .collection('assignLocation')
          .where('assignedTo', isEqualTo: assignedTo)
          .get();

      final assignLocation = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {'taskId': doc.id, ...data};
      }).toList();
      if (assignLocation.isEmpty) {
        return null;
      } else {
        final data = assignLocation.last;
        // _logger.e(data);

        final myArea = MyAreaModel(
          longitude: data['long'],
          radius: data['radius'],
          latitude: data['lat'],
          start: data['start'],
          end: data['end'],
        );
        // _logger.e(myArea.toString());
        return myArea;
      }
    } on FirebaseException catch (e) {
      _logger.e('Firebase error fetching assignLocation: ${e.message}');
      return null;
    } catch (e) {
      _logger.e('Error fetching assignLocation: $e');
      return null;
    }
  }
}
