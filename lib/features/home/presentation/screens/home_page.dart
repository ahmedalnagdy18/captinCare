import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/presentation/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:captin_care/features/home/presentation/widgets/dashboard_card_widget.dart';
import 'package:captin_care/features/home/presentation/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ------- ADD OR EDIT STUDENT DIALOG -------
  void openStudentForm({StudentModel? student}) {
    final nameCtrl = TextEditingController(text: student?.name ?? "");
    final schoolCtrl = TextEditingController(text: student?.school ?? "");
    final phoneCtrl = TextEditingController(text: student?.phone ?? "");
    String status = student?.status ?? "Active";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(student == null ? "Add Student" : "Edit Student"),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: schoolCtrl,
                  decoration: const InputDecoration(labelText: "School"),
                ),
                TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(labelText: "Parent Phone"),
                ),
                DropdownButtonFormField(
                  value: status,
                  items: ["Active", "Paused"]
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => status = v!,
                  decoration: const InputDecoration(labelText: "Status"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final cubit = context.read<DashboardCubit>();
                if (student == null) {
                  cubit.addNewStudent(
                    StudentModel(
                      name: nameCtrl.text,
                      school: schoolCtrl.text,
                      phone: phoneCtrl.text,
                      status: status,
                    ),
                  );
                } else {
                  cubit.updateExistingStudent(
                    StudentModel(
                      id: student.id,
                      name: nameCtrl.text,
                      school: schoolCtrl.text,
                      phone: phoneCtrl.text,
                      status: status,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3B82F6);
    const bgColor = Color(0xFFF3F4F6);
    const textColor = Color(0xFF111827);

    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        List<StudentModel> students = [];
        if (state is DashboardLoaded) {
          students = state.students;
        }
        return Scaffold(
          backgroundColor: bgColor,
          body: Row(
            children: [
              // ------------------ SIDEBAR ------------------
              SliderWidget(),

              // ------------------ MAIN CONTENT ------------------
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar (Dashboard title + Admin icon)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0xFFD1D5DB),
                                child: Icon(Icons.person, color: textColor),
                              ),
                              SizedBox(width: 8),
                              Text('Admin'),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // ------------------ CARDS ------------------
                      SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            DashboardCardWidget(
                              title: "Total Students",
                              number: "${students.length}",
                            ),
                            SizedBox(width: 20),
                            DashboardCardWidget(
                              title: "Active Students",
                              number:
                                  "${students.where((e) => e.status == "Active").length}",
                            ),
                            SizedBox(width: 20),
                            DashboardCardWidget(
                              title: "Paused Accounts",
                              number:
                                  "${students.where((e) => e.status == "Paused").length}",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ------------------ STUDENTS LIST HEADER ------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Students List",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 14,
                              ),
                            ),
                            onPressed: () => openStudentForm(),
                            child: const Text(
                              "Add Student",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Search bar
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFD1D5DB)),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),
                      // ------------------ STUDENTS TABLE ------------------
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // مهمة علشان لما العرض يصغر
                          child: DataTable(
                            headingRowColor: MaterialStateProperty.all(
                              Colors.grey.shade200,
                            ),
                            columnSpacing: 40,
                            horizontalMargin: 20,
                            columns: const [
                              DataColumn(label: Text("#")),
                              DataColumn(label: Text("Name")),
                              DataColumn(label: Text("School")),
                              DataColumn(label: Text("Parent Phone")),
                              DataColumn(label: Text("Status")),
                              DataColumn(label: Text("Actions")),
                            ],
                            rows: List.generate(students.length, (i) {
                              final s = students[i];
                              return DataRow(
                                cells: [
                                  DataCell(Text("${i + 1}")),
                                  DataCell(Text(s.name)),
                                  DataCell(Text(s.school)),
                                  DataCell(Text(s.phone)),
                                  DataCell(
                                    Row(
                                      children: [
                                        Text(s.status),
                                        SizedBox(width: 6),
                                        s.status == "Paused"
                                            ? Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () =>
                                              openStudentForm(student: s),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () => context
                                              .read<DashboardCubit>()
                                              .removeStudent(s.id!),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
