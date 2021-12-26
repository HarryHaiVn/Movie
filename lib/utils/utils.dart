// ignore: camel_case_types
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(BuildContext context, String errorMessage) async {
    await Future.delayed(Duration.zero);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  static loadedPathImage(String path) {
    return Endpoints.baseUrlImage + path;
  }
}
