import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../models/additional.dart';

class AdditionalDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'additionalDetails';

  Stream<AdditionalDetails?> getAdditionalDetailsStream(String userId) {
    return _firestore
        .collection(collectionName)
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return AdditionalDetails(
          id: snapshot['id'],
          aboutMe: snapshot['aboutMe'],
          skills: List<String>.from(snapshot['skills']),
          uploadedPdfPath: snapshot['uploadedPdfPath'],
        );
      } else {
        return null;
      }
    });
  }

  Future<AdditionalDetails?> getAdditionalDetailsFuture() async {
    final User? user = FirebaseAuth.instance.currentUser;
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection(collectionName).doc(user!.uid).get();

      if (snapshot.exists) {
        return AdditionalDetails(
          id: snapshot['id'],
          aboutMe: snapshot['aboutMe'],
          skills: List<String>.from(snapshot['skills']),
          uploadedPdfPath: snapshot['uploadedPdfPath'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching additional details: $e");
      return null; // Handle the error gracefully, return null, or throw an exception as needed.
    }
  }

  Future<String> uploadResumeToStorage(
    File resumeFile,
  ) async {
    final User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_resumes')
          .child('$uid.pdf');
      await storageRef.putFile(resumeFile);
      final resumeUrl = await storageRef.getDownloadURL();
      return resumeUrl;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addAdditionalDetails(AdditionalDetails additionalDetails) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore.collection(collectionName).doc(user.uid).set({
          'id': user.uid,
          'aboutMe': additionalDetails.aboutMe,
          'skills': additionalDetails.skills,
          'uploadedPdfPath': additionalDetails.uploadedPdfPath,
        });
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error adding additional details: $e');
    }
  }

  Future<void> updateAdditionalDetails(
      AdditionalDetails updatedAdditionalDetails) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore.collection(collectionName).doc(user.uid).update({
          'aboutMe': updatedAdditionalDetails.aboutMe,
          'skills': updatedAdditionalDetails.skills,
          'uploadedPdfPath': updatedAdditionalDetails.uploadedPdfPath,
        });
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error updating additional details: $e');
    }
  }
}
