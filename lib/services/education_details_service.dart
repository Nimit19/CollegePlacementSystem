import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/education.dart';

class EducationDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'educationDetails';

  Stream get educationDetails => _firestore
      .collection(collectionName)
      .snapshots(); // a stream that is continuously listening for changes happening in the database

  Future<void> addEducationDetails(EducationDetails educationDetails) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore.collection(collectionName).doc(user.uid).set({
          'id': user.uid,
          'tenthSchoolName': educationDetails.tenthSchoolName,
          'twelfthSchoolName': educationDetails.twelfthSchoolName,
          'tenthPercentage': educationDetails.tenthPercentage,
          'twelfthPercentage': educationDetails.twelfthPercentage,
          'collegeName': educationDetails.collegeName,
          'branch': educationDetails.branch,
          'sgpaList': educationDetails.sgpaList,
          'cgpa': educationDetails.cgpa,
        });
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error adding education details: $e');
    }
  }

  Future<void> updateEducationDetails(
      EducationDetails updatedEducationDetails) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the education details document with the provided student ID (user.uid)
        await _firestore.collection(collectionName).doc(user.uid).update({
          'tenthSchoolName': updatedEducationDetails.tenthSchoolName,
          'twelfthSchoolName': updatedEducationDetails.twelfthSchoolName,
          'tenthPercentage': updatedEducationDetails.tenthPercentage,
          'twelfthPercentage': updatedEducationDetails.twelfthPercentage,
          'collegeName': updatedEducationDetails.collegeName,
          'branch': updatedEducationDetails.branch,
          'sgpaList': updatedEducationDetails.sgpaList,
          'cgpa': updatedEducationDetails.cgpa,
        });
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error updating education details: $e');
    }
  }

  Future<EducationDetails?> getEducationInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final DocumentSnapshot documentSnapshot =
          await _firestore.collection(collectionName).doc(user!.uid).get();

      if (documentSnapshot.exists) {
        return EducationDetails(
          id: documentSnapshot['id'],
          tenthSchoolName: documentSnapshot['tenthSchoolName'],
          twelfthSchoolName: documentSnapshot['twelfthSchoolName'],
          tenthPercentage: documentSnapshot['tenthPercentage'],
          twelfthPercentage: documentSnapshot['twelfthPercentage'],
          collegeName: documentSnapshot['collegeName'],
          branch: documentSnapshot['branch'],
          sgpaList: List<double>.from(documentSnapshot['sgpaList']),
          cgpa: documentSnapshot['cgpa'],
        );
      }
    } catch (e) {
      print('Error getting education details: $e');
    }
    return null;
  }

  Stream<EducationDetails?> getEducationDetails(String userId) {
    return _firestore
        .collection(collectionName)
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return EducationDetails(
          id: snapshot['id'],
          tenthSchoolName: snapshot['tenthSchoolName'],
          twelfthSchoolName: snapshot['twelfthSchoolName'],
          tenthPercentage: snapshot['tenthPercentage'],
          twelfthPercentage: snapshot['twelfthPercentage'],
          collegeName: snapshot['collegeName'],
          branch: snapshot['branch'],
          sgpaList: List<double>.from(snapshot['sgpaList']),
          cgpa: snapshot['cgpa'],
        );
      } else {
        return null;
      }
    });
  }
}
