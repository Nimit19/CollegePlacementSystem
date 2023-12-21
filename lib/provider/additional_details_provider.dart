import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/services/additional_details_service.dart';

final additionalDetailsProvider = Provider(
  (ref) => AdditionalDetailsService(),
);
