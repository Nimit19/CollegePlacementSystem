import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:placement/functions/extract_initial.dart';
import 'package:placement/provider/auth_provider.dart';
import 'package:placement/provider/company_details_provider.dart';

import '../widgets/company_tab.dart';
import '../widgets/description_tab.dart';

class JobDescriptionScreen extends ConsumerStatefulWidget {
  const JobDescriptionScreen({super.key});

  @override
  ConsumerState<JobDescriptionScreen> createState() =>
      _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends ConsumerState<JobDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final companyId = args['companyId'];
    final color = args['color'];

    final userId = FirebaseAuth.instance.currentUser!.uid;

    final companiesData = ref.watch(companyDetailsProvider);
    final authData = ref.watch(authenticationProvider);
    final isAdmin = authData.isAdmin(userId);

    final companyDetails = companiesData.findById(companyId);

    bool isStudentApplied(String studentId) {
      return companyDetails.appliedStudents.contains(studentId);
    }

    void applyForJob(String studentId) async {
      if (!isStudentApplied(studentId)) {
        companyDetails.appliedStudents.add(studentId);

        setState(() {
          isLoading = true;
        });

        await companiesData.updateCompany(companyDetails);

        setState(() {
          isLoading = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(companyDetails.companyName),
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: color.shade400,
                    ),
                    color: color.shade100,
                  ),
                  child: Center(
                    child: Text(
                      extractInitials(companyDetails.companyName),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 75,
                            letterSpacing: 3,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Material(
                color: Theme.of(context).colorScheme.inversePrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        "Company",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: 24,
                                ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Description",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: 24,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    CompanyTab(companyId: companyId),
                    DescriptionTab(companyId: companyId),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: isAdmin
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 18.0, bottom: 25.0, right: 18.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        // color: kBlack,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!isLoading)
                      Expanded(
                        child: SizedBox(
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: isStudentApplied(userId)
                                ? null
                                : () {
                                    applyForJob(userId);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: isStudentApplied(userId)
                                ? Text(
                                    "Applied",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  )
                                : Text(
                                    "Apply for Job",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
