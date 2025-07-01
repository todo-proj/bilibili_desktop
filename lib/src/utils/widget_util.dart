import 'package:flutter/material.dart';

extension SziedBoxExt on num {

  SizedBox get wSize => SizedBox(width: toDouble(),);
  SizedBox get hSize => SizedBox(height: toDouble(),);

}