import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Color hoverColor;

  const HoverText({
    Key? key,
    required this.text,
    this.style,
    required this.hoverColor,
  }) : super(key: key);

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Text(
        widget.text,
        style: widget.style?.copyWith(
          color: _hovering ? widget.hoverColor : widget.style?.color,
        ) ??
            TextStyle(color: _hovering ? widget.hoverColor : null),
      ),
    );
  }
}


class HoverEffect extends StatefulWidget {
  final Widget Function(bool isHovering) builder;

  const HoverEffect({Key? key, required this.builder}) : super(key: key);

  @override
  _HoverEffectState createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: widget.builder(_isHovering),
    );
  }
}