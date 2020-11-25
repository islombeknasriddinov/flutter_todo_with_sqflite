import 'dart:async' as async;

import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:rxdart/rxdart.dart';

typedef void OnTapCallback(String value);

typedef ItemWidgetBuilder = Widget Function(
    BuildContext context, UIMedicineMark item);

class AutoCompleteTextView extends StatefulWidget
    with AutoCompleteTextInterface {
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
  final Future<List<UIMedicineMark>> Function(String) getSuggestionsMethod;
  final Function focusGained;
  final Function focusLost;
  final Function moreBtnOnTapCallback;
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
      this.moreBtnOnTapCallback,
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
  BehaviorSubject<List<UIMedicineMark>> suggestionsStreamController =
      new BehaviorSubject<List<UIMedicineMark>>();

  LazyStream<bool> isClearActive = new LazyStream<bool>(() => false);

  List<UIMedicineMark> suggestionShowList = List<UIMedicineMark>();
  async.Timer _debounce;
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
    _debounce = async.Timer(
        Duration(milliseconds: widget.suggestionsApiFetchDelay), () {
      if (isSearching == true) {
        _getSuggestions(widget.controller.text);
      }
    });
  }

  _getSuggestions(String data) async {
    if (data.length > 0 && data != null) {
      List<UIMedicineMark> list = await widget.getSuggestionsMethod(data);
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
                  child: StreamBuilder<List<UIMedicineMark>>(
                      stream: suggestionsStreamController.stream,
                      builder: (context, suggestionData) {
                        if (suggestionData.hasData &&
                            widget.controller.text.isNotEmpty) {
                          suggestionShowList = suggestionData.data;
                          return ConstrainedBox(
                            constraints: new BoxConstraints(
                              maxHeight: 200,
                            ),
                            child: ListView.builder(
                                controller: scrollController,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: suggestionShowList.length > 0
                                    ? suggestionShowList.length + 1
                                    : 0,
                                itemBuilder: (context, index) {
                                  if (index == 0) return _buildMoreBtn();
                                  UIMedicineMark item =
                                      suggestionShowList[index - 1];
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

  Widget _buildMoreBtn() {
    return MyTable.horizontal(
      [
        MyText(
          R.strings.more,
          style: TS_Overline(textColor: R.colors.app_color),
          lowerCase: true,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        )
      ],
      onTapCallback: widget?.moreBtnOnTapCallback != null
          ? widget.moreBtnOnTapCallback
          : () {},
      width: double.infinity,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
    );
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
        suffix: widget.suffix ??
            StreamBuilder<bool>(
                stream: isClearActive.stream,
                builder: (_, snapshot) {
                  if (snapshot?.data == true) {
                    return MyIcon.icon(
                      Icons.clear,
                      color: R.colors.iconColors,
                      onTap: () {
                        widget?.controller?.clear();
                        onTextChanged("");
                      },
                    );
                  } else {
                    return Container(height: 1, width: 1);
                  }
                }),
        focusNode: this._focusNode,
        onChanged: (text) {
          onTextChanged(text);
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

  void onTextChanged(String text) {
    if (text?.isNotEmpty == true) {
      if (isClearActive.value != true) isClearActive.add(true);
    } else {
      if (isClearActive.value != false) isClearActive.add(false);
    }

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
  }
}

abstract class AutoCompleteTextInterface {
  void onTappedSuggestion(String suggestion);
}
