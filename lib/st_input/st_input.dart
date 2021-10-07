import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double _defaultIconSize = 16;
const double _defaultTextFiledHeight = 48;
const double _defaultSuffixWidth = 56;
const double _leftMargin = 12;
const double _rightMargin = 12;
const double _commonRadius = 8;
const double _defaultFontSize = 14;

const String _defaultPlaceholder = "";

// #FAFCFF
const Color _defaultBackgroundColor = Color(0xFFFAFCFF);
const Color _defaultBorderColor = Color(0xFFC4C5C7);
const Color _borderHighlightedColor = Color(0xFF095BF9);

class STInput extends StatefulWidget {
  const STInput({
    Key key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.maxLength,
    this.showVisibility = false,
    this.onChanged,
    this.placeholder,
    this.height,
    this.autofocus = false,
    this.scure,
    this.backgoundColor,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.contentPadding,
    this.enabled = true,
    this.placeholderStyle,
    this.onSubmitted,
    this.inputType,
    this.inputFormatters,
  }) : super(key: key);

  const STInput.password({
    Key key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.maxLength,
    this.showVisibility = true,
    this.onChanged,
    this.placeholder = "请输入密码",
    this.height,
    this.autofocus = false,
    this.scure = true,
    this.backgoundColor,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.contentPadding,
    this.enabled = true,
    this.placeholderStyle,
    this.onSubmitted,
    this.inputType,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final BoxDecoration decoration;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final bool showVisibility;
  final String placeholder;
  final TextStyle placeholderStyle;
  final double height;
  final bool autofocus;
  final bool scure;
  final Color backgoundColor;
  final TextStyle textStyle;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final bool enabled;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatters;

  @override
  _STInputState createState() => _STInputState();
}

class _STInputState extends State<STInput> {
  TextEditingController _inputController;
  bool _obscureText;
  String _text = "";
  String _hintText;
  double _height;
  FocusNode _focusNode;
  Color _borderColor;
  TextInputType _inputType;

  @override
  void initState() {
    super.initState();
    _inputController = widget.controller ?? TextEditingController();
    _inputType = widget.inputType ?? TextInputType.text;
    _hintText = widget.placeholder ?? _defaultPlaceholder;
    _height = widget.height ?? _defaultTextFiledHeight;
    _obscureText = widget.scure ?? false;
    _borderColor = _defaultBorderColor;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // 失去焦点
        setState(() {
          _borderColor = _defaultBorderColor;
        });
      } else {
        setState(() {
          _borderColor = _borderHighlightedColor;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: _height,
        padding: widget.padding ??
            const EdgeInsets.only(left: _leftMargin, right: _rightMargin),
        decoration: widget.decoration ??
            BoxDecoration(
              border: Border.all(color: _borderColor),
              color: widget.backgoundColor ?? _defaultBackgroundColor,
              borderRadius: BorderRadius.circular(_commonRadius),
            ),
        child: Center(
          child: TextField(
            enabled: widget.enabled,
            onSubmitted: (text) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted(text);
              }
            },
            keyboardType: _inputType,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            keyboardAppearance: Theme.of(context).brightness,
            cursorColor: Theme.of(context).primaryColor,
            controller: _inputController,
            focusNode: _focusNode,
            style: widget.textStyle ?? const TextStyle(),
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              // contentPadding: widget.contentPadding,
              prefixIcon: widget.prefixIcon,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (_focusNode.hasFocus &&
                      (_text.isNotEmpty || _inputController.text.isNotEmpty))
                    IconButton(
                        constraints: const BoxConstraints(),
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.cancel,
                          size: _defaultIconSize,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _inputController.clear();
                            _text = "";
                            if (widget.onChanged != null) {
                              widget.onChanged(_text);
                            }
                          });
                        }),
                  if (widget.showVisibility)
                    IconButton(
                      constraints: const BoxConstraints(),
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: _defaultIconSize,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  if (widget.suffixIcon != null) widget.suffixIcon,
                ],
              ),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintMaxLines: 1,
              hintText: _hintText,
              hintStyle: widget.placeholderStyle ??
                  const TextStyle(
                      color: Colors.grey, fontSize: _defaultFontSize),
            ),
            obscureText: _obscureText,
            autofocus: widget.autofocus,
            onChanged: (v) {
              setState(() {
                _text = v;
              });
              if (widget.onChanged != null) widget.onChanged(v);
            },
          ),
        ));
  }
}
