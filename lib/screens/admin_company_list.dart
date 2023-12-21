import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/models/company.dart';
import 'package:placement/routes/app_routes.dart';

import '../functions/custom_color_list.dart';
import '../functions/extract_initial.dart';
import '../provider/company_details_provider.dart';

class AdminCompanyList extends ConsumerStatefulWidget {
  const AdminCompanyList({super.key});

  @override
  ConsumerState<AdminCompanyList> createState() => _AdminCompanyListState();
}

class _AdminCompanyListState extends ConsumerState<AdminCompanyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Company List"),
        ),
        body: StreamBuilder(
          stream: ref.watch(companyDetailsProvider).getAllCompaniesStream(),
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

            List<CompanyDetails> allCompanies = snapshot.data!;

            return ListView.builder(
              itemCount: allCompanies.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    top: index == 0 ? 16 : 0,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorsList[index % colorsList.length]
                                    .withOpacity(.65),
                              ),
                              color: colorsList[index % colorsList.length]
                                  .withOpacity(.40),
                            ),
                            child: Center(
                              child: Text(
                                extractInitials(
                                    allCompanies[index].companyName),
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                allCompanies[index].companyName,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                "Applied Students: ${allCompanies[index].appliedStudents.length}",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.jobDescriptionScreen,
                              arguments: {
                                'companyId': allCompanies[index].id,
                                'color': colorsList[index % colorsList.length],
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "View",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black26,
                                    ),
                                    width: 35,
                                    height: 35,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
