class StudentModel {
  final String name;
  final String school;
  final String phone;
  final String paymentMethod;
  final String amout;
  final String status;
  final String? id;

  StudentModel({
    required this.name,
    required this.school,
    required this.phone,
    required this.paymentMethod,
    required this.amout,
    required this.status,
    this.id,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map, String id) {
    return StudentModel(
      name: map['name'] ?? '',
      school: map['school'] ?? '',
      phone: map['phone'] ?? '',
      paymentMethod: map['paymentMethod'] ?? 'InstaPay',
      amout: map['amout'] ?? '',
      status: map['status'] ?? 'Active',
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'school': school,
      'phone': phone,
      'paymentMethod': paymentMethod,
      'amout': amout,
      'status': status,
    };
  }
}
