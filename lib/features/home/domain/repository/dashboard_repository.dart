import 'package:captin_care/features/home/data/model/students_model.dart';

abstract class DashboardRepository {
  Stream<List<StudentModel>> getStudentsStream();
  Future<StudentModel> addStudent(StudentModel student);
  Future<void> updateStudent(StudentModel student);
  Future<void> deleteStudent(String id);
}
