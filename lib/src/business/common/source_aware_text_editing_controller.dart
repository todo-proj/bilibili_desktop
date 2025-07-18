import 'package:flutter/material.dart';

class SourceAwareTextEditingController {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<(String, bool)> textNotifier = ValueNotifier(("", false));
  bool _isProgrammaticChange = false;

  String get text  => controller.text;
  TextEditingValue get value  => controller.value;

  set text(String value) {
    _isProgrammaticChange = true;
    controller.text = value;
  }

  SourceAwareTextEditingController() {
    controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    textNotifier.value = (text, _isProgrammaticChange);
    if (_isProgrammaticChange) {
      _isProgrammaticChange = false;
    }
  }

  void clear() {
    controller.clear();
  }

  void clearProgrammatically() {
    _isProgrammaticChange = true;
    controller.clear();
  }

  void dispose() {
    controller.removeListener(_onControllerChanged);
    controller.dispose();
    textNotifier.dispose();
  }
}
