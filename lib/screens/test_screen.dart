// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:placement/provider/student_provider.dart';
// // import 'package:placement/provider/education_provider.dart'; // Import the provider for education details
// // import 'dart:async';

// // // Get the current user's UID

// // class TestScreen extends ConsumerWidget {
// //   const TestScreen({Key? key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final studInfo = ref.watch(studentInfoProvider);
// //     final eduInfo = ref
// //         .watch(educationDetailsProvider); // Get the education details provider

// //     // Create a StreamController to manually combine the two streams
// //     final controller = StreamController<List<QuerySnapshot>>();

// //     // Combine the student and education details streams
// //     final studentStream = studInfo.studentInfo;
// //     final educationStream = eduInfo.educationDetails;

// //     studentStream.listen((studentSnapshot) {
// //       educationStream.listen((educationSnapshot) {
// //         controller.add([studentSnapshot, educationSnapshot]);
// //       });
// //     });

// //     return Center(
// //       child: StreamBuilder<List<QuerySnapshot>>(
// //         stream: controller.stream,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }

// //           if (!snapshot.hasData ||
// //               snapshot.data![0].docs.isEmpty ||
// //               snapshot.data![1].docs.isEmpty) {
// //             return const Center(
// //               child: Text('No Data Found'),
// //             );
// //           }

// //           if (snapshot.hasError) {
// //             return const Center(
// //               child: Text('Something went wrong..'),
// //             );
// //           }

// //           final studentDocs = snapshot.data?[0].docs;
// //           final educationDocs = snapshot.data?[1].docs;

// //           if ((educationDocs != null && educationDocs.isNotEmpty) &&
// //               (studentDocs != null && studentDocs.isNotEmpty)) {
// //             final educationData =
// //                 educationDocs[0].data() as Map<String, dynamic>;
// //             final studentData = studentDocs[0].data() as Map<String, dynamic>;
// //             final sgpaList = educationData['sgpaList'];

