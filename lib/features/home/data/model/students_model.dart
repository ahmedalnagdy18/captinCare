class StudentModel {
  final String name;
  final String school;
  final String phone;
  final String status;
  final String? id; // Firestore doc ID (optional)

  StudentModel({
    required this.name,
    required this.school,
    required this.phone,
    required this.status,
    this.id,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map, String id) {
    return StudentModel(
      name: map['name'] ?? '',
      school: map['school'] ?? '',
      phone: map['phone'] ?? '',
      status: map['status'] ?? 'Active',
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'school': school,
      'phone': phone,
      'status': status,
    };
  }
}
