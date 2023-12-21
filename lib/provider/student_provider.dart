import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/services/student_service.dart';

final studentInfoProvider = Provider(
  (ref) => StudentService(),
);
