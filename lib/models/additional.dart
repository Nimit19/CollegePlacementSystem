class AdditionalDetails {
  String id;
  String aboutMe;
  List<String> skills;
  String? uploadedPdfPath; // Nullable, as it may not be uploaded initially.

  AdditionalDetails({
    required this.id,
    required this.aboutMe,
    required this.skills,
    required this.uploadedPdfPath,
  });
}
