import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspace/features/auth/model/user_model.dart';

class EmployeeService {
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
        'role': 'employee',
        'position': position,
        'department': department,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return Right(uid);
    } on FirebaseAuthException catch (e) {
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

  Future<Either<String, List<UserModel>>> getAllEmployees() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'employee')
          .orderBy('createdAt', descending: true)
          .get();

      // Convert documents into a list of maps
      final employees = querySnapshot.docs.map((doc) {
        return UserModel(
          id: doc['uid'],
          name: doc['name'],
          email: doc['email'],
          phone: doc['phone'],
          position: doc['position'],
          department: doc['department'],
          createdAt: doc['createdAt'],
        );
      }).toList();

      return Right(employees);
    } catch (e) {
      return Left("Failed to fetch employees: $e");
    }
  }
}
