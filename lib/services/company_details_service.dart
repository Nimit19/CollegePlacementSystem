import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/company.dart';

class CompanyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'companiesInfo';
  final User? user = FirebaseAuth.instance.currentUser;
  late List<CompanyDetails> companiesList = [];

  Stream<List<CompanyDetails>> getAllCompaniesStream() {
    return _firestore
        .collection(collectionName)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final List<CompanyDetails> loadedCompanies =
            querySnapshot.docs.map((doc) {
          return CompanyDetails(
            id: doc.id,
            companyName: doc.get('companyName'),
            companyDescription: doc.get('companyDescription'),
            technologyRequired: doc.get('technologyRequired'),
            websiteURL: doc.get('websiteURL'),
            location: doc.get('location'),
            stipendMin: doc.get('stipendMin'),
            stipendMax: doc.get('stipendMax'),
            packageMin: doc.get('packageMin'),
            packageMax: doc.get('packageMax'),
            serviceAgreement: doc.get('serviceAgreement'),
            arrivalDate: doc.get('arrivalDate'),
            recruitmentProcessAndCriteria:
                List<String>.from(doc.get('recruitmentProcessAndCriteria')),
            eligibilityCriteria:
                List<String>.from(doc.get('eligibilityCriteria')),
            appliedStudents: List<String>.from(doc.get('appliedStudents')),
            studentsPlaced: List<String>.from(doc.get('studentsPlaced')),
          );
        }).toList();
        companiesList = loadedCompanies;
        return loadedCompanies;
      } else {
        return [];
      }
    });
  }

  Future<List<CompanyDetails>> getAllCompanies() async {
    try {
      final querySnapshot = await _firestore.collection(collectionName).get();
      final List<CompanyDetails> loadedCompanies =
          querySnapshot.docs.map((doc) {
        return CompanyDetails(
          id: doc.id,
          companyName: doc.get('companyName'),
          companyDescription: doc.get('companyDescription'),
          technologyRequired: doc.get('technologyRequired'),
          websiteURL: doc.get('websiteURL'),
          location: doc.get('location'),
          stipendMin: doc.get('stipendMin'),
          stipendMax: doc.get('stipendMax'),
          packageMin: doc.get('packageMin'),
          packageMax: doc.get('packageMax'),
          serviceAgreement: doc.get('serviceAgreement'),
          arrivalDate: doc.get('arrivalDate'),
          recruitmentProcessAndCriteria:
              List<String>.from(doc.get('recruitmentProcessAndCriteria')),
          eligibilityCriteria:
              List<String>.from(doc.get('eligibilityCriteria')),
          appliedStudents: List<String>.from(doc.get('appliedStudents')),
          studentsPlaced: List<String>.from(doc.get('studentsPlaced')),
        );
      }).toList();

      companiesList = loadedCompanies;

      return loadedCompanies;
    } catch (e) {
      // Handle errors here, e.g., by returning an empty list or rethrowing the exception.
      print('Error fetching companies: $e');
      return [];
    }
  }

  Future<void> addCompany(CompanyDetails companyDetails) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final id = Uuid().v4();

      if (user != null) {
        await _firestore.collection(collectionName).doc(id).set({
          'id': id,
          'companyName': companyDetails.companyName,
          'companyDescription': companyDetails.companyDescription,
          'technologyRequired': companyDetails.technologyRequired,
          'websiteURL': companyDetails.websiteURL,
          'location': companyDetails.location,
          'stipendMin': companyDetails.stipendMin,
          'stipendMax': companyDetails.stipendMax,
          'packageMin': companyDetails.packageMin,
          'packageMax': companyDetails.packageMax,
          'serviceAgreement': companyDetails.serviceAgreement,
          'arrivalDate': companyDetails.arrivalDate,
          'recruitmentProcessAndCriteria':
              companyDetails.recruitmentProcessAndCriteria,
          'eligibilityCriteria': companyDetails.eligibilityCriteria,
          'appliedStudents': companyDetails.appliedStudents,
          'studentsPlaced': companyDetails.studentsPlaced,
        });

        companiesList.add(
          CompanyDetails(
            id: id,
            companyName: companyDetails.companyName,
            companyDescription: companyDetails.companyDescription,
            technologyRequired: companyDetails.technologyRequired,
            websiteURL: companyDetails.websiteURL,
            location: companyDetails.location,
            stipendMin: companyDetails.stipendMin,
            stipendMax: companyDetails.stipendMax,
            packageMin: companyDetails.packageMin,
            packageMax: companyDetails.packageMax,
            serviceAgreement: companyDetails.serviceAgreement,
            arrivalDate: companyDetails.arrivalDate,
            recruitmentProcessAndCriteria:
                companyDetails.recruitmentProcessAndCriteria,
            eligibilityCriteria: companyDetails.eligibilityCriteria,
            appliedStudents: companyDetails.appliedStudents,
            studentsPlaced: companyDetails.studentsPlaced,
          ),
        );
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error adding company: $e');
    }
  }

  Future<void> updateCompany(CompanyDetails updatedCompanyDetails) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore
            .collection(collectionName)
            .doc(updatedCompanyDetails.id)
            .update({
          'companyName': updatedCompanyDetails.companyName,
          'companyDescription': updatedCompanyDetails.companyDescription,
          'technologyRequired': updatedCompanyDetails.technologyRequired,
          'websiteURL': updatedCompanyDetails.websiteURL,
          'location': updatedCompanyDetails.location,
          'stipendMin': updatedCompanyDetails.stipendMin,
          'stipendMax': updatedCompanyDetails.stipendMax,
          'packageMin': updatedCompanyDetails.packageMin,
          'packageMax': updatedCompanyDetails.packageMax,
          'serviceAgreement': updatedCompanyDetails.serviceAgreement,
          'arrivalDate': updatedCompanyDetails.arrivalDate,
          'recruitmentProcessAndCriteria':
              updatedCompanyDetails.recruitmentProcessAndCriteria,
          'eligibilityCriteria': updatedCompanyDetails.eligibilityCriteria,
          'appliedStudents': updatedCompanyDetails.appliedStudents,
          'studentsPlaced': updatedCompanyDetails.studentsPlaced,
        });

        final existingCompanyIndex =
            companiesList.indexWhere((c) => c.id == updatedCompanyDetails.id);
        if (existingCompanyIndex != -1) {
          companiesList[existingCompanyIndex] = updatedCompanyDetails;
        }
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error updating company: $e');
    }
  }

  Future<void> deleteCompany(String companyId) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _firestore.collection(collectionName).doc(companyId).delete();

        final existingCompanyIndex =
            companiesList.indexWhere((c) => c.id == companyId);
        if (existingCompanyIndex != -1) {
          companiesList.removeAt(existingCompanyIndex);
        }
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error deleting company: $e');
    }
  }

  CompanyDetails findById(String id) {
    return companiesList.firstWhere((element) => element.id == id);
  }

  List<CompanyDetails> get allCompaniesLocal {
    return companiesList;
  }
}
