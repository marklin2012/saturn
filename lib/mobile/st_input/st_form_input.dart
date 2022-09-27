import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saturn/mobile/st_button/common.dart';

const double _spcae = 12.0;
const double _defaultIconSize = 16.0;

class STFormInput extends StatefulWidget {
  const STFormInput({
    Key? key,
    this.height = 48.0,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.backgroundColor,
    this.enabled = true,
    this.inputType,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.controller,
    this.focusNode,
    this.textStyle,
    this.contentPadding,
    this.placeholder,
    this.holderStyle,
    this.obscure,
    this.autofocus = false,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.showVisibility = false,
    this.suffixIcon,
  }) : super(key: key);

  const STFormInput.password({
    Key? key,
    this.height = 48.0,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.backgroundColor,
    this.enabled,
    this.inputType,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.controller,
    this.focusNode,
    this.textStyle,
    this.contentPadding,
    this.placeholder = "请输入密码",
    this.holderStyle,
    this.obscure = true,
    this.autofocus = false,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.showVisibility = true,
    this.suffixIcon,
  }) : super(key: key);

  final double height;
  final EdgeInsetsGeometry padding;
  final Decoration? decoration;
  final Color? backgroundColor;
  final bool? enabled;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final double? cursorWidth;
  final double? cursorHeight;
  final double? cursorRadius;
  final Color? cursorColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final String? placeholder;
  final TextStyle? holderStyle;
  final bool? obscure;
  final bool autofocus;
  final void Function(String?)? onSaved;
  final String Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool showVisibility;
  final Widget? suffixIcon;

  @override
  _STFormInputState createState() => _STFormInputState();
}

class _STFormInputState extends State<STFormInput> {
  TextEditingController? _inputController;
  late bool _obscureText;
  FocusNode? _focusNode;
  TextInputType? _inputType;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _inputController = widget.controller ?? TextEditingController();
    _inputType = widget.inputType ?? TextInputType.text;
    _obscureText = widget.obscure ?? false;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding,
      alignment: Alignment.centerLeft,
      decoration: widget.decoration ??
          BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
          ),
      child: TextFormField(
        enabled: widget.enabled,
        keyboardType: _inputType,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        keyboardAppearance: Theme.of(context).brightness,
        cursorWidth: widget.cursorWidth ?? 2.0,
        cursorHeight: widget.cursorHeight ?? widget.height - 2 * _spcae,
        cursorRadius: Radius.circular(widget.cursorRadius ?? 0),
        cursorColor: widget.cursorColor ?? STColor.firRankBlue,
        controller: _inputController,
        focusNode: _focusNode,
        style: widget.textStyle ?? const TextStyle(),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding:
              widget.contentPadding ?? const EdgeInsets.only(bottom: _spcae),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintMaxLines: 1,
          hintText: widget.placeholder ?? '',
          hintStyle: widget.holderStyle ??
              const TextStyle(
                color: STColor.fourRankFont,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_focusNode!.hasFocus &&
                  (_text.isNotEmpty || _inputController!.text.isNotEmpty))
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
                      _inputController!.clear();
                      _text = "";
                    });
                  },
                ),
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
              if (widget.suffixIcon != null) widget.suffixIcon!,
            ],
          ),
        ),
        obscureText: _obscureText,
        autofocus: widget.autofocus,
        onSaved: (String? value) {
          if (widget.onSaved != null) {
            widget.onSaved!(value);
          }
        },
        validator: (String? value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
        onChanged: (v) {
          setState(() {
            _text = v;
          });
          if (widget.onChanged != null) widget.onChanged!(v);
        },
        onFieldSubmitted: (v) {
          if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(v);
        },
      ),
    );
  }
}
