import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/services/education_details_service.dart';

final educationDetailsProvider = Provider(
  (ref) => EducationDetailsService(),
);
