import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/domain/repository/dashboard_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardRepositoryImp implements DashboardRepository {
  final SupabaseClient supabase;

  DashboardRepositoryImp({required this.supabase});

  // Stream for real-time updates
  @override
  Stream<List<StudentModel>> getStudentsStream() {
    return supabase
        .from('students')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((event) {
          // event = List<Map<String, dynamic>>
          return List<Map<String, dynamic>>.from(event)
              .map((map) => StudentModel.fromMap(map, map['id'].toString()))
              .toList();
        });
  }

  // Add new student
  @override
  Future<void> addStudent(StudentModel student) async {
    await supabase.from('students').insert(student.toMap());
  }

  // Update existing student
  @override
  Future<void> updateStudent(StudentModel student) async {
    await supabase
        .from('students')
        .update(student.toMap())
        .eq('id', int.parse(student.id ?? ""));
  }

  // Delete student
  @override
  Future<void> deleteStudent(String id) async {
    await supabase.from('students').delete().eq('id', int.parse(id));
  }
}
