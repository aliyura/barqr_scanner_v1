import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:image_picker/image_picker.dart';
import 'components/dialogs.dart';
import 'dart:typed_data';
import 'package:toast/toast.dart';
import 'package:save_in_gallery/save_in_gallery.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class AppManager {
  final BuildContext context;
  AppManager({this.context});

  void addHistory(String data) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String history = storage.getString("history");
    String newHistory = data + "~" + DateTime.now().toString();
    if (history == null) {
      storage.setString("history", newHistory);
    } else {
      history = history + "," + newHistory;
      storage.setString("history", history);
    }
  }

  void resetHistory(String data) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    if (data != null) {
      storage.setString("history", data);
    }
  }

  Future<Null> scanBarQR() async {
    try {
      String cameraScanResult = await scanner.scan();
      this.addHistory(cameraScanResult);
      AppDialog(context).notify("Output", cameraScanResult, AlertType.none);
    } catch (ex) {
      AppDialog(context).show('Error Occured', ex.toString(), AlertType.error);
    }
  }

  Future<Null> pickImage() async {
    try {
      File file = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        Uint8List bytes = file.readAsBytesSync();
        String barcode = await scanner.scanBytes(bytes);
        this.addHistory(barcode);
        AppDialog(context).notify("Output", barcode, AlertType.none);
      }
    } catch (ex) {
      AppDialog(context).show('Error Occured', ex.toString(), AlertType.error);
    }
  }

  void saveImage(Uint8List bytes) async {
    final _imageSaver = ImageSaver();
    await _imageSaver.saveImage(
      imageBytes: bytes,
      directoryName: "Pictures",
    );
    Toast.show("Saved", context);
  }

  void copy(String result) async {
    Clipboard.setData(new ClipboardData(text: result));
    Toast.show("Copied", context);
  }

  void share(String result) async {
    Share.share(result);
  }
}
