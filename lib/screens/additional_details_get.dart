import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/custom_dialog.dart';
import '../models/additional.dart';
import '../provider/additional_details_provider.dart';
import '../widgets/resume_picker.dart';

class AdditionalDetailsGetter extends ConsumerStatefulWidget {
  const AdditionalDetailsGetter({super.key});

  @override
  ConsumerState<AdditionalDetailsGetter> createState() =>
      _AdditionalDetailsGetterState();
}

class _AdditionalDetailsGetterState
    extends ConsumerState<AdditionalDetailsGetter> {
  bool _isLoading = false;

  String? resumeUrl;

  final _formAdditionalDetails = GlobalKey<FormState>();

  late AdditionalDetails _editedAdditionalInfo;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final initialStudentValue =
        await ref.read(additionalDetailsProvider).getAdditionalDetailsFuture();

    setState(() {
      _editedAdditionalInfo = initialStudentValue ??
          AdditionalDetails(
            id: '',
            aboutMe: '',
            skills: [],
            uploadedPdfPath: '',
          );
    });

    // print(_editedAdditionalInfo.uploadedPdfPath);
  }

  Future<void> _savedAdditionDetails(BuildContext ctx) async {
    final isValid = _formAdditionalDetails.currentState?.validate();

    if (!isValid!) {
      return;
    }

    if (resumeUrl == null) {
      showCustomDialog(ctx, "Resume Upload", "Plz Upload the Resume");
      return;
    }

    _formAdditionalDetails.currentState?.save();

    final additionalInfo = ref.read(additionalDetailsProvider);
    setState(() {
      _isLoading = true;
    });

    if (_editedAdditionalInfo.id == "") {
      await additionalInfo.addAdditionalDetails(_editedAdditionalInfo);
    } else {
      await additionalInfo.updateAdditionalDetails(_editedAdditionalInfo);
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
        title: const Text("Additional Details"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder<AdditionalDetails?>(
              future: ref
                  .read(additionalDetailsProvider)
                  .getAdditionalDetailsFuture(),
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
                  return _buildForm(_editedAdditionalInfo);
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
            onPressed: () async {
              await _savedAdditionDetails(context);
            },
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

  Widget _buildForm(AdditionalDetails initialData) {
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
                  top: 16,
                ),
                child: Form(
                  key: _formAdditionalDetails,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "About Me",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initialData.aboutMe,
                        maxLines: 7,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          hintText:
                              "I'm Nimit Patel, a computer engineer with a focus on mobile app development using Flutter. My passion lies in creating sleek, user-friendly apps and staying at the forefront of technology trends. As a proactive learner, I'm always excited to embrace new technologies and adapt to the ever-evolving world of software development. Let's connect and explore the exciting possibilities of the digital realm together!",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        maxLength: 250,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter the about me";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedAdditionalInfo = AdditionalDetails(
                            id: _editedAdditionalInfo.id,
                            aboutMe: value.toString(),
                            skills: _editedAdditionalInfo.skills,
                            uploadedPdfPath:
                                _editedAdditionalInfo.uploadedPdfPath,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Skills",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initialData.skills.join(",").toString(),
                        decoration: InputDecoration(
                          hintText: "Flutter, Java, Dart, Javascript",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your skills";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          var val = value.toString().split(",");
                          _editedAdditionalInfo = AdditionalDetails(
                            id: _editedAdditionalInfo.id,
                            aboutMe: _editedAdditionalInfo.aboutMe,
                            skills: val,
                            uploadedPdfPath:
                                _editedAdditionalInfo.uploadedPdfPath,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      const Text(
                        "Upload Resume",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ResumePicker(
                        onPickResume: (pickedResumeUrl) {
                          resumeUrl = pickedResumeUrl;
                          _editedAdditionalInfo = AdditionalDetails(
                            id: _editedAdditionalInfo.id,
                            aboutMe: _editedAdditionalInfo.aboutMe,
                            skills: _editedAdditionalInfo.skills,
                            uploadedPdfPath: pickedResumeUrl,
                          );
                        },
                        uploadResumeUrl: initialData.uploadedPdfPath,
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
