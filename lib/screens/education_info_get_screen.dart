import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/models/education.dart';
import 'package:placement/provider/education_provider.dart';

class EducationGetterScreen extends ConsumerStatefulWidget {
  const EducationGetterScreen({super.key});

  @override
  ConsumerState<EducationGetterScreen> createState() =>
      _EducationGetterScreenState();
}

class _EducationGetterScreenState extends ConsumerState<EducationGetterScreen> {
  bool _isLoading = false;

  final _formEducationInfo = GlobalKey<FormState>();

  late EducationDetails _editedEducationInfo;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final initialStudentValue =
        await ref.read(educationDetailsProvider).getEducationInfo();
    setState(() {
      _editedEducationInfo = initialStudentValue ??
          EducationDetails(
            id: '',
            tenthSchoolName: '',
            twelfthSchoolName: '',
            tenthPercentage: '',
            twelfthPercentage: '',
            collegeName: '',
            branch: '',
            sgpaList: [],
            cgpa: '',
          );
    });
  }

  void _savedEducationInfoForm(BuildContext ctx) async {
    final isValid = _formEducationInfo.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formEducationInfo.currentState?.save();

    final educationDetails = ref.read(educationDetailsProvider);

    setState(() {
      _isLoading = true;
    });

    if (_editedEducationInfo.id == "") {
      await educationDetails.addEducationDetails(_editedEducationInfo);
    } else {
      await educationDetails.updateEducationDetails(_editedEducationInfo);
    }

    setState(() {
      _isLoading = false;
    });

    // Navigate back to the previous screen
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Academics Details"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder<EducationDetails?>(
              future: ref.read(educationDetailsProvider).getEducationInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                } else {
                  return _buildForm(_editedEducationInfo);
                }
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () => _savedEducationInfoForm(context),
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

  Widget _buildForm(EducationDetails initialData) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 16,
        ),
        child: Form(
          key: _formEducationInfo,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "School Details",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "10th School Name",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: initialData.tenthSchoolName,
                decoration: InputDecoration(
                  hintText: "Sett R. J. J. High School",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.name,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a valid school name";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedEducationInfo = EducationDetails(
                    id: _editedEducationInfo.id,
                    tenthSchoolName: value.toString(),
                    twelfthSchoolName: _editedEducationInfo.twelfthSchoolName,
                    tenthPercentage: _editedEducationInfo.tenthPercentage,
                    twelfthPercentage: _editedEducationInfo.twelfthPercentage,
                    collegeName: _editedEducationInfo.collegeName,
                    branch: _editedEducationInfo.branch,
                    sgpaList: _editedEducationInfo.sgpaList,
                    cgpa: _editedEducationInfo.cgpa,
                  );
                },
              ),
              const SizedBox(
                height: 22,
              ),
              const Text(
                "12th School Name",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: initialData.twelfthSchoolName,
                decoration: InputDecoration(
                  hintText: "Sett R. J. J. High School",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.name,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a valid school name";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedEducationInfo = EducationDetails(
                    id: _editedEducationInfo.id,
                    tenthSchoolName: _editedEducationInfo.tenthSchoolName,
                    twelfthSchoolName: value.toString(),
                    tenthPercentage: _editedEducationInfo.tenthPercentage,
                    twelfthPercentage: _editedEducationInfo.twelfthPercentage,
                    collegeName: _editedEducationInfo.collegeName,
                    branch: _editedEducationInfo.branch,
                    sgpaList: _editedEducationInfo.sgpaList,
                    cgpa: _editedEducationInfo.cgpa,
                  );
                },
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "10th Percentage",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: initialData.tenthPercentage,
                          decoration: InputDecoration(
                            hintText: "88.60",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter a valid percentage";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedEducationInfo = EducationDetails(
                              id: _editedEducationInfo.id,
                              tenthSchoolName:
                                  _editedEducationInfo.tenthSchoolName,
                              twelfthSchoolName:
                                  _editedEducationInfo.twelfthSchoolName,
                              tenthPercentage: value.toString(),
                              twelfthPercentage:
                                  _editedEducationInfo.twelfthPercentage,
                              collegeName: _editedEducationInfo.collegeName,
                              branch: _editedEducationInfo.branch,
                              sgpaList: _editedEducationInfo.sgpaList,
                              cgpa: _editedEducationInfo.cgpa,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20), // Add some spacing between fields
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "12th Percentage",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: initialData.twelfthPercentage,
                          decoration: InputDecoration(
                            hintText: "76.62",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter a valid percentage";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedEducationInfo = EducationDetails(
                              id: _editedEducationInfo.id,
                              tenthSchoolName:
                                  _editedEducationInfo.tenthSchoolName,
                              twelfthSchoolName:
                                  _editedEducationInfo.twelfthSchoolName,
                              tenthPercentage:
                                  _editedEducationInfo.tenthPercentage,
                              twelfthPercentage: value.toString(),
                              collegeName: _editedEducationInfo.collegeName,
                              branch: _editedEducationInfo.branch,
                              sgpaList: _editedEducationInfo.sgpaList,
                              cgpa: _editedEducationInfo.cgpa,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                "Collage Details",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Collage Name",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: initialData.collegeName,
                decoration: InputDecoration(
                  hintText:
                      "Chhotubhai Gopalbhai Patel Institute of Technology",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.name,
                maxLines: 2,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a valid college name";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedEducationInfo = EducationDetails(
                    id: _editedEducationInfo.id,
                    tenthSchoolName: _editedEducationInfo.tenthSchoolName,
                    twelfthSchoolName: _editedEducationInfo.twelfthSchoolName,
                    tenthPercentage: _editedEducationInfo.tenthPercentage,
                    twelfthPercentage: _editedEducationInfo.twelfthPercentage,
                    collegeName: value.toString(),
                    branch: _editedEducationInfo.branch,
                    sgpaList: _editedEducationInfo.sgpaList,
                    cgpa: _editedEducationInfo.cgpa,
                  );
                },
              ),
              const SizedBox(
                height: 22,
              ),
              const Text(
                "Branch",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: initialData.branch,
                decoration: InputDecoration(
                  hintText: "Computer Engineering",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.name,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a valid branch";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedEducationInfo = EducationDetails(
                    id: _editedEducationInfo.id,
                    tenthSchoolName: _editedEducationInfo.tenthSchoolName,
                    twelfthSchoolName: _editedEducationInfo.twelfthSchoolName,
                    tenthPercentage: _editedEducationInfo.tenthPercentage,
                    twelfthPercentage: _editedEducationInfo.twelfthPercentage,
                    collegeName: _editedEducationInfo.collegeName,
                    branch: value.toString(),
                    sgpaList: _editedEducationInfo.sgpaList,
                    cgpa: _editedEducationInfo.cgpa,
                  );
                },
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                "Semester Grade Point Average (SGPA)",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 1",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[0].toString(),
                              decoration: InputDecoration(
                                hintText: "9.13",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA";
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [double.parse(value.toString())],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ), // Add some spacing between fields
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 2",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[1].toString(),
                              decoration: InputDecoration(
                                hintText: "9.39",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [
                                    ..._editedEducationInfo.sgpaList,
                                    double.parse(value.toString())
                                  ],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 3",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[2].toString(),
                              decoration: InputDecoration(
                                hintText: "9.24",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [
                                    ..._editedEducationInfo.sgpaList,
                                    double.parse(value.toString())
                                  ],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ), // Add some spacing between fields
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 4",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[3].toString(),
                              decoration: InputDecoration(
                                hintText: "8.72",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [
                                    ..._editedEducationInfo.sgpaList,
                                    double.parse(value.toString())
                                  ],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 5",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[4].toString(),
                              decoration: InputDecoration(
                                hintText: "8.14",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [
                                    ..._editedEducationInfo.sgpaList,
                                    double.parse(value.toString())
                                  ],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ), // Add some spacing between fields
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 6",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[5].toString(),
                              decoration: InputDecoration(
                                hintText: "8.26",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [
                                    ..._editedEducationInfo.sgpaList,
                                    double.parse(value.toString())
                                  ],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 7",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[6].toString(),
                              decoration: InputDecoration(
                                hintText: "9.13",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA for Sem - 7";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [
                                    ..._editedEducationInfo.sgpaList,
                                    double.parse(value.toString())
                                  ],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ), // Add some spacing between fields
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sem - 8",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: initialData.sgpaList.isEmpty
                                  ? null
                                  : initialData.sgpaList[7].toString(),
                              decoration: InputDecoration(
                                hintText: "9.02",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a valid SGPA for Sem - 8";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedEducationInfo = EducationDetails(
                                  id: _editedEducationInfo.id,
                                  tenthSchoolName:
                                      _editedEducationInfo.tenthSchoolName,
                                  twelfthSchoolName:
                                      _editedEducationInfo.twelfthSchoolName,
                                  tenthPercentage:
                                      _editedEducationInfo.tenthPercentage,
                                  twelfthPercentage:
                                      _editedEducationInfo.twelfthPercentage,
                                  collegeName: _editedEducationInfo.collegeName,
                                  branch: _editedEducationInfo.branch,
                                  sgpaList: [
                                    ..._editedEducationInfo.sgpaList,
                                    double.parse(value.toString())
                                  ],
                                  cgpa: _editedEducationInfo.cgpa,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                "Cumulative Grade Point Average (CGPA)",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: initialData.cgpa,
                decoration: InputDecoration(
                  hintText: "8.84",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.number,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a valid CGPA";
                  }

                  return null;
                },
                onSaved: (value) {
                  _editedEducationInfo.cgpa = value.toString();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
