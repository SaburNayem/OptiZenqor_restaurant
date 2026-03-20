import 'dart:typed_data';

class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.membershipLevel,
    this.avatarBytes,
  });

  final String name;
  final String email;
  final String phone;
  final String membershipLevel;
  final Uint8List? avatarBytes;

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? membershipLevel,
    Uint8List? avatarBytes,
    bool clearAvatar = false,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      membershipLevel: membershipLevel ?? this.membershipLevel,
      avatarBytes: clearAvatar ? null : avatarBytes ?? this.avatarBytes,
    );
  }
}
