import 'package:flutter/material.dart';
import 'package:flutterbeginner/global/constant/color_const.dart';
import 'package:flutterbeginner/global/constant/string_const.dart';
import 'package:flutterbeginner/global/utils/widget_helper.dart';

class TextFieldWidget extends StatefulWidget {
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  BuildContext _ctx;
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBarWithBackBtn(context, StringConst.TEXT_FIELD_TITLE),
        body: Builder(
          builder: (context) => _createUi(context),
        ));
  }

  Widget _createUi(BuildContext context) {
    _ctx = context;
    return new Container(
        padding: EdgeInsets.all(5.0),
        child: new Center(
          child: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                _getTextFieldType(),
              ],
            ),
          ),
        ));
  }

  Widget _getTextFieldType() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        edtMobileNoField(TextEditingController()),
        SizedBox(height: 10),
        edtPwdField(TextEditingController(), _passwordVisible, pwdVisClick),
//        buildTextFied(context, 'Password', ColorConst.APP_COLOR, true),
        SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.send,
          textCapitalization: TextCapitalization.words,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w300),
          cursorColor: Colors.green,
//          cursorRadius: Radius.circular(16.0),
//          cursorWidth: 16.0,
          obscureText: true,
          maxLines: 1,
          maxLength: 20,
          decoration: InputDecoration(
              hintText: "All Demo Param",
              hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
              errorStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.red)),
        ),
        SizedBox(height: 10),
        TextField(
            decoration: InputDecoration(
              hintText: "PrefixIcon Input Field",
              icon: Icon(Icons.person_pin),
              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            )),
        SizedBox(height: 10),
        TextField(
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
              hintText: "Outline Input Border",
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            )),
        SizedBox(height: 10),
        TextField(
            decoration: InputDecoration(
              hintText: "PrefixIcon Input Field",
              prefixIcon: Icon(Icons.call),
              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            )),
        SizedBox(height: 10),
        TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Email id",
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            )),
        SizedBox(height: 10),
        TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Outline Input Border",
              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            )),
        SizedBox(height: 10),
        TextField(
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              border: OutlineInputBorder(
                  gapPadding: 30, borderRadius: BorderRadius.circular(30)),
              hintText: "Outline Radius Input Border",
              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
            )),
        SizedBox(height: 10),
        _dropDown(),
        SizedBox(height: 10),
      ],
    );
  }

  pwdVisClick() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  DropdownButton _dropDown() => DropdownButton<String>(
    items: [
      DropdownMenuItem<String>(
        value: "First",
        child: Text(
          "First",
        ),
      ),
      DropdownMenuItem<String>(
        value: "Second",
        child: Text(
          "Second",
        ),
      ),
    ],
    onChanged: (value) {
      setState(() {
        showSnackBar(_ctx, value);
      });
    },
//    value: _value,
  );

}
