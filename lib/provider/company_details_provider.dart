import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/services/company_details_service.dart';

import '../models/company.dart';

final companyDetailsProvider = Provider(
  (ref) => CompanyService(),
);

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredCompaniesProvider = Provider<List<CompanyDetails>>((ref) {
  final allCompanies = ref.watch(companyDetailsProvider).companiesList;
  final searchQuery = ref.watch(searchQueryProvider);

  final filteredCompanies = allCompanies.where((company) {
    return company.companyName
        .toLowerCase()
        .contains(searchQuery.toLowerCase());
  }).toList();

  return filteredCompanies;
});
