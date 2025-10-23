import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EAssignLocationService {
  final Logger _logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Create a new task document
  Future<Either<String, String>> assignLocation({
    required String start,
    required String end,
    required String lat,
    required String long,
    required String radius,
    required String userId,
  }) async {
    try {
      final Map<String, dynamic> locationData = {
        'end': end,
        'lat': lat,
        'long': long,
        'start': start,
        'radius': radius,
        'assignedTo': userId,
        'createdAt': FieldValue.serverTimestamp(),
      };
      _logger.e(locationData);

      await _firestore.collection('assignLocation').add(locationData);

      return const Right('Location created successfully.');
    } catch (e) {
      _logger.e('Error creating task: $e');
      return Left('Failed to create location: $e');
    }
  }

  /// ✏️ Edit (update) an existing task by its document ID
  Future<Either<String, String>> editTask({
    required String taskId,
    required Map<String, dynamic> updatedFields,
  }) async {
    try {
      _logger.e(updatedFields);

      await _firestore
          .collection('assignLocation')
          .doc(taskId)
          .update(updatedFields);

      return const Right('Location updated successfully.');
    } on FirebaseException catch (e) {
      _logger.e('Firebase error editing Location: ${e.message}');
      return Left('Failed to update location: ${e.message}');
    } catch (e) {
      _logger.e('Error editing location: $e');
      return Left('Failed to edit location: $e');
    }
  }

  /// 🗑️ Delete a task by its document ID
  Future<Either<String, String>> deleteTask(String taskId) async {
    try {
      await _firestore.collection('assignLocation').doc(taskId).delete();
      return const Right('Location deleted successfully.');
    } on FirebaseException catch (e) {
      _logger.e('Firebase error deleting task: ${e.message}');
      return Left('Failed to delete location: ${e.message}');
    } catch (e) {
      _logger.e('Error deleting task: $e');
      return Left('Failed to delete location: $e');
    }
  }

  /// 📋 Get all assignLocation assigned to a specific employee
  Future<List<Map<String, dynamic>>> getAssignLocationListByEmployee(
    String assignedTo,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('assignLocation')
          .where('assignedTo', isEqualTo: assignedTo)
          .get();

      final assignLocation = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {'taskId': doc.id, ...data};
      }).toList();

      return assignLocation;
    } on FirebaseException catch (e) {
      _logger.e('Firebase error fetching assignLocation: ${e.message}');
      return [];
    } catch (e) {
      _logger.e('Error fetching assignLocation: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getAssignLocationByEmployee(
    String assignedTo,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('assignLocation')
          .where('assignedTo', isEqualTo: assignedTo)
          .get();

      final assignLocation = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {'taskId': doc.id, ...data};
      }).toList();
      if (assignLocation.isEmpty) {
        return {};
      } else {
        return assignLocation.last;
      }
    } on FirebaseException catch (e) {
      _logger.e('Firebase error fetching assignLocation: ${e.message}');
      return {};
    } catch (e) {
      _logger.e('Error fetching assignLocation: $e');
      return {};
    }
  }
}
