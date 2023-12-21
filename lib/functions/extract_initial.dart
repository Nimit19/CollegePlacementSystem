String extractInitials(String fullName) {
  List<String> nameParts = fullName.split(' ');

  String initials = "";

  for (String part in nameParts) {
    if (part.isNotEmpty && initials.length < 2) {
      initials += part[0].toUpperCase();
    }
  }

  return initials;
}
