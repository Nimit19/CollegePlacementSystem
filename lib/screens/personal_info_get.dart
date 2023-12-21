import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/models/student.dart';

import '../provider/student_provider.dart';

class PersonalInfoGetter extends ConsumerStatefulWidget {
  const PersonalInfoGetter({Key? key}) : super(key: key);

  @override
  ConsumerState<PersonalInfoGetter> createState() => _PersonalInfoGetterState();
}

class _PersonalInfoGetterState extends ConsumerState<PersonalInfoGetter> {
  bool _isLoading = false;

  final _formStudentInfo = GlobalKey<FormState>();

  late StudentInfo _editedStudentInfo;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final initialStudentValue =
        await ref.read(studentInfoProvider).getStudent();
    setState(() {
      _editedStudentInfo = initialStudentValue ??
          StudentInfo(
            id: '',
            firstName: '',
            lastName: '',
            number: '',
            email: '',
            location: '',
          );
    });
  }

  void _savedForm(BuildContext ctx) async {
    final isValid = _formStudentInfo.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formStudentInfo.currentState?.save();

    final studInfo = ref.read(studentInfoProvider);

    setState(() {
      _isLoading = true;
    });

    final User? user = FirebaseAuth.instance.currentUser;
    final userProfileUrl = await FirebaseFirestore.instance
        .collection('studentsProfile')
        .doc(user!.uid)
        .get();

    _editedStudentInfo = StudentInfo(
      id: _editedStudentInfo.id,
      firstName: _editedStudentInfo.firstName,
      lastName: _editedStudentInfo.lastName,
      number: _editedStudentInfo.number,
      email: _editedStudentInfo.email,
      location: _editedStudentInfo.location,
      profileImgUrl: userProfileUrl.data()!['image_url'],
    );

    if (_editedStudentInfo.id == "") {
      await studInfo.addStudent(_editedStudentInfo);
    } else {
      await studInfo.updateStudent(_editedStudentInfo);
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
        title: const Text("Personal Information"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder<StudentInfo?>(
              future: ref.read(studentInfoProvider).getStudent(),
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
                  return _buildForm(_editedStudentInfo);
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
            onPressed: () => _savedForm(context),
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

  Widget _buildForm(StudentInfo initialData) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  top: 30,
                ),
                child: Form(
                  key: _formStudentInfo,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "First Name",
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
                        initialValue: initialData.firstName,
                        decoration: InputDecoration(
                          hintText: "Nimit",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a first name";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedStudentInfo = StudentInfo(
                            id: _editedStudentInfo.id,
                            firstName: value.toString(),
                            lastName: _editedStudentInfo.lastName,
                            number: _editedStudentInfo.number,
                            email: _editedStudentInfo.email,
                            location: _editedStudentInfo.location,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      const Text(
                        "Last Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initialData.lastName,
                        decoration: InputDecoration(
                          hintText: "Patel",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a last name";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedStudentInfo = StudentInfo(
                            id: _editedStudentInfo.id,
                            firstName: _editedStudentInfo.firstName,
                            lastName: value.toString(),
                            number: _editedStudentInfo.number,
                            email: _editedStudentInfo.email,
                            location: _editedStudentInfo.location,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      const Text(
                        "Email address",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initialData.email,
                        decoration: InputDecoration(
                          hintText: "abc@gmail.com",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return "Please enter a valid Email";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedStudentInfo = StudentInfo(
                            id: _editedStudentInfo.id,
                            firstName: _editedStudentInfo.firstName,
                            lastName: _editedStudentInfo.lastName,
                            number: _editedStudentInfo.number,
                            email: value.toString(),
                            location: _editedStudentInfo.location,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      const Text(
                        "Number",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initialData.number,
                        decoration: InputDecoration(
                          hintText: "9104939358",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length != 10) {
                            return "Please enter a valid number";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedStudentInfo = StudentInfo(
                            id: _editedStudentInfo.id,
                            firstName: _editedStudentInfo.firstName,
                            lastName: _editedStudentInfo.lastName,
                            number: value.toString(),
                            email: _editedStudentInfo.email,
                            location: _editedStudentInfo.location,
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
                        initialValue: initialData.location,
                        decoration: InputDecoration(
                          hintText:
                              "DurlabhNager Society, Chikhla, Valsad 396030",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        maxLines: 5,
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a location";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedStudentInfo = StudentInfo(
                            id: _editedStudentInfo.id,
                            firstName: _editedStudentInfo.firstName,
                            lastName: _editedStudentInfo.lastName,
                            number: _editedStudentInfo.number,
                            email: _editedStudentInfo.email,
                            location: value.toString(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
