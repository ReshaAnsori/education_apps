import 'dart:convert';

import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/domain/entities/user_entity.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullname,
    super.groupId,
    super.enrolledCourseIds,
    super.following,
    super.followers,
    super.bio,
    super.profilePic,
  });
  factory LocalUserModel.fromJson(String source) =>
      LocalUserModel.fromMap(json.decode(source) as DataMap);

  factory LocalUserModel.fromMap(DataMap map) {
    return LocalUserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      points: map['points'] as int,
      fullname: map['fullname'] as String,
      groupId: List<String>.from(map['groupId'] as List<String>),
      enrolledCourseIds:
          List<String>.from(map['enrolledCourseIds'] as List<String>),
      following: List<String>.from(map['following'] as List<String>),
      followers: List<String>.from(
        map['followers'] as List<String>,
      ),
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'points': points,
      'fullname': fullname,
      'groupId': groupId,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'followers': followers,
    };
  }

  String toJson() => json.encode(toMap());

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullname,
    List<String>? groupId,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullname: fullname ?? this.fullname,
      groupId: groupId ?? this.groupId,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
