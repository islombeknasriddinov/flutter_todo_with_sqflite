import 'dart:async';

import 'package:darmon/repository/darmon_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef void OnTapCallback(String value);

typedef ItemWidgetBuilder = Widget Function(BuildContext context, UIMedicine item);

class AutoCompleteTextView extends StatefulWidget with AutoCompleteTextInterface {
  ItemWidgetBuilder itemBuilder;

  final double maxHeight;
  final TextEditingController controller;

  //AutoCompleteTextField properties
  final cursorColor;
  final style;
  final BoxDecoration decoration;
  final tfTextAlign;

  final EdgeInsets padding;
  final String placeholder;
  final TextStyle placeholderStyle;
  final Widget prefix;
  final Widget suffix;

  //Suggestiondrop Down properties
  final Color suggestionBackground;
  final suggestionTextAlign;
  final Future<List<UIMedicine>> Function(String) getSuggestionsMethod;
  final Function focusGained;
  final Function focusLost;
  final int suggestionsApiFetchDelay;
  final Function onValueChanged;
  final Function(String) onSubmitted;

  AutoCompleteTextView(
      {@required this.controller,
      @required this.itemBuilder,
      this.maxHeight = 200,
      this.cursorColor = Colors.white,
      this.suggestionBackground,
      this.style = const TextStyle(color: Colors.black),
      this.decoration = const BoxDecoration(),
      this.tfTextAlign = TextAlign.left,
      this.suggestionTextAlign = TextAlign.left,
      @required this.getSuggestionsMethod,
      this.focusGained,
      this.suggestionsApiFetchDelay = 0,
      this.focusLost,
      this.onValueChanged,
      this.onSubmitted,
      this.padding = const EdgeInsets.all(0),
      this.placeholder,
      this.placeholderStyle,
      this.prefix,
      this.suffix});

  @override
  _AutoCompleteTextViewState createState() => _AutoCompleteTextViewState();

  //This funciton is called when a user clicks on a suggestion
  @override
  void onTappedSuggestion(String suggestion) {
    onSubmitted(suggestion);
  }
}

class _AutoCompleteTextViewState extends State<AutoCompleteTextView> {
  ScrollController scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  OverlayEntry _overlayEntry;
  LayerLink _layerLink = LayerLink();
  BehaviorSubject<List<UIMedicine>> suggestionsStreamController =
      new BehaviorSubject<List<UIMedicine>>();
  List<UIMedicine> suggestionShowList = List<UIMedicine>();
  Timer _debounce;
  bool isSearching = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
        (widget.focusGained != null) ? widget.focusGained() : () {};
      } else {
        this._overlayEntry.remove();
        (widget.focusLost != null) ? widget.focusLost() : () {};
      }
    });
    widget.controller.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: widget.suggestionsApiFetchDelay), () {
      if (isSearching == true) {
        _getSuggestions(widget.controller.text);
      }
    });
  }

  _getSuggestions(String data) async {
    if (data.length > 0 && data != null) {
      List<UIMedicine> list = await widget.getSuggestionsMethod(data);
      suggestionsStreamController.sink.add(list);
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  color: widget.suggestionBackground == null
                      ? Theme.of(context).cardColor
                      : widget.suggestionBackground,
                  elevation: 4.0,
                  child: StreamBuilder<List<UIMedicine>>(
                      stream: suggestionsStreamController.stream,
                      builder: (context, suggestionData) {
                        if (suggestionData.hasData && widget.controller.text.isNotEmpty) {
                          suggestionShowList = suggestionData.data;
                          return ConstrainedBox(
                            constraints: new BoxConstraints(
                              maxHeight: 200,
                            ),
                            child: ListView.builder(
                                controller: scrollController,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: suggestionShowList.length,
                                itemBuilder: (context, index) {
                                  UIMedicine item = suggestionShowList[index];
                                  return widget.itemBuilder.call(context, item);
                                }),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: CupertinoTextField(
        controller: widget.controller,
        decoration: widget.decoration,
        style: widget.style,
        cursorColor: widget.cursorColor,
        textAlign: widget.tfTextAlign,
        padding: widget.padding,
        placeholder: widget.placeholder,
        placeholderStyle: widget.placeholderStyle,
        onSubmitted: (text) {
          widget.controller.text = text;
          widget?.onSubmitted(text);
        },
        textInputAction: TextInputAction.search,
        prefix: widget.prefix,
        suffix: widget.suffix,
        focusNode: this._focusNode,
        onChanged: (text) {
          if (text.trim().isNotEmpty) {
            (widget.onValueChanged != null) ? widget.onValueChanged(text) : () {};
            isSearching = true;
            scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          } else {
            isSearching = false;
            suggestionsStreamController.sink.add([]);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    suggestionsStreamController.close();
    scrollController.dispose();
    widget.controller.dispose();
    super.dispose();
  }
}

abstract class AutoCompleteTextInterface {
  void onTappedSuggestion(String suggestion);
}
