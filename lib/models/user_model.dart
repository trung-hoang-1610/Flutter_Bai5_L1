class User {
  final String id;
  final String name;
  final String email;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
    );
  }
}