// //             return SingleChildScrollView(
// //               child: Column(
// //                 children: [
// //                   const _TopPortion(),
// //                   Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Column(
// //                       children: [
// //                         Text(
// //                           "${studentData['firstName']} ${studentData['lastName']}",
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 22,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 5),
// //                         Text(
// //                           textAlign: TextAlign.center,
// //                           "${studentData['email']}",
// //                           style:
// //                               const TextStyle(color: Colors.grey, fontSize: 14),
// //                         ),
// //                         const SizedBox(height: 16),
// //                         const Divider(),
// //                         Card(
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(
// //                               left: 12,
// //                               right: 12,
// //                               bottom: 12,
// //                             ),
// //                             child: Column(
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     const Text(
// //                                       'About Me',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 18,
// //                                       ),
// //                                     ),
// //                                     IconButton(
// //                                         onPressed: () {},
// //                                         icon: const Icon(Icons.edit_square)),
// //                                   ],
// //                                 ),
// //                                 Wrap(
// //                                   children: const [
// //                                     Text(
// //                                       'Your ‘About Me’ page is how potential customers and employers are going to learn more about you and your business, but it’s also going to help you form strong connections with your readers. When your customers feel like they actually know you, you’ll become a much more credible brand in their eyes.',
// //                                       style: const TextStyle(
// //                                         fontSize: 16,
// //                                       ),
// //                                       textAlign: TextAlign.justify,
// //                                     )
// //                                   ],
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                         Card(
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(
// //                               left: 12,
// //                               right: 12,
// //                               bottom: 12,
// //                             ),
// //                             child: Column(
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     const Text(
// //                                       'Skills',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 18,
// //                                       ),
// //                                     ),
// //                                     IconButton(
// //                                         onPressed: () {},
// //                                         icon: const Icon(Icons.edit_square)),
// //                                   ],
// //                                 ),
// //                                 Wrap(
// //                                   alignment: WrapAlignment.spaceEvenly,
// //                                   children: const [
// //                                     Chip(
// //                                       label: Text(
// //                                         'Flutter',
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                       width: 8,
// //                                     ),
// //                                     Chip(
// //                                       label: Text(
// //                                         'Figma',
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                       width: 8,
// //                                     ),
// //                                     Chip(
// //                                       label: Text(
// //                                         'Java',
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                       width: 8,
// //                                     ),
// //                                     Chip(
// //                                       label: Text(
// //                                         'Python',
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                       width: 8,
// //                                     ),
// //                                     Chip(
// //                                       label: Text(
// //                                         'MongoDB',
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                       width: 8,
// //                                     ),
// //                                     Chip(
// //                                       label: Text(
// //                                         'Javascript',
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       height: 8,
// //                                       width: 8,
// //                                     ),
// //                                     Chip(
// //                                       label: Text(
// //                                         'SQL',
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                         Card(
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(
// //                               left: 12,
// //                               right: 12,
// //                               bottom: 12,
// //                             ),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     const Text(
// //                                       'Academic Details',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 18,
// //                                       ),
// //                                     ),
// //                                     IconButton(
// //                                       onPressed: () {},
// //                                       icon: const Icon(Icons.edit_square),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const SizedBox(
// //                                   height: 10,
// //                                 ),
// //                                 Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     _buildAcademicDetail(
// //                                       educationData['tenthSchoolName'],
// //                                       "Percentage: ${educationData['tenthPercentage']}",
// //                                     ),
// //                                     _buildAcademicDetail(
// //                                       educationData['twelfthSchoolName'],
// //                                       "Percentage: ${educationData['twelfthPercentage']}",
// //                                     ),
// //                                     _buildAcademicDetail(
// //                                       educationData['collegeName'],
// //                                       "Cgpa: ${educationData['cgpa']}",
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                         Card(
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(
// //                               left: 12,
// //                               right: 12,
// //                               bottom: 12,
// //                             ),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.center,
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     const Text(
// //                                       'Semester Grade Point Average',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 18,
// //                                       ),
// //                                     ),
// //                                     IconButton(
// //                                       onPressed: () {},
// //                                       icon: const Icon(Icons.edit_square),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const SizedBox(height: 10),
// //                                 if (sgpaList != null)
// //                                   Column(
// //                                     children: [
// //                                       for (int i = 0;
// //                                           i < sgpaList.length;
// //                                           i += 2)
// //                                         Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceEvenly,
// //                                           children: [
// //                                             Text(
// //                                               "Semester ${i + 1}: ${sgpaList[i].toStringAsFixed(2)}",
// //                                               style: const TextStyle(
// //                                                 fontSize: 16,
// //                                               ),
// //                                             ),
// //                                             if (i + 1 < sgpaList.length)
// //                                               Text(
// //                                                 "Semester ${i + 2}: ${sgpaList[i + 1].toStringAsFixed(2)}",
// //                                                 style: const TextStyle(
// //                                                   fontSize: 16,
// //                                                 ),
// //                                               ),
// //                                             const SizedBox(
// //                                               height: 10,
// //                                             )
// //                                           ],
// //                                         ),
// //                                     ],
// //                                   ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           } else {
// //             // Handle the case where education data is empty
// //             return const Text(
// //                 'Education data or Student Profile data is not available.');
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// // class _TopPortion extends StatelessWidget {
// //   const _TopPortion({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 250,
// //       child: Stack(
// //         fit: StackFit.expand,
// //         children: [
// //           Container(
// //             margin: const EdgeInsets.only(bottom: 50),
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //                   begin: Alignment.bottomCenter,
// //                   end: Alignment.topCenter,
// //                   colors: [Color(0xff0043ba), Color(0xff006df1)]),
// //               borderRadius: BorderRadius.only(
// //                 bottomLeft: Radius.circular(50),
// //                 bottomRight: Radius.circular(50),
// //               ),
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: SizedBox(
// //               width: 150,
// //               height: 150,
// //               child: Stack(
// //                 fit: StackFit.expand,
// //                 children: [
// //                   Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.black,
// //                       shape: BoxShape.circle,
// //                       image: DecorationImage(
// //                         fit: BoxFit.cover,
// //                         image: AssetImage('assets/images/propelius.jpeg'),
// //                       ),
// //                     ),
// //                   ),
// //                   Positioned(
// //                     bottom: 0,
// //                     right: 5,
// //                     top: 100,
// //                     child: CircleAvatar(
// //                       radius: 20,
// //                       backgroundColor: Colors.black87,
// //                       child: IconButton(
// //                         onPressed: () {},
// //                         icon: const Icon(Icons.camera_alt_outlined),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// // Widget _buildAcademicDetail(
// //   String schoolOrCollegeName,
// //   String percentageOrCgpa,
// // ) {
// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Text(
// //         schoolOrCollegeName,
// //         style: const TextStyle(
// //           fontWeight: FontWeight.bold,
// //           fontSize: 16,
// //         ),
// //       ),
// //       Text(
// //         percentageOrCgpa,
// //         style: const TextStyle(
// //           fontWeight: FontWeight.bold,
// //           fontSize: 16,
// //         ),
// //       ),
// //       const SizedBox(
// //         height: 16,
// //       ),
// //     ],
// //   );
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:placement/provider/student_provider.dart';
// import 'package:placement/provider/education_provider.dart';

// import '../models/education.dart';
// import '../models/student.dart';
// import '../provider/auth_provider.dart';

// class TestScreen extends ConsumerWidget {
//   const TestScreen({Key? key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final studInfo = ref.watch(studentInfoProvider);
//     final eduInfo = ref.watch(educationDetailsProvider);
//     final authProfile = ref.watch(authenticationProvider);

//     return StreamBuilder<StudentInfo?>(
//       stream: studInfo.getStudentDetails(),
//       builder: (context, studentSnapshot) {
//         return StreamBuilder<EducationDetails?>(
//           stream: eduInfo.getEducationDetails(),
//           builder: (context, educationSnapshot) {
//             return StreamBuilder<String?>(
//               stream: authProfile.getUserImageUrlStream(),
//               builder: (context, imageSnapshot) {
//                 if (studentSnapshot.connectionState ==
//                         ConnectionState.waiting ||
//                     educationSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (!studentSnapshot.hasData && !educationSnapshot.hasData) {
//                   return const Center(
//                     child: Text('No Data Found From student and education'),
//                   );
//                 }

//                 if (!studentSnapshot.hasData) {
//                   return const Center(
//                     child: Text('No Data Found from student'),
//                   );
//                 }
//                 if (!educationSnapshot.hasData) {
//                   return const Center(
//                     child: Text('No Data Found from eduction'),
//                   );
//                 }

//                 if (!imageSnapshot.hasData) {
//                   return const Center(
//                     child: Text('No Data Found from profile image'),
//                   );
//                 }

//                 if (studentSnapshot.hasError ||
//                     educationSnapshot.hasError ||
//                     imageSnapshot.hasError) {
//                   return const Center(
//                     child: Text('Something went wrong..'),
//                   );
//                 }

//                 final studentData = studentSnapshot.data!;
//                 final educationData = educationSnapshot.data!;
//                 final imgUrl = imageSnapshot.data!;
//                 final sgpaList = educationData.sgpaList;

//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       _TopPortion(imageUrl: imgUrl),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Text(
//                               "${studentData.firstName} ${studentData.lastName}",
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               textAlign: TextAlign.center,
//                               studentData.email,
//                               style: const TextStyle(
//                                   color: Colors.grey, fontSize: 14),
//                             ),
//                             const SizedBox(height: 16),
//                             const Divider(),
//                             Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 12,
//                                   right: 12,
//                                   bottom: 12,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           'About Me',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         IconButton(
//                                             onPressed: () {},
//                                             icon:
//                                                 const Icon(Icons.edit_square)),
//                                       ],
//                                     ),
//                                     Wrap(
//                                       children: const [
//                                         Text(
//                                           'Your ‘About Me’ page is how potential customers and employers are going to learn more about you and your business, but it’s also going to help you form strong connections with your readers. When your customers feel like they actually know you, you’ll become a much more credible brand in their eyes.',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                           ),
//                                           textAlign: TextAlign.justify,
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 12,
//                                   right: 12,
//                                   bottom: 12,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           'Skills',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         IconButton(
//                                             onPressed: () {},
//                                             icon:
//                                                 const Icon(Icons.edit_square)),
//                                       ],
//                                     ),
//                                     Wrap(
//                                       alignment: WrapAlignment.spaceEvenly,
//                                       children: const [
//                                         Chip(
//                                           label: Text(
//                                             'Flutter',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                           width: 8,
//                                         ),
//                                         Chip(
//                                           label: Text(
//                                             'Figma',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                           width: 8,
//                                         ),
//                                         Chip(
//                                           label: Text(
//                                             'Java',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                           width: 8,
//                                         ),
//                                         Chip(
//                                           label: Text(
//                                             'Python',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                           width: 8,
//                                         ),
//                                         Chip(
//                                           label: Text(
//                                             'MongoDB',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                           width: 8,
//                                         ),
//                                         Chip(
//                                           label: Text(
//                                             'Javascript',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                           width: 8,
//                                         ),
//                                         Chip(
//                                           label: Text(
//                                             'SQL',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 12,
//                                   right: 12,
//                                   bottom: 12,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           'Academic Details',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         IconButton(
//                                           onPressed: () {},
//                                           icon: const Icon(Icons.edit_square),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         _buildAcademicDetail(
//                                           educationData.tenthSchoolName,
//                                           "Percentage: ${educationData.tenthPercentage}",
//                                         ),
//                                         _buildAcademicDetail(
//                                           educationData.twelfthSchoolName,
//                                           "Percentage: ${educationData.twelfthPercentage}",
//                                         ),
//                                         _buildAcademicDetail(
//                                           educationData.collegeName,
//                                           "Cgpa: ${educationData.cgpa}",
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 12,
//                                   right: 12,
//                                   bottom: 12,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           'Semester Grade Point Average',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         IconButton(
//                                           onPressed: () {},
//                                           icon: const Icon(Icons.edit_square),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Column(
//                                       children: [
//                                         for (int i = 0;
//                                             i < sgpaList.length;
//                                             i += 2)
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(
//                                                 "Semester ${i + 1}: ${sgpaList[i].toStringAsFixed(2)}",
//                                                 style: const TextStyle(
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                               if (i + 1 < sgpaList.length)
//                                                 Text(
//                                                   "Semester ${i + 2}: ${sgpaList[i + 1].toStringAsFixed(2)}",
//                                                   style: const TextStyle(
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                               const SizedBox(
//                                                 height: 10,
//                                               )
//                                             ],
//                                           ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class _TopPortion extends StatelessWidget {
//   const _TopPortion({Key? key, required this.imageUrl}) : super(key: key);
//   final String imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 250,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 50),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [Color(0xff0043ba), Color(0xff006df1)]),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//                 bottomRight: Radius.circular(50),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: SizedBox(
//               width: 150,
//               height: 150,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                           fit: BoxFit.cover, image: NetworkImage(imageUrl)),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 5,
//                     top: 100,
//                     child: CircleAvatar(
//                       radius: 20,
//                       backgroundColor: Colors.black87,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.camera_alt_outlined),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// Widget _buildAcademicDetail(
//   String schoolOrCollegeName,
//   String percentageOrCgpa,
// ) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         schoolOrCollegeName,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//         ),
//       ),
//       Text(
//         percentageOrCgpa,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//         ),
//       ),
//       const SizedBox(
//         height: 16,
//       ),
//     ],
//   );
// }

