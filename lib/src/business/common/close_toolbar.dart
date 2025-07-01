import 'dart:io';

import 'package:flutter/material.dart';

class CloseToolbar extends StatelessWidget {

  final VoidCallback onClose;
  const CloseToolbar({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: Platform.isMacOS ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
