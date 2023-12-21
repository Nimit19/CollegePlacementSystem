import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/functions/custom_alert_dialog.dart';
import '../models/student.dart';
import '../provider/company_details_provider.dart';
import '../provider/student_provider.dart';

class AdminIsPlacedStudentsList extends StatefulWidget {
  const AdminIsPlacedStudentsList({Key? key}) : super(key: key);

  @override
  State<AdminIsPlacedStudentsList> createState() =>
      _AdminIsPlacedStudentsListState();
}

class _AdminIsPlacedStudentsListState extends State<AdminIsPlacedStudentsList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Unplaced and Placed
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Students List"),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Unplaced",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
              Tab(
                child: Text(
                  "Placed",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Unplaced students tab
            StudentListTab(
              isPlaced: false,
            ),
            // Placed students tab
            StudentListTab(
              isPlaced: true,
            ),
          ],
        ),
      ),
    );
  }
}

class StudentListTab extends ConsumerStatefulWidget {
  final bool isPlaced;

  const StudentListTab({
    super.key,
    required this.isPlaced,
  });

  @override
  ConsumerState<StudentListTab> createState() => _StudentListTabState();
}

class _StudentListTabState extends ConsumerState<StudentListTab> {
  late List<StudentInfo> students;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final String companyId =
        ModalRoute.of(context)?.settings.arguments as String;

    final companiesData = ref.watch(companyDetailsProvider);

    final companyDetails = companiesData.findById(companyId);

    bool isStudentPlaced(String studentId) {
      return companyDetails.studentsPlaced.contains(studentId);
    }

    void placeStudent(String studentId) async {
      if (!isStudentPlaced(studentId)) {
        companyDetails.studentsPlaced.add(studentId);

        setState(() {
          isLoading = true;
        });

        await companiesData.updateCompany(companyDetails);

        setState(() {
          isLoading = false;
        });
      }
    }

    void unplaceStudent(String studentId) async {
      if (isStudentPlaced(studentId)) {
        companyDetails.studentsPlaced.remove(studentId);

        setState(() {
          isLoading = true;
        });

        await companiesData.updateCompany(companyDetails);

        setState(() {
          isLoading = false;
        });
      }
    }

    return FutureBuilder(
      future: ref.watch(studentInfoProvider).getAllStudents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('No Data Found from students'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong..'),
          );
        }

        final List<StudentInfo>? allStudents = snapshot.data;

        if (widget.isPlaced) {
          students = allStudents!
              .where(
                (student) =>
                    companyDetails.appliedStudents.contains(student.id),
              )
              .where(
                (student) => companyDetails.studentsPlaced.contains(student.id),
              )
              .toList();
        } else {
          students = allStudents!
              .where(
                (student) =>
                    companyDetails.appliedStudents.contains(student.id),
              )
              .where(
                (student) =>
                    !companyDetails.studentsPlaced.contains(student.id),
              )
              .toList();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: students.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Implement logic to handle student details or actions
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                elevation: 3,
                child: ListTile(
                  horizontalTitleGap: 1.0,
                  contentPadding: const EdgeInsets.only(
                    left: 0,
                    right: 20,
                    top: 3,
                    bottom: 3,
                  ),
                  leading: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: Colors.deepPurple.shade200,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(students[index].profileImgUrl),
                      ),
                    ),
                  ),
                  title: Text(
                    "${students[index].firstName} ${students[index].lastName}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    students[index].email,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  trailing:
                      isLoading // Use isLoading to show/hide CircularProgressIndicator
                          ? const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () {
                                showConfirmationAlertDialog(
                                  context,
                                  "Are You Sure?",
                                  widget.isPlaced
                                      ? "Do you want to add to student to Unplaced?"
                                      : "Do you want to add to student to placed?",
                                  () {
                                    if (widget.isPlaced) {
                                      unplaceStudent(students[index].id);
                                    } else {
                                      placeStudent(students[index].id);
                                    }
                                  },
                                );
                              },
                              icon: widget.isPlaced
                                  ? const Icon(Icons.remove)
                                  : const Icon(Icons.add),
                            ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
