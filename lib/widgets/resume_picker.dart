import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/additional_details_provider.dart';

class ResumePicker extends ConsumerStatefulWidget {
  const ResumePicker(
      {super.key, required this.onPickResume, required this.uploadResumeUrl});

  final void Function(String pickedResumeUrl) onPickResume;
  final String? uploadResumeUrl;
  @override
  ConsumerState<ResumePicker> createState() => _ResumePickerState();
}

class _ResumePickerState extends ConsumerState<ResumePicker> {
  bool isLoading = false;
  bool isPdfUploaded = false;
  String? uploadedResumePath;

  @override
  void initState() {
    super.initState();

    if (widget.uploadResumeUrl != '' && widget.uploadResumeUrl != null) {
      uploadedResumePath = "Resume.pdf";
      isPdfUploaded = true;
      widget.onPickResume(widget.uploadResumeUrl!);
    }
  }

  Future<void> handleFileSelection() async {
    File pickedResume;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      try {
        setState(() {
          isLoading = true;
          uploadedResumePath = result.files.single.name;
          isPdfUploaded = true;
        });

        final additionalInfo = ref.watch(additionalDetailsProvider);
        pickedResume = File(result.files.single.path.toString());

        final pickResumeUrl =
            await additionalInfo.uploadResumeToStorage(pickedResume);

        widget.onPickResume(pickResumeUrl);

        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        print("Error uploading resume: $e");
      }
    }
  }

  Widget buildUploadedPdfView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.cloud_done_rounded,
          size: 80,
          color: Color(0xFF050A30),
        ),
        const SizedBox(height: 10),
        Text(
          "Uploaded PDF: $uploadedResumePath",
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleFileSelection,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Set the border color here
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: isPdfUploaded
                    ? buildUploadedPdfView()
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_rounded,
                            size: 80,
                            color: Color(0xFF050A30),
                          ),
                          Text(
                            "Upload Resume",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
