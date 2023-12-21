import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:placement/provider/student_provider.dart';

import '../models/student.dart';
import '../routes/app_routes.dart';

class AdminStudentsList extends ConsumerWidget {
  const AdminStudentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Students List"),
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

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: allStudents.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.profileScreen,
                    arguments: allStudents[index].id,
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  elevation: 3,
                  child: ListTile(
                    horizontalTitleGap: 1.0,
                    contentPadding: const EdgeInsets.only(
                      left: 0,
                      right: 20,
                      top: 5,
                      bottom: 5,
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
                          image: NetworkImage(allStudents[index].profileImgUrl),
                        ),
                      ),
                    ),
                    title: Text(
                      "${allStudents[index].firstName} ${allStudents[index].lastName}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      allStudents[index].email,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
