import 'dart:typed_data';
import 'package:barqr_scanner/screens/output.dart';
import 'package:flutter/material.dart';
import 'package:barqr_scanner/components/dialogs.dart';
import 'package:barqr_scanner/components/themes.dart';
import 'package:barqr_scanner/components/textfield.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class Generator {
  final context;
  Generator({this.context});

  Future<Null> _generateQR(String type,String body) async {
    try {
      if (body.isNotEmpty) {
        Uint8List bytes = await scanner.generateBarCode(body);
                AppDialog(context).closeDialog();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OutputScreen(
          title: type,
          bytes: bytes,
        )));
      }

    } catch (ex) {
         AppDialog(context).closeDialog();
      AppDialog(context)
          .show('Error Occured', ex.toString(), AlertType.error);
    }
 
  }

  void requestDialog(String type) {
    String generatorData, username, password;

    AppDialog(context).requestDialog(
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10),
          height: type == "Text"
              ? MediaQuery.of(context).size.height / 1.9
              : type == "Credentials"
                  ? MediaQuery.of(context).size.height / 2.2
                  : MediaQuery.of(context).size.height / 2.9,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: AppTheme.white,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Create QR for ' + type,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: InkWell(
                          child: Icon(Icons.cancel),
                          onTap: () {
                            AppDialog(context).closeDialog();
                          },
                        ),
                      )),
                ],
              ),
              type == "Text"
                  ? CustomTextField(
                      title: "Add the " + type + " here...",
                      inputType: TextInputType.multiline,
                      maxLines: 3,
                      maxLength: 60,
                      height: 10.0,
                      onkey: (val) {
                        generatorData = val;
                      },
                    )
                  : type == "Credentials"
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              CustomTextField(
                                title: "Username",
                                inputType: TextInputType.text,
                                maxLines: 1,
                                height: 3.5,
                                onkey: (val) {
                                  username = val;
                                },
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                title: "Password",
                                inputType: TextInputType.text,
                                maxLines: 1,
                                height: 3.5,
                                onkey: (val) {
                                  password = val;
                                },
                              )
                            ],
                          ),
                        )
                      : CustomTextField(
                          title: "Add the " + type + " here...",
                          inputType: type == "Email"
                              ? TextInputType.emailAddress
                              : type == "Phone"
                                  ? TextInputType.phone
                                  : type == "Password"
                                      ? TextInputType.visiblePassword
                                      : type == "Link"
                                          ? TextInputType.url
                                          : TextInputType.text,
                          maxLines: 3,
                          maxLength: 60,
                          height: 4.0,
                          onkey: (val) {
                            generatorData = val;
                          },
                        ),
              SizedBox(height: 20),
              Container(
                  child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  hoverColor: AppTheme.nearlyWhite,
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: AppTheme.nearlyBlack,
                  elevation: 0,
                  onPressed: () {
                    if (type == "Credentials") {
                      generatorData = username + "/" + password;
                    }
                    _generateQR(type,generatorData);
                  },
                ),
              )),
            ],
          )),
    );
  }
}
