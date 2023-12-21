import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../functions/custom_color_list.dart';
import '../models/company.dart';
import '../provider/company_details_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/compnay_card.dart';

class ResultOfCompanyList extends ConsumerWidget {
  const ResultOfCompanyList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result Declaration"),
      ),
      body: FutureBuilder(
        future: ref.watch(companyDetailsProvider).getAllCompanies(),
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

          List<CompanyDetails>? allCompanies = snapshot.data;

          allCompanies = allCompanies!
              .where((data) => data.studentsPlaced.isNotEmpty)
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: allCompanies.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.selectedStudentsList,
                    arguments: allCompanies![index].studentsPlaced,
                  );
                },
                child: CompanyCardWidget(
                  companyName: allCompanies![index].companyName,
                  subtitleText:
                      "Selected Student: ${allCompanies[index].studentsPlaced.length.toString()}",
                  color: colorsList[index % colorsList.length],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
