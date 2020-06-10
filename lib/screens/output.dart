import 'package:barqr_scanner/components/themes.dart';
import 'package:flutter/material.dart';
import 'package:barqr_scanner/init.dart';
import 'dart:typed_data';

import '../components/themes.dart';

class OutputScreen extends StatefulWidget {
  final title;
  final Uint8List bytes;

  OutputScreen({this.title, this.bytes});

  @override
  _OutputScreenState createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  String title;
  Uint8List bytes;

  @override
  void initState() {
    title = widget.title;
    bytes = widget.bytes;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title:
            Text(title + ' QR Output', style: TextStyle(color: AppTheme.white)),
      ),
      body: Container(
        color: AppTheme.nearlyWhite,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 5,
                    right: 5),
                child: Container(
                    margin: EdgeInsets.all(30), child: Image.memory(bytes)),
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 20,right: 10),
        margin: EdgeInsets.only(bottom:40),
          child: FloatingActionButton(
            backgroundColor: AppTheme.background,
        child: Icon(Icons.cloud_download, color: Colors.white),
        onPressed: () {
          AppManager(context: context).saveImage(bytes);
        },
      )),
    );
  }
}
