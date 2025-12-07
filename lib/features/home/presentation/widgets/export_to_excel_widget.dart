import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:captin_care/features/home/data/model/students_model.dart';
import 'dart:io';

Future<void> exportToExcel(
  BuildContext context,
  List<StudentModel> students,
) async {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Students'];

  // Header style
  CellStyle headerStyle = CellStyle(
    bold: true,
    fontColorHex: "#FFFFFF",
    backgroundColorHex: "#3B82F6", // Blue background
    horizontalAlign: HorizontalAlign.Left,
  );

  // Adding Header with style
  List<String> headers = [
    'No',
    'Name',
    'School',
    'Parent Phone',
    'Payment Method',
    'Amount',
    'Status',
  ];
  for (int i = 0; i < headers.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
      ..value = headers[i]
      ..cellStyle = headerStyle;
  }

  // Adding student data
  for (int i = 0; i < students.length; i++) {
    final s = students[i];
    sheetObject.appendRow([
      i + 1,
      s.name,
      s.school,
      s.phone,
      s.paymentMethod,
      s.amout,
      s.status,
    ]);
  }

  // Save file
  Directory directory = await getApplicationDocumentsDirectory();
  String filePath = '${directory.path}/students.xlsx';
  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Excel exported successfully! Check your Documents folder.',
          ),
        ),
      ),
    );
  }
}
