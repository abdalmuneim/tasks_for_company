const String tableAdmin = 'admins';

class AdminFields {
  static final List<String> values = [id, name, password];

  static const String id = 'id';
  static const String name = 'name';
  static const String password = 'password';
}

class AdminModel {
  final int? id;
  final String name;
  final String password;

  AdminModel({
    this.id,
    required this.name,
    required this.password,
  });

  AdminModel copy({
    int? id,
    String? name,
    String? password,
  }) =>
      AdminModel(
        id: id ?? this.id,
        name: name ?? this.name,
        password: password ?? this.password,
      );

  static AdminModel fromJson(Map<String, Object?> json) => AdminModel(
        id: json[AdminFields.id] as int,
        name: json[AdminFields.name] as String,
        password: json[AdminFields.password] as String,
      );

  Map<String, Object?> toJson() => {
        AdminFields.id: id,
        AdminFields.name: name,
        AdminFields.password: password,
      };
}
