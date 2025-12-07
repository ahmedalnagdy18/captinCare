import 'package:captin_care/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppTextfield extends StatefulWidget {
  const MainAppTextfield({
    super.key,
    this.maxLength,
    this.inputFormatters,
    required this.controller,
    required this.labelText,
  });

  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final String labelText;

  @override
  State<MainAppTextfield> createState() => _MainAppTextfieldState();
}

class _MainAppTextfieldState extends State<MainAppTextfield> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      cursorColor: AppColors.primaryBlue,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        counterText: "",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryBlue,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: _focusNode.hasFocus ? AppColors.primaryBlue : Colors.black,
        ),

        floatingLabelStyle: TextStyle(
          color: _focusNode.hasFocus ? AppColors.primaryBlue : Colors.black,
        ),
      ),
    );
  }
}
