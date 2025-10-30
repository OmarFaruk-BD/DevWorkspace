import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspace/features/area/model/my_area_model.dart';

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

  Future<MyAreaModel?> getAssignLocationByEmployee(String assignedTo) async {
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
        return null;
      } else {
        final data = assignLocation.last;
        _logger.e(data);

        final myArea = MyAreaModel(
          longitude: data['long'],
          radius: data['radius'],
          latitude: data['lat'],
          start: data['start'],
          end: data['end'],
        );
        _logger.e(myArea.toString());
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
