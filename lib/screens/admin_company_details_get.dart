import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/models/company.dart';
import 'package:placement/provider/company_details_provider.dart';

import '../functions/custom_dialog.dart';
import '../routes/app_routes.dart';
import '../widgets/admin_add_new_text_filed.dart';

class AdminCompanyDetailsGetter extends ConsumerStatefulWidget {
  const AdminCompanyDetailsGetter({super.key});

  @override
  ConsumerState<AdminCompanyDetailsGetter> createState() =>
      _AdminCompanyDetailsGetterState();
}

class _AdminCompanyDetailsGetterState
    extends ConsumerState<AdminCompanyDetailsGetter> {
  List<String> recruitmentProcessAndCriteria = [];
  List<String> eligibilityCriteria = [];
  final formCompanyInfo = GlobalKey<FormState>();

  bool _isLoading = false;

  late CompanyDetails _editedCompanyDetails = CompanyDetails(
    id: '',
    companyName: '',
    companyDescription: '',
    technologyRequired: '',
    websiteURL: '',
    location: '',
    stipendMin: '',
    stipendMax: '',
    packageMin: '',
    packageMax: '',
    serviceAgreement: '',
    arrivalDate: '',
    recruitmentProcessAndCriteria: [],
    eligibilityCriteria: [],
  );

  void _savedCompanyDetailsForm(BuildContext context) async {
    final isValid = formCompanyInfo.currentState?.validate();

    print("###########");
    print(recruitmentProcessAndCriteria);
    print("###########");
    print(isValid);

    if (!isValid!) {
      print(recruitmentProcessAndCriteria);

      return;
    }

    print(recruitmentProcessAndCriteria);

    if (recruitmentProcessAndCriteria.isEmpty) {
      showCustomDialog(
          context, "Recruitment Process", "Please add a recruitment process");
      return;
    }
    if (eligibilityCriteria.isEmpty) {
      showCustomDialog(
          context, "Eligibility Criteria", "Please add a eligibility criteria");
      return;
    }
    formCompanyInfo.currentState?.save();
    // print("#################################################################");
    // print('Company Name: ${_editedCompanyDetails.companyName}');
    // print('Company Description: ${_editedCompanyDetails.companyDescription}');
    // print('Technology Required: ${_editedCompanyDetails.technologyRequired}');
    // print('Website URL: ${_editedCompanyDetails.websiteURL}');
    // print('Location: ${_editedCompanyDetails.location}');
    // print('Stipend Min: ${_editedCompanyDetails.stipendMin}');
    // print('Stipend Max: ${_editedCompanyDetails.stipendMax}');
    // print('Package Min: ${_editedCompanyDetails.packageMin}');
    // print('Package Max: ${_editedCompanyDetails.packageMax}');
    // print('Service Agreement: ${_editedCompanyDetails.serviceAgreement}');
    // print('Arrival Date: ${_editedCompanyDetails.arrivalDate}');
    // print(
    //     'Recruitment Process and Criteria: ${_editedCompanyDetails.recruitmentProcessAndCriteria}');
    // print('Eligibility Criteria: ${_editedCompanyDetails.eligibilityCriteria}');

    final companyDetails = ref.watch(companyDetailsProvider);

    setState(() {
      _isLoading = true;
    });

    // if (_editedStudentInfo.id == "") {
    await companyDetails.addCompany(_editedCompanyDetails);
    // } else {
    //   await studInfo.updateStudent(_editedStudentInfo);
    // }

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pushNamed(
      AppRoutes.adminCompaniesList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Company Details"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: formCompanyInfo,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        top: 30,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Company Name",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Propelius Technologies",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter the company name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              print(value);
                              _editedCompanyDetails = CompanyDetails(
                                id: _editedCompanyDetails.id,
                                companyName: value.toString(),
                                companyDescription:
                                    _editedCompanyDetails.companyDescription,
                                technologyRequired:
                                    _editedCompanyDetails.technologyRequired,
                                websiteURL: _editedCompanyDetails.websiteURL,
                                location: _editedCompanyDetails.location,
                                stipendMin: _editedCompanyDetails.stipendMin,
                                stipendMax: _editedCompanyDetails.stipendMax,
                                packageMin: _editedCompanyDetails.packageMin,
                                packageMax: _editedCompanyDetails.packageMax,
                                serviceAgreement:
                                    _editedCompanyDetails.serviceAgreement,
                                arrivalDate: _editedCompanyDetails.arrivalDate,
                                recruitmentProcessAndCriteria:
                                    _editedCompanyDetails
                                        .recruitmentProcessAndCriteria,
                                eligibilityCriteria:
                                    _editedCompanyDetails.eligibilityCriteria,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Company Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  "Propelius Technologies is a next generation software development studio focused on developing cutting edge Web and Mobile Applications on JavaScript based technologies like ReactJS, React Native and Node. js. We have domain expertise in SAAS, FinTech, LegalTech and InsuranceTech.",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            textAlign: TextAlign.justify,
                            keyboardType: TextInputType.name,
                            maxLines: 6,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter the company description";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedCompanyDetails = CompanyDetails(
                                id: _editedCompanyDetails.id,
                                companyName: _editedCompanyDetails.companyName,
                                companyDescription: value.toString(),
                                technologyRequired:
                                    _editedCompanyDetails.technologyRequired,
                                websiteURL: _editedCompanyDetails.websiteURL,
                                location: _editedCompanyDetails.location,
                                stipendMin: _editedCompanyDetails.stipendMin,
                                stipendMax: _editedCompanyDetails.stipendMax,
                                packageMin: _editedCompanyDetails.packageMin,
                                packageMax: _editedCompanyDetails.packageMax,
                                serviceAgreement:
                                    _editedCompanyDetails.serviceAgreement,
                                arrivalDate: _editedCompanyDetails.arrivalDate,
                                recruitmentProcessAndCriteria:
                                    _editedCompanyDetails
                                        .recruitmentProcessAndCriteria,
                                eligibilityCriteria:
                                    _editedCompanyDetails.eligibilityCriteria,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Technology Required",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  "Flutter, Python, Java, React JS, Node JS, Android",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter valid technology requirements";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedCompanyDetails = CompanyDetails(
                                id: _editedCompanyDetails.id,
                                companyName: _editedCompanyDetails.companyName,
                                companyDescription:
                                    _editedCompanyDetails.companyDescription,
                                technologyRequired: value.toString(),
                                websiteURL: _editedCompanyDetails.websiteURL,
                                location: _editedCompanyDetails.location,
                                stipendMin: _editedCompanyDetails.stipendMin,
                                stipendMax: _editedCompanyDetails.stipendMax,
                                packageMin: _editedCompanyDetails.packageMin,
                                packageMax: _editedCompanyDetails.packageMax,
                                serviceAgreement:
                                    _editedCompanyDetails.serviceAgreement,
                                arrivalDate: _editedCompanyDetails.arrivalDate,
                                recruitmentProcessAndCriteria:
                                    _editedCompanyDetails
                                        .recruitmentProcessAndCriteria,
                                eligibilityCriteria:
                                    _editedCompanyDetails.eligibilityCriteria,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Website URL",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "https://propelius.tech",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            keyboardType: TextInputType.url,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.startsWith("http")) {
                                return "Please enter a valid website URL";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedCompanyDetails = CompanyDetails(
                                id: _editedCompanyDetails.id,
                                companyName: _editedCompanyDetails.companyName,
                                companyDescription:
                                    _editedCompanyDetails.companyDescription,
                                technologyRequired:
                                    _editedCompanyDetails.technologyRequired,
                                websiteURL: value.toString(),
                                location: _editedCompanyDetails.location,
                                stipendMin: _editedCompanyDetails.stipendMin,
                                stipendMax: _editedCompanyDetails.stipendMax,
                                packageMin: _editedCompanyDetails.packageMin,
                                packageMax: _editedCompanyDetails.packageMax,
                                serviceAgreement:
                                    _editedCompanyDetails.serviceAgreement,
                                arrivalDate: _editedCompanyDetails.arrivalDate,
                                recruitmentProcessAndCriteria:
                                    _editedCompanyDetails
                                        .recruitmentProcessAndCriteria,
                                eligibilityCriteria:
                                    _editedCompanyDetails.eligibilityCriteria,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Location",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  "205, Milestone Milagro Nr. Vatsalya Bungalows, Udhana, Udhana - Magdalla Rd, Vesu, Surat, Gujarat 395007",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            maxLines: 4,
                            keyboardType: TextInputType.streetAddress,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter the location";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedCompanyDetails = CompanyDetails(
                                id: _editedCompanyDetails.id,
                                companyName: _editedCompanyDetails.companyName,
                                companyDescription:
                                    _editedCompanyDetails.companyDescription,
                                technologyRequired:
                                    _editedCompanyDetails.technologyRequired,
                                websiteURL: _editedCompanyDetails.websiteURL,
                                location: value.toString(),
                                stipendMin: _editedCompanyDetails.stipendMin,
                                stipendMax: _editedCompanyDetails.stipendMax,
                                packageMin: _editedCompanyDetails.packageMin,
                                packageMax: _editedCompanyDetails.packageMax,
                                serviceAgreement:
                                    _editedCompanyDetails.serviceAgreement,
                                arrivalDate: _editedCompanyDetails.arrivalDate,
                                recruitmentProcessAndCriteria:
                                    _editedCompanyDetails
                                        .recruitmentProcessAndCriteria,
                                eligibilityCriteria:
                                    _editedCompanyDetails.eligibilityCriteria,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Stipend",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "10000",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter the minimum stipend";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedCompanyDetails = CompanyDetails(
                                      id: _editedCompanyDetails.id,
                                      companyName:
                                          _editedCompanyDetails.companyName,
                                      companyDescription: _editedCompanyDetails
                                          .companyDescription,
                                      technologyRequired: _editedCompanyDetails
                                          .technologyRequired,
                                      websiteURL:
                                          _editedCompanyDetails.websiteURL,
                                      location: _editedCompanyDetails.location,
                                      stipendMin: value.toString(),
                                      stipendMax:
                                          _editedCompanyDetails.stipendMax,
                                      packageMin:
                                          _editedCompanyDetails.packageMin,
                                      packageMax:
                                          _editedCompanyDetails.packageMax,
                                      serviceAgreement: _editedCompanyDetails
                                          .serviceAgreement,
                                      arrivalDate:
                                          _editedCompanyDetails.arrivalDate,
                                      recruitmentProcessAndCriteria:
                                          _editedCompanyDetails
                                              .recruitmentProcessAndCriteria,
                                      eligibilityCriteria: _editedCompanyDetails
                                          .eligibilityCriteria,
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: const Icon(Icons.remove),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "150000",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter the maximum stipend";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedCompanyDetails = CompanyDetails(
                                      id: _editedCompanyDetails.id,
                                      companyName:
                                          _editedCompanyDetails.companyName,
                                      companyDescription: _editedCompanyDetails
                                          .companyDescription,
                                      technologyRequired: _editedCompanyDetails
                                          .technologyRequired,
                                      websiteURL:
                                          _editedCompanyDetails.websiteURL,
                                      location: _editedCompanyDetails.location,
                                      stipendMin:
                                          _editedCompanyDetails.stipendMin,
                                      stipendMax: value.toString(),
                                      packageMin:
                                          _editedCompanyDetails.packageMin,
                                      packageMax:
                                          _editedCompanyDetails.packageMax,
                                      serviceAgreement: _editedCompanyDetails
                                          .serviceAgreement,
                                      arrivalDate:
                                          _editedCompanyDetails.arrivalDate,
                                      recruitmentProcessAndCriteria:
                                          _editedCompanyDetails
                                              .recruitmentProcessAndCriteria,
                                      eligibilityCriteria: _editedCompanyDetails
                                          .eligibilityCriteria,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Package(LPA)",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "3.6",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter the minimum package";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedCompanyDetails = CompanyDetails(
                                      id: _editedCompanyDetails.id,
                                      companyName:
                                          _editedCompanyDetails.companyName,
                                      companyDescription: _editedCompanyDetails
                                          .companyDescription,
                                      technologyRequired: _editedCompanyDetails
                                          .technologyRequired,
                                      websiteURL:
                                          _editedCompanyDetails.websiteURL,
                                      location: _editedCompanyDetails.location,
                                      stipendMin:
                                          _editedCompanyDetails.stipendMin,
                                      stipendMax:
                                          _editedCompanyDetails.stipendMax,
                                      packageMin: value.toString(),
                                      packageMax:
                                          _editedCompanyDetails.packageMax,
                                      serviceAgreement: _editedCompanyDetails
                                          .serviceAgreement,
                                      arrivalDate:
                                          _editedCompanyDetails.arrivalDate,
                                      recruitmentProcessAndCriteria:
                                          _editedCompanyDetails
                                              .recruitmentProcessAndCriteria,
                                      eligibilityCriteria: _editedCompanyDetails
                                          .eligibilityCriteria,
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: const Icon(Icons.remove),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "5.0",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter the maximum package";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedCompanyDetails = CompanyDetails(
                                      id: _editedCompanyDetails.id,
                                      companyName:
                                          _editedCompanyDetails.companyName,
                                      companyDescription: _editedCompanyDetails
                                          .companyDescription,
                                      technologyRequired: _editedCompanyDetails
                                          .technologyRequired,
                                      websiteURL:
                                          _editedCompanyDetails.websiteURL,
                                      location: _editedCompanyDetails.location,
                                      stipendMin:
                                          _editedCompanyDetails.stipendMin,
                                      stipendMax:
                                          _editedCompanyDetails.stipendMax,
                                      packageMin:
                                          _editedCompanyDetails.packageMin,
                                      packageMax: value.toString(),
                                      serviceAgreement: _editedCompanyDetails
                                          .serviceAgreement,
                                      arrivalDate:
                                          _editedCompanyDetails.arrivalDate,
                                      recruitmentProcessAndCriteria:
                                          _editedCompanyDetails
                                              .recruitmentProcessAndCriteria,
                                      eligibilityCriteria: _editedCompanyDetails
                                          .eligibilityCriteria,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Service Agreement(?)",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  "Yes (18 months) includes 6 months of their training period",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter the service agreement details";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedCompanyDetails = CompanyDetails(
                                id: _editedCompanyDetails.id,
                                companyName: _editedCompanyDetails.companyName,
                                companyDescription:
                                    _editedCompanyDetails.companyDescription,
                                technologyRequired:
                                    _editedCompanyDetails.technologyRequired,
                                websiteURL: _editedCompanyDetails.websiteURL,
                                location: _editedCompanyDetails.location,
                                stipendMin: _editedCompanyDetails.stipendMin,
                                stipendMax: _editedCompanyDetails.stipendMax,
                                packageMin: _editedCompanyDetails.packageMin,
                                packageMax: _editedCompanyDetails.packageMax,
                                serviceAgreement: value.toString(),
                                arrivalDate: _editedCompanyDetails.arrivalDate,
                                recruitmentProcessAndCriteria:
                                    _editedCompanyDetails
                                        .recruitmentProcessAndCriteria,
                                eligibilityCriteria:
                                    _editedCompanyDetails.eligibilityCriteria,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Arrival Date",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "2 Sep 2024",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter the arrival date";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedCompanyDetails = CompanyDetails(
                                id: _editedCompanyDetails.id,
                                companyName: _editedCompanyDetails.companyName,
                                companyDescription:
                                    _editedCompanyDetails.companyDescription,
                                technologyRequired:
                                    _editedCompanyDetails.technologyRequired,
                                websiteURL: _editedCompanyDetails.websiteURL,
                                location: _editedCompanyDetails.location,
                                stipendMin: _editedCompanyDetails.stipendMin,
                                stipendMax: _editedCompanyDetails.stipendMax,
                                packageMin: _editedCompanyDetails.packageMin,
                                packageMax: _editedCompanyDetails.packageMax,
                                serviceAgreement:
                                    _editedCompanyDetails.serviceAgreement,
                                arrivalDate: value.toString(),
                                recruitmentProcessAndCriteria:
                                    _editedCompanyDetails
                                        .recruitmentProcessAndCriteria,
                                eligibilityCriteria:
                                    _editedCompanyDetails.eligibilityCriteria,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Recruitment Process",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          if (recruitmentProcessAndCriteria.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i = 0;
                                    i < recruitmentProcessAndCriteria.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 58,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              recruitmentProcessAndCriteria[i],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return AddNewTextField(
                                      onSave: (values) {
                                        _editedCompanyDetails = CompanyDetails(
                                          id: _editedCompanyDetails.id,
                                          companyName:
                                              _editedCompanyDetails.companyName,
                                          companyDescription:
                                              _editedCompanyDetails
                                                  .companyDescription,
                                          technologyRequired:
                                              _editedCompanyDetails
                                                  .technologyRequired,
                                          websiteURL:
                                              _editedCompanyDetails.websiteURL,
                                          location:
                                              _editedCompanyDetails.location,
                                          stipendMin:
                                              _editedCompanyDetails.stipendMin,
                                          stipendMax:
                                              _editedCompanyDetails.stipendMax,
                                          packageMin:
                                              _editedCompanyDetails.packageMin,
                                          packageMax:
                                              _editedCompanyDetails.packageMax,
                                          serviceAgreement:
                                              _editedCompanyDetails
                                                  .serviceAgreement,
                                          arrivalDate:
                                              _editedCompanyDetails.arrivalDate,
                                          recruitmentProcessAndCriteria: values,
                                          eligibilityCriteria:
                                              _editedCompanyDetails
                                                  .eligibilityCriteria,
                                        );
                                        setState(() {
                                          recruitmentProcessAndCriteria =
                                              values;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text("Add Recruitment Process"),
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "Eligibility Criteria",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          if (eligibilityCriteria.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i = 0;
                                    i < eligibilityCriteria.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 58,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              eligibilityCriteria[i],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddNewTextField(
                                      onSave: (values) {
                                        _editedCompanyDetails = CompanyDetails(
                                          id: _editedCompanyDetails.id,
                                          companyName:
                                              _editedCompanyDetails.companyName,
                                          companyDescription:
                                              _editedCompanyDetails
                                                  .companyDescription,
                                          technologyRequired:
                                              _editedCompanyDetails
                                                  .technologyRequired,
                                          websiteURL:
                                              _editedCompanyDetails.websiteURL,
                                          location:
                                              _editedCompanyDetails.location,
                                          stipendMin:
                                              _editedCompanyDetails.stipendMin,
                                          stipendMax:
                                              _editedCompanyDetails.stipendMax,
                                          packageMin:
                                              _editedCompanyDetails.packageMin,
                                          packageMax:
                                              _editedCompanyDetails.packageMax,
                                          serviceAgreement:
                                              _editedCompanyDetails
                                                  .serviceAgreement,
                                          arrivalDate:
                                              _editedCompanyDetails.arrivalDate,
                                          recruitmentProcessAndCriteria:
                                              _editedCompanyDetails
                                                  .recruitmentProcessAndCriteria,
                                          eligibilityCriteria: values,
                                        );
                                        setState(() {
                                          eligibilityCriteria = values;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text("Add Eligibility Criteria"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 16,
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () => _savedCompanyDetailsForm(context),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Save Changes",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
