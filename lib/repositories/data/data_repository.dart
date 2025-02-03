import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:sl_salt/models/readings.dart';
import 'package:sl_salt/models/users.dart';

class DataRepository {
  final CollectionReference _readingCollection = FirebaseFirestore.instance.collection('reading');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveData({
    required double morningReading1,
    required double morningReading2,
    required double eveningReading1,
    required double eveningReading2,
    required double dailyRainfall,
    required String pool,
    required DateTime dateOfReading,
    required String user,
  }) async {
    try {
      final dateOnlyReading = dateOnly(dateOfReading);
      final formattedDate = DateFormat('yyyy-MM-dd').format(dateOnlyReading).toString();
      // Query to check if a document already exists for the given date and user
      final querySnapshot =
          await _readingCollection.where('userId', isEqualTo: user).where('dateOfReading', isEqualTo: formattedDate.toString()).limit(1).get();

      ReadingModel reading;

      if (querySnapshot.docs.isNotEmpty) {
        // Document exists, update it
        final doc = querySnapshot.docs.first;
        reading = ReadingModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        // Document does not exist, create a new one
        reading = ReadingModel(
          id: _readingCollection.doc().id,
          userId: user,
          saltern: 'q', // Replace with actual saltern if needed
          dateOfReading: formattedDate,
          RF: dailyRainfall,
        );
      }

      // Update the readings based on the selected pool
      switch (pool) {
        case 'Box 1':
          reading.morningUpPool1 = morningReading1;
          reading.morningDownPool1 = morningReading2;
          reading.eveningUpPool1 = eveningReading1;
          reading.eveningDownPool1 = eveningReading2;
          break;
        case 'Box 2':
          reading.morningUpPool2 = morningReading1;
          reading.morningDownPool2 = morningReading2;
          reading.eveningUpPool2 = eveningReading1;
          reading.eveningDownPool2 = eveningReading2;
          break;
        case 'Box 3':
          reading.morningUpPool3 = morningReading1;
          reading.morningDownPool3 = morningReading2;
          reading.eveningUpPool3 = eveningReading1;
          reading.eveningDownPool3 = eveningReading2;
          break;
        default:
          throw Exception('Invalid pool selected: $pool');
      }

      // Save or update the document in Firestore
      await _readingCollection.doc(reading.id).set(reading.toJson());

      print('✅ Data successfully saved: ${reading.toJson()}');
    } catch (e) {
      print('❌ Error saving data: $e');
      throw Exception('Failed to save data: $e');
    }
  }
}

DateTime dateOnly(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
