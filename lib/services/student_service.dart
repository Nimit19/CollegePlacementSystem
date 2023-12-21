import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/student.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String collectionName = 'studentsInfo';
  final User? user = FirebaseAuth.instance.currentUser;

  List<StudentInfo> _allStudents = [];

  Stream get studentInfo =>
      _firestore.collection(collectionName).doc(user!.uid).snapshots();

  Future<void> addStudent(StudentInfo studentInfo) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Use the UID as the document ID when adding the student
        await _firestore.collection(collectionName).doc(user.uid).set({
          'id': user.uid,
          'firstName': studentInfo.firstName,
          'lastName': studentInfo.lastName,
          'email': studentInfo.email,
          'number': studentInfo.number,
          'location': studentInfo.location,
          'isPlaced': studentInfo.isPlaced,
          'profileImgUrl': studentInfo.profileImgUrl,
        });
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error adding student: $e');
    }
  }

  Future<void> updateStudent(StudentInfo updatedStudentInfo) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the student document with the provided student ID (user.uid)
        await _firestore.collection(collectionName).doc(user.uid).update({
          'firstName': updatedStudentInfo.firstName,
          'lastName': updatedStudentInfo.lastName,
          'email': updatedStudentInfo.email,
          'number': updatedStudentInfo.number,
          'location': updatedStudentInfo.location,
          'isPlaced': updatedStudentInfo.isPlaced,
          'profileImgUrl': updatedStudentInfo.profileImgUrl,
        });
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  Future<StudentInfo?> getStudent() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final DocumentSnapshot documentSnapshot =
          await _firestore.collection(collectionName).doc(user!.uid).get();

      if (documentSnapshot.exists) {
        return StudentInfo(
          id: documentSnapshot['id'],
          firstName: documentSnapshot['firstName'],
          lastName: documentSnapshot['lastName'],
          email: documentSnapshot['email'],
          number: documentSnapshot['number'],
          location: documentSnapshot['location'],
          isPlaced: documentSnapshot['isPlaced'], // Add the new field
          profileImgUrl: documentSnapshot['profileImgUrl'],
        );
      }
    } catch (e) {
      print('Error getting student: $e');
    }
    return null;
  }

  Stream<StudentInfo?> getStudentDetails(String useId) {
    // final User? user = FirebaseAuth.instance.currentUser;
    return _firestore
        .collection(collectionName)
        .doc(useId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return StudentInfo(
          id: snapshot['id'],
          firstName: snapshot['firstName'],
          lastName: snapshot['lastName'],
          email: snapshot['email'],
          number: snapshot['number'],
          location: snapshot['location'],
          isPlaced: snapshot['isPlaced'], // Add the new field
          profileImgUrl: snapshot['profileImgUrl'],
        );
      } else {
        return null;
      }
    });
  }

  Stream<List<StudentInfo>> getAllStudentsStream() {
    return _firestore
        .collection(collectionName)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map(
              (doc) => StudentInfo(
                id: doc.id,
                firstName: doc.get('firstName'),
                lastName: doc.get('lastName'),
                email: doc.get('email'),
                number: doc.get('number'),
                location: doc.get('location'),
                isPlaced: doc.get('isPlaced'),
                profileImgUrl: doc.get('profileImgUrl'),
              ),
            )
            .toList();
      } else {
        return [];
      }
    });
  }

  Future<List<StudentInfo>> getAllStudents() async {
    try {
      final querySnapshot = await _firestore.collection(collectionName).get();

      if (querySnapshot.docs.isNotEmpty) {
        final loadedStudents = querySnapshot.docs
            .map(
              (doc) => StudentInfo(
                id: doc.id,
                firstName: doc.get('firstName'),
                lastName: doc.get('lastName'),
                email: doc.get('email'),
                number: doc.get('number'),
                location: doc.get('location'),
                isPlaced: doc.get('isPlaced'), // Add the new field
                profileImgUrl: doc.get('profileImgUrl'),
              ),
            )
            .toList();

        _allStudents = loadedStudents;

        return loadedStudents;
      } else {
        return [];
      }
    } catch (e) {
      // Handle errors here, e.g., by returning an empty list or rethrowing the exception.
      print('Error fetching students: $e');
      return [];
    }
  }

  Future<void> updateProfileImageUrl(String newImageUrl) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Create a map with only the 'profileImgUrl' field to update
        final updateData = {
          'profileImgUrl': newImageUrl,
        };

        // Update the student document with the provided student ID (user.uid)
        await _firestore
            .collection(collectionName)
            .doc(user.uid)
            .update(updateData);
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error updating profile image URL: $e');
    }
  }

  StudentInfo findById(String id) {
    return _allStudents.firstWhere((element) => element.id == id);
  }

  List<StudentInfo> get allStudentsLocal {
    return _allStudents;
  }
}
