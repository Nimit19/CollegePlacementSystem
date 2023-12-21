import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';

import '../models/student.dart';
import '../provider/student_provider.dart';

class SelectedStudentsList extends ConsumerStatefulWidget {
  const SelectedStudentsList({super.key});

  @override
  ConsumerState<SelectedStudentsList> createState() =>
      _SelectedStudentsListState();
}

class _SelectedStudentsListState extends ConsumerState<SelectedStudentsList> {
  final ConfettiController _confettiController = ConfettiController();

  @override
  void initState() {
    _confettiController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List? selectedStudentList =
        ModalRoute.of(context)?.settings.arguments as List?;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Selected Students"),
        ),
        body: FutureBuilder(
          future: ref.watch(studentInfoProvider).getAllStudents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Data Found from student'),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong..'),
              );
            }

            List<StudentInfo>? allStudents = snapshot.data!;

            final students = selectedStudentList!.map((studId) {
              return allStudents.firstWhere(
                (student) => student.id == studId,
              );
            }).toList();

            return Column(
              children: [
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  particleDrag: 0.05,
                  emissionFrequency: 0.02,
                  numberOfParticles: 20,
                  gravity: 0.1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
                  child: Text(
                    "Congratulations to all the selected students in our college placement drive!",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 30,
                          color: Colors.deepPurple.shade900,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: students.length,
                  options: CarouselOptions(
                    height: 350,
                    // enlargeCenterPage: true,

                    viewportFraction: 0.75,
                    autoPlay: true,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Card(
                      color: Colors.deepPurple.shade400,
                      elevation: 5,
                      margin: const EdgeInsets.all(16.0),
                      child: Container(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    students[index].profileImgUrl,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 16,
                              ),
                              child: Text(
                                '${students[index].firstName} ${students[index].lastName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize: 24,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ));
  }
}
