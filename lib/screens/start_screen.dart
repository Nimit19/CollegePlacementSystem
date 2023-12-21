import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:placement/screens/stepper_screen.dart';

import '../models/additional.dart';
import '../models/education.dart';
import '../models/student.dart';
import '../provider/additional_details_provider.dart';
import '../provider/education_provider.dart';
import '../provider/student_provider.dart';
import 'bottom_navigation_bar_screen.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final studInfo = ref.watch(studentInfoProvider);
    final eduInfo = ref.watch(educationDetailsProvider);
    final additionalInfo = ref.watch(additionalDetailsProvider);

    return StreamBuilder<StudentInfo?>(
        stream: studInfo.getStudentDetails(userId),
        builder: (context, studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (studentSnapshot.hasError) {
            return const Center(
              child: Text('Something went wrong..'),
            );
          }

          return StreamBuilder<EducationDetails?>(
              stream: eduInfo.getEducationDetails(userId),
              builder: (context, educationSnapshot) {
                if (educationSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (educationSnapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong..'),
                  );
                }

                return StreamBuilder<AdditionalDetails?>(
                  stream: additionalInfo.getAdditionalDetailsStream(userId),
                  builder: (context, additionalInfoSnapshot) {
                    if (additionalInfoSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (additionalInfoSnapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong..'),
                      );
                    }

                    if (!studentSnapshot.hasData ||
                        !educationSnapshot.hasData ||
                        !additionalInfoSnapshot.hasData) {
                      return const StepperScreen();
                    }

                    return const BottomNavigationBarScreen();
                  },
                );
              });
        });
  }
}
