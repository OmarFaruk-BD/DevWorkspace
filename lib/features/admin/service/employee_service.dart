import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:workspace/features/auth/model/user_model.dart';

class EmployeeService {
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, String>> createEmployee({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String position,
    required String department,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'role': 'employee',
        'position': position,
        'department': department,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return Right('Employee created successfully.');
    } on FirebaseAuthException catch (e) {
      _logger.e("FirebaseAuthException: ${e.message}");
      if (e.code == 'email-already-in-use') {
        return Left("This email is already registered.");
      } else if (e.code == 'weak-password') {
        return Left("Password is too weak. Please use a stronger one.");
      } else {
        return Left("Authentication error: ${e.message}");
      }
    } catch (e) {
      return Left("Failed to create employee: $e");
    }
  }

  Future<List<UserModel>> getAllEmployees() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'employee')
          .orderBy('createdAt', descending: true)
          .get();

      final employees = querySnapshot.docs.map((doc) {
        return UserModel(
          id: doc['uid'],
          name: doc['name'],
          email: doc['email'],
          phone: doc['phone'],
          password: doc['password'],
          position: doc['position'],
          department: doc['department'],
          createdAt: (doc['createdAt'] as Timestamp).toDate(),
        );
      }).toList();

      return employees;
    } catch (e) {
      _logger.e("Error fetching employees: $e");
      return [];
    }
  }
}
