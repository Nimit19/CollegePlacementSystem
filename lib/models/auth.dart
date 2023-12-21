import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  // made dialog
  Future showDialogBox(BuildContext ctx, dynamic e) {
    return showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Text('Error Occurred'),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  //  SigIn the user using Email and Password
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
    } catch (e) {
      showDialogBox(context, e);
    }
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
    } catch (e) {
      showDialogBox(context, e);
    }
  }

  // //  SignIn the user Google
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   try {
  //     await _auth.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     await showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: Text('Error Occured'),
  //         content: Text(e.toString()),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(ctx).pop();
  //               },
  //               child: Text("OK"))
  //         ],
  //       ),
  //     );
  //   }
  // }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> uploadImageToStorage(File image, String uid) async {
    try {
      final storageRef = _storage.ref().child('user_images').child('$uid.jpg');
      await storageRef.putFile(image);
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw e;
    }
  }

  // Save user image URL to Firestore
  Future<void> saveUserImage(String uid, String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('studentsProfile')
          .doc(uid)
          .set({
        'image_url': imageUrl,
      });
    } catch (e) {
      throw e;
    }
  }

  Stream<String?> getUserImageUrlStream() {
    final User? user = FirebaseAuth.instance.currentUser;

    final userImageRef =
        FirebaseFirestore.instance.collection('studentsProfile').doc(user!.uid);

    return userImageRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['image_url'] as String?;
      } else {
        return null; // User document does not exist or image_url field is missing
      }
    });
  }

  bool isAdmin(String studentId) {
    return studentId == 'RJdrObOAidT5H7Rdm06agxHSQbU2';
  }
}

// Future<String?> getUserImageUrl() async {
//   final User? user = FirebaseAuth.instance.currentUser;

//   final userImageRef =
//       FirebaseFirestore.instance.collection('studentsProfile').doc(user!.uid);

//   final stream = userImageRef.snapshots().map((snapshot) {
//     if (snapshot.exists) {
//       final data = snapshot.data() as Map<String, dynamic>;
//       return data['image_url'] as String?;
//     } else {
//       return null; // User document does not exist or image_url field is missing
//     }
//   });

//   // Convert the stream to a Future and get the latest value
//   final String? imageUrl = await stream.first;

//   return imageUrl;
// }


// https://bishwajeet-parhi.medium.com/firebase-authentication-using-flutter-and-riverpod-f302ab749383