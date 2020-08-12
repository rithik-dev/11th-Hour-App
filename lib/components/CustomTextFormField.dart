import 'package:eleventh_hour/utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final Function onChanged;
  final Function trailingFunction;
  final String defaultValue;
  final bool showTrailingWidget;
  final bool autofocus;
  final Function validator;
  final IconData icon;

  CustomTextFormField(
      {@required this.labelText,
      @required this.onChanged,
      this.trailingFunction,
      this.showTrailingWidget = true,
      this.defaultValue,
      this.autofocus = false,
      this.validator,
      this.icon});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final Map<String, TextInputType> keyboardTypes = {
    'Email': TextInputType.emailAddress,
    'Password': TextInputType.visiblePassword,
    'Phone': TextInputType.phone,
  };

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.widget.icon == null ? null : Icon(this.widget.icon),
      title: TextFormField(
        validator: this.widget.validator,
        initialValue: this.widget.defaultValue ?? "",
        textAlign: TextAlign.center,
        autofocus: this.widget.autofocus,
        keyboardType:
            keyboardTypes[this.widget.labelText] ?? TextInputType.text,
        onChanged: this.widget.onChanged,
        obscureText:
            (this.widget.labelText == "Password") ? !_showPassword : false,
        decoration: kTextFieldDecoration.copyWith(
          border: InputBorder.none,
          hintText: "Enter ${this.widget.labelText}",
          labelText: this.widget.labelText,
        ),
      ),
      trailing: (this.widget.labelText == "Password")
          ? IconButton(
              color: Colors.lightBlueAccent,
              icon: _showPassword
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              iconSize: 30.0,
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            )
          : null,
    );
  }
}
