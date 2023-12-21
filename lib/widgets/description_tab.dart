import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../provider/company_details_provider.dart';

class DescriptionTab extends ConsumerWidget {
  final companyId;
  const DescriptionTab({super.key, this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesData = ref.watch(companyDetailsProvider);

    final companyDetails = companiesData.findById(companyId);

    final List<String> recruitmentProcessSteps =
        companyDetails.recruitmentProcessAndCriteria;
    final List<String> eligibilityCriteria = companyDetails.eligibilityCriteria;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Description:',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              companyDetails.companyDescription,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Eligibility Criteria:',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 8.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: eligibilityCriteria.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  '${index + 1}. ${eligibilityCriteria[index]}',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Recruitment Process:',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 8.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recruitmentProcessSteps.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  '${index + 1}. ${recruitmentProcessSteps[index]}',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
