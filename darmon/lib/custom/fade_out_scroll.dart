import 'package:flutter/material.dart';

class FadeOutScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;

  FadeOutScroll(
      {Key key,
        @required this.scrollController,
        @required this.child,
        this.zeroOpacityOffset = 0,
        this.fullOpacityOffset = 0});

  @override
  _FadeOutScrollState createState() => _FadeOutScrollState();
}

class _FadeOutScrollState extends State<FadeOutScroll> {
  double _offset;

  @override
  initState() {
    super.initState();
    _offset = widget.scrollController.offset;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  double _calculateOpacity() {
    if (widget.fullOpacityOffset == widget.zeroOpacityOffset)
      return 1;
    else if (widget.zeroOpacityOffset > widget.fullOpacityOffset) {
      // fading in
      if (_offset <= widget.fullOpacityOffset)
        return 0;
      else if (_offset >= widget.zeroOpacityOffset)
        return 1;
      else
        return (_offset - widget.fullOpacityOffset) / (widget.zeroOpacityOffset - widget.fullOpacityOffset);
    } else {
      // fading out
      if (_offset <= widget.zeroOpacityOffset)
        return 1;
      else if (_offset >= widget.fullOpacityOffset)
        return 0;
      else
        return (_offset - widget.zeroOpacityOffset) / (widget.fullOpacityOffset - widget.zeroOpacityOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: widget.child,
    );
  }
}