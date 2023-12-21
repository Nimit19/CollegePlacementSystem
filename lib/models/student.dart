// class StudentInfo {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String number;
//   final String location;
//   final bool isPlaced;
//   late final String profileImgUrl;

//   StudentInfo({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.number,
//     required this.location,
//     this.isPlaced = false,
//     this.profileImgUrl = "",
//   });
// }

class StudentInfo {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String number;
  final String location;
  final bool isPlaced;
  late final String profileImgUrl;

  StudentInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.number,
    required this.location,
    this.isPlaced = false,
    this.profileImgUrl = "",
  });
}
