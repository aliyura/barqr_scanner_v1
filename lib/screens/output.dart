import 'package:barqr_scanner/components/themes.dart';
import 'package:flutter/material.dart';
import 'package:barqr_scanner/init.dart';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';

class OutputScreen extends StatefulWidget {

  final title;
  final Uint8List bytes;

  OutputScreen({this.title,this.bytes});

  @override
  _OutputScreenState createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {

    String  title;
    Uint8List bytes;


  @override
  void initState() {
    title=widget.title;
    bytes=widget.bytes;
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Text(title+' QR Output', style: TextStyle(color: AppTheme.white)),
      ),
      body: Container(
        color: AppTheme.nearlyWhite,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: Column(
              children: <Widget>[
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
                      left: 16,
                      right: 16),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child:Image.memory(bytes)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                               AppManager(context:context).saveImage(bytes);
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Download',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
