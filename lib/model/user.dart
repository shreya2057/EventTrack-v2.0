class UserModel {
  String id;
  String name;
  String email;
  String profileUrl;
  int phone;
  bool isEmailVerified;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.profileUrl,
      this.phone,
      this.isEmailVerified});

  Map<String, dynamic> toMap() {
    return {
      '_id': id ?? '',
      'name': name ?? '',
      'email': email ?? '',
      'profileUrl': profileUrl ?? '',
      'phone': phone ?? null,
      'isEmailVerified': isEmailVerified ?? false,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
      phone: map['phone'] ?? null,
      isEmailVerified: map['isEmailVerified'] ?? false,
    );
  }
}
