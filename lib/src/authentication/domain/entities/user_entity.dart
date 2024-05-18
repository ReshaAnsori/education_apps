import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullname,
    this.groupId = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
    this.profilePic,
    this.bio,
  });

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullname;
  final List<String> groupId;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object> get props => [uid, email];

  @override
  String toString() =>
      'LocalUser{uid: $uid, email: $email, fullname: $fullname '
      'bio: $bio, point: $points}';
}
