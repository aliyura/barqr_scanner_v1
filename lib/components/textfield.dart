import 'package:flutter/material.dart';
import 'package:barqr_scanner/components/themes.dart';

class CustomTextField extends StatelessWidget {

 final title;
 final onkey;
 final maxLines;
 final maxLength;
 final height;

 final  TextInputType inputType;
 CustomTextField({this.title,this.inputType, this.height,this.maxLength,this.maxLines,this.onkey});



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: height*20,
      child: TextField(
        style:  TextStyle(
          fontFamily: "Poppins",
        ),
        decoration: InputDecoration(
          labelText: title,
          hintStyle: AppTheme.inpuStyle,
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: AppTheme.nearlyBlack.withOpacity(0.1),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.nearlyDarkBlue),
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.only(left: 30.0, bottom: 20.0, top: 20.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.background),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        cursorColor: Colors.black12,
        keyboardType: inputType,
        maxLines: maxLength,
        maxLength: maxLength,
        onChanged: (val){
            onkey(val);
        },
      ),
    );
  }
}
