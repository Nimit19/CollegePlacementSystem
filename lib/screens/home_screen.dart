import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../functions/custom_color_list.dart';
import '../models/company.dart';
import '../provider/company_details_provider.dart';
import '../widgets/company_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Hi Nimit,\nFind your Dream Job",
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            height: 50.0,
            margin: const EdgeInsets.only(right: 18.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black87, // Set the border color here
                        width: 2.0, // Set the border width
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (text) {
                        ref.refresh(searchQueryProvider.notifier).state = text;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.search,
                          size: 25.0,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        hintText: "Search for the company",
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  margin: EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.black, // Set the border color here
                      width: 2.0, // Set the border width
                    ),
                  ),
                  child: Icon(
                    FontAwesomeIcons.slidersH,
                    color: Colors.black,
                    size: 20.0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            "Popular Company",
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: StreamBuilder(
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
                String searchQuery =
                    ref.watch(searchQueryProvider.notifier).state.toLowerCase();

                List<CompanyDetails> filteredCompanies =
                    allCompanies.where((company) {
                  return searchQuery != ""
                      ? company.companyName.toLowerCase().contains(searchQuery)
                      : true;
                }).toList();

                return ListView.builder(
                  itemCount: filteredCompanies.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CompanyCard(
                      filteredCompanies[index].id,
                      colorsList[index % colorsList.length],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
