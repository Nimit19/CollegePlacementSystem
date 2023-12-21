import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:placement/routes/app_routes.dart';

import '../functions/extract_initial.dart';
import '../provider/company_details_provider.dart';

class CompanyCard extends ConsumerWidget {
  const CompanyCard(this.companyId, this.color, {super.key});
  final companyId;
  final color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesData = ref.watch(companyDetailsProvider);

    final companyDetails = companiesData.findById(companyId);

    return Container(
      width: double.infinity,
      height: 210,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black87, // Set the border color here
          width: 2.0, // Set the border width
        ),
        borderRadius: BorderRadius.circular(12.0),
        // color: kBlack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: color.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: color.shade400,
                  ),
                ),
                child: Center(
                  child: Text(
                    extractInitials(companyDetails.companyName),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        companyDetails.companyName,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 1.5,
                    ),
                    Text(
                      "Applied Students: ${companyDetails.appliedStudents.length}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Text(
                "Package: ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "${companyDetails.packageMin} - ${companyDetails.packageMax} LPA",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Arrival Date: ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                companyDetails.arrivalDate,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.jobDescriptionScreen,
                  arguments: {
                    'companyId': companyId,
                    'color': color,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text(
                "View & Apply",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
