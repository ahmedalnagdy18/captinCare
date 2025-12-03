import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/domain/repository/dashboard_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardRepositoryImp implements DashboardRepository {
  final FirebaseFirestore firestore;

  DashboardRepositoryImp({required this.firestore});

  @override
  Stream<List<StudentModel>> getStudentsStream() {
    return firestore
        .collection('students')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => StudentModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<void> addStudent(StudentModel student) {
    return firestore.collection('students').add(student.toMap());
  }

  @override
  Future<void> updateStudent(StudentModel student) {
    return firestore
        .collection('students')
        .doc(student.id)
        .update(student.toMap());
  }

  @override
  Future<void> deleteStudent(String id) {
    return firestore.collection('students').doc(id).delete();
  }
}
