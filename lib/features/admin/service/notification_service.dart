import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeNotificationService {
  final Logger _logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Create a new task document
  Future<Either<String, String>> createNotification({
    required String assignedTo,
    required String title,
    required String description,
    required String priority,
    required String date,
    required String comments,
  }) async {
    try {
      final Map<String, dynamic> taskData = {
        'date': date,
        'title': title,
        'priority': priority,
        'comments': comments,
        'assignedTo': assignedTo,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      _logger.e(taskData);

      await _firestore.collection('notification').add(taskData);

      return const Right('Notification created successfully.');
    } catch (e) {
      _logger.e('Error creating notification: $e');
      return Left('Failed to create notification: $e');
    }
  }

  /// ✏️ Edit (update) an existing task by its document ID
  Future<Either<String, String>> editNotification({
    required String taskId,
    required Map<String, dynamic> updatedFields,
  }) async {
    try {
      updatedFields['updatedAt'] = FieldValue.serverTimestamp();
      _logger.e(updatedFields);

      await _firestore
          .collection('notification')
          .doc(taskId)
          .update(updatedFields);

      return const Right('Task updated successfully.');
    } on FirebaseException catch (e) {
      _logger.e('Firebase error editing task: ${e.message}');
      return Left('Failed to update task: ${e.message}');
    } catch (e) {
      _logger.e('Error editing task: $e');
      return Left('Failed to edit task: $e');
    }
  }

  /// 🗑️ Delete a task by its document ID
  Future<Either<String, String>> deleteDelete(String taskId) async {
    try {
      await _firestore.collection('notification').doc(taskId).delete();
      return const Right('Notification deleted successfully.');
    } on FirebaseException catch (e) {
      _logger.e('Firebase error deleting notification: ${e.message}');
      return Left('Failed to delete notification: ${e.message}');
    } catch (e) {
      _logger.e('Error deleting notification: $e');
      return Left('Failed to delete notification: $e');
    }
  }

  /// 📋 Get all notification assigned to a specific employee
  Future<List<Map<String, dynamic>>> getnotificationByEmployee(
    String assignedTo,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('notification')
          .where('assignedTo', isEqualTo: assignedTo)
          // .orderBy('createdAt', descending: true)
          .get();

      final notification = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      return notification;
    } on FirebaseException catch (e) {
      _logger.e('Firebase error fetching notification: ${e.message}');
      return [];
    } catch (e) {
      _logger.e('Error fetching notification: $e');
      return [];
    }
  }
}
