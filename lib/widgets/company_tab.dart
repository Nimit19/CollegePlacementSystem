import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../provider/company_details_provider.dart';

class CompanyTab extends ConsumerWidget {
  final companyId;
  const CompanyTab({super.key, this.companyId});

  Widget tableCell(String val, BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Text(
          val,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesData = ref.watch(companyDetailsProvider);

    final companyDetails = companiesData.findById(companyId);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1.5,
            ),
          ),
          child: Table(
              border: TableBorder.symmetric(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  children: [
                    tableCell("Company Name", context),
                    tableCell(companyDetails.companyName, context),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  children: [
                    tableCell("Job Locations", context),
                    tableCell(companyDetails.location, context),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                  ),
                  children: [
                    tableCell("Website URL", context),
                    tableCell(companyDetails.websiteURL, context),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  children: [
                    tableCell("Technologies Required", context),
                    tableCell(companyDetails.technologyRequired, context),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                  ),
                  children: [
                    tableCell("Stipend", context),
                    tableCell(
                        '${companyDetails.stipendMin} - ${companyDetails.stipendMax}',
                        context),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  children: [
                    tableCell("Package", context),
                    tableCell(
                        "${companyDetails.packageMin} - ${companyDetails.packageMax} LPA",
                        context),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                  ),
                  children: [
                    tableCell("Service Agreement(?)", context),
                    tableCell(companyDetails.serviceAgreement, context),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  children: [
                    tableCell("Arrival Date", context),
                    tableCell(companyDetails.arrivalDate, context),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
