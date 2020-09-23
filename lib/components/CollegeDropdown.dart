import 'package:eleventh_hour/models/College.dart';
import 'package:flutter/material.dart';

class CollegeDropdown extends StatelessWidget {
  final List<DropdownMenuItem<College>> dropDownItems;
  final Function(College) onChanged;
  final String hintText;

  CollegeDropdown(
      {this.dropDownItems, this.onChanged, this.hintText = "Select College"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: DropdownButtonFormField<College>(
        decoration: InputDecoration.collapsed(
          hintStyle: TextStyle(color: Colors.black, fontFamily: 'karla'),
          hintText: this.hintText,
        ),
        validator: (College newCollege) {
          if (newCollege == null) return "Please Select College";
          return null;
        },
        items: this.dropDownItems,
        onChanged: this.onChanged,
      ),
    );
  }
}
