// import 'package:uuid/uuid.dart';

// const uuid = Uuid();

class CompanyDetails {
  String id;
  String companyName;
  String companyDescription;
  String technologyRequired;
  String websiteURL;
  String location;
  String stipendMin;
  String stipendMax;
  String packageMin;
  String packageMax;
  String serviceAgreement;
  String arrivalDate;
  List<String> recruitmentProcessAndCriteria;
  List<String> eligibilityCriteria;
  List<String> appliedStudents;
  List<String> studentsPlaced;

  CompanyDetails({
    required this.id,
    required this.companyName,
    required this.companyDescription,
    required this.technologyRequired,
    required this.websiteURL,
    required this.location,
    required this.stipendMin,
    required this.stipendMax,
    required this.packageMin,
    required this.packageMax,
    required this.serviceAgreement,
    required this.arrivalDate,
    required this.recruitmentProcessAndCriteria,
    required this.eligibilityCriteria,
    this.appliedStudents = const [],
    this.studentsPlaced = const [],
  });
}
