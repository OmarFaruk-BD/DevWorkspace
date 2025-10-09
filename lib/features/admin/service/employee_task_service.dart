import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeTaskService {
  final Logger _logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, String>> createTask({
    required String assignedTo,
    required String title,
    required String description,
    required String priority,
    required String taskType,
    required String createdBy,
    required String client,
    required String contract,
    required String department,
    required String amount,
    required String dueDate,
    String comments = '',
    String attachments = '',
  }) async {
    try {
      final Map<String, dynamic> taskData = {
        'tasks': [
          {
            'title': title,
            'description': description,
            'priority': priority,
            'taskType': taskType,
            'comments': comments,
            'attachments': attachments,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
            'createdBy': createdBy,
            'client': client,
            'contract': contract,
            'department': department,
            'amount': amount,
          },
        ],
        'assignedTo': assignedTo,
        'dueDate': dueDate,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('tasks').add(taskData);

      return const Right('Task created successfully.');
    } catch (e) {
      _logger.e('Error creating task: $e');
      return Left('Failed to create task: $e');
    }
  }

  Future<Either<String, String>> addTaskToEmployee({
    required String taskDocId,
    required Map<String, dynamic> newTask,
  }) async {
    try {
      newTask['createdAt'] = FieldValue.serverTimestamp();
      newTask['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection('tasks').doc(taskDocId).update({
        'tasks': FieldValue.arrayUnion([newTask]),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return const Right('Task list updated successfully.');
    } catch (e) {
      _logger.e('Error updating task list: $e');
      return Left('Failed to update task list: $e');
    }
  }
}
