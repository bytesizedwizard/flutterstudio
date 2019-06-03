import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';

class Bloc {
  final BehaviorSubject<String> _menuOptionController = BehaviorSubject<String>();
  Stream<String> get getSelectedMenu => _menuOptionController.stream;
  Function(String) get setSelectedMenu => _menuOptionController.sink.add;

  final BehaviorSubject<String> _codeGenerationController = BehaviorSubject<String>();
  Stream<String> get getGeneratedCode => _codeGenerationController.stream;

  void generateCode(String codeBlock) {
    if(_codeGenerationController.hasValue) {
      _codeGenerationController.sink.add(
        _codeGenerationController.value.replaceAll("404Found", codeBlock),
      );
    } else {
      _codeGenerationController.sink.add(codeBlock);
    }
  }

  void share() async{
    await Share.share(_codeGenerationController.value);
  }

  void copy() {
    Clipboard.setData(ClipboardData(text: _codeGenerationController.value));
  }

  void writeToStorage() async{
    bool checkResult =
    await SimplePermissions.checkPermission(Permission.WriteExternalStorage);

    if(!checkResult) {
      var status = await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);

      if(status == PermissionStatus.authorized) {
        Directory externalDirectory = await getExternalStorageDirectory();
        File myFile = File(externalDirectory.path + "/temp.dart");

        myFile.writeAsStringSync(_codeGenerationController.value);
      }
    } else {
      Directory externalDirectory = await getExternalStorageDirectory();
      File myFile = File(externalDirectory.path + "/temp.dart");

      myFile.writeAsStringSync(_codeGenerationController.value);
    }
  }

}