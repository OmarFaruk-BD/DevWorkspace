import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspace/core/components/app_compressor.dart';
import 'package:workspace/features/auth/model/user_model.dart';

class EmployeeService {
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AppImageCompressor _compressor = AppImageCompressor();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, String>> createEmployee({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String position,
    required String department,
    required String role,
    File? imageFile,
  }) async {
    try {
      // Step 1: Create user in Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      String? imageBase64;
      if (imageFile != null) {
        final compressedBytes = await _compressor.compressImageToBase64(
          imageFile,
        );
        imageBase64 = compressedBytes;
      }

      // Step 3: Save user data in Firestore
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'position': position,
        'department': department,
        'role': role.toLowerCase(),
        'imageUrl': imageBase64 ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      return const Right('Employee created successfully.');
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
      _logger.e("createEmployee Error: $e");
      return Left("Failed to create employee: $e");
    }
  }

  Future<List<UserModel>> getAllEmployees([String role = 'employee']) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: role.toLowerCase())
          .orderBy('createdAt', descending: true)
          .get();

      final employees = querySnapshot.docs.map((doc) {
        return UserModel(
          id: doc['uid'],
          name: doc['name'],
          email: doc['email'],
          phone: doc['phone'],
          role: doc['role'],
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

  Future<UserModel?> getEmployeeDetail(String uid) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(uid).get();
      if (!docSnapshot.exists) {
        _logger.w("No employee found with UID: $uid");
        return null;
      }

      final data = docSnapshot.data()!;
      return UserModel(
        id: data['uid'],
        name: data['name'],
        role: data['role'],
        email: data['email'],
        phone: data['phone'],
        password: data['password'],
        position: data['position'],
        department: data['department'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    } catch (e) {
      _logger.e("Error fetching employee detail: $e");
      return null;
    }
  }

  Future<UserModel?> getEmployeeWithImage(String? uid) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(uid).get();
      if (!docSnapshot.exists) {
        _logger.w("No employee found with UID: $uid");
        return null;
      }

      final data = docSnapshot.data()!;
      return UserModel(
        id: data['uid'],
        name: data['name'],
        role: data['role'],
        email: data['email'],
        phone: data['phone'],
        imageUrl: data['imageUrl'],
        password: data['password'],
        position: data['position'],
        department: data['department'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    } catch (e) {
      _logger.e("Error fetching employee detail: $e");
      return null;
    }
  }
}
