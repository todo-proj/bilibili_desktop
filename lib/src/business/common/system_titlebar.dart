import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'app_icons.dart';

class SystemTitleBar extends StatefulWidget {
  const SystemTitleBar({super.key});

  @override
  State<SystemTitleBar> createState() => _SystemTitleBarState();
}

class _SystemTitleBarState extends State<SystemTitleBar> {

  bool _isMaximized = false;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              windowManager.minimize();
            },
            icon: const Icon(AppIcons.minimize),
          ),
          IconButton(
            onPressed: () async {
              _isMaximized = await windowManager.isMaximized();
              if (_isMaximized) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
              setState(() {
                _isMaximized = !_isMaximized;
              });
            },
            icon: _isMaximized ? const Icon(AppIcons.unMaximize) : const Icon(AppIcons.maximize),
          ),
          IconButton(
            onPressed: () {
              windowManager.close();
            },
            icon: const Icon(AppIcons.shutDown),
          )
        ]
    );
  }
}
