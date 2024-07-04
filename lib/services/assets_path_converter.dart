import 'package:flutter/foundation.dart';

class AssetsPathConverter{
  String definaPath(String path){
    return kIsWeb?path:"assets/$path";
  }
}