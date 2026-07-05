// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../Theme/themeclass.dart';

class PinCodeWidget extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  final double? size;
  final bool autoFocus;
  final Function(String) onChangeOTP;

  const PinCodeWidget({
    super.key,
    required this.controller,
    this.length = 5,
    this.size,
    this.autoFocus = true,
    required this.onChangeOTP,
  });

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> with CodeAutoFill {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    listenForCode(smsCodeRegexPattern: '\\d{${widget.length}}');
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusNode.requestFocus();
        }
      });
    }
  }

  @override
  void codeUpdated() {
    final receivedCode = code;
    if (receivedCode == null || receivedCode.isEmpty) {
      return;
    }
    _onOtpChanged(receivedCode);
  }

  @override
  void dispose() {
    cancel();
    unregisterListener();
    _focusNode.dispose();
    super.dispose();
  }

  void _onOtpChanged(String value) {
    if (widget.controller.text != value) {
      widget.controller.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
    widget.onChangeOTP(value);
    if (value.length == widget.length) {
      TextInput.finishAutofillContext(shouldSave: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: SizedBox(
        width: widget.size ?? 375.w,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IgnorePointer(
                child: PinCodeTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  appContext: context,
                  length: widget.length,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  cursorColor: ThemeClass.blackColor,
                  enablePinAutofill: false,
                  useExternalAutoFillGroup: true,
                  readOnly: true,
                  autoFocus: false,
                  textInputAction: TextInputAction.done,
                  validator: (String? v) {
                    if (v == null || v.isEmpty || v.length != widget.length) {
                      return "";
                    }
                    return null;
                  },
                  pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(10.w),
                    borderWidth: 1,
                    errorBorderColor: Colors.red,
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 56.h,
                    fieldWidth: 66.w,
                    activeFillColor: Colors.transparent,
                    activeColor: ThemeClass.hintColor,
                    inactiveColor: ThemeClass.textFieldBackgroundColor,
                    selectedColor: ThemeClass.secondaryColor,
                    inactiveFillColor: ThemeClass.whiteColor,
                    selectedFillColor: const Color(0xFFF9F9F9),
                  ),
                  hintCharacter: " ",
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  autoDisposeControllers: false,
                  controller: widget.controller,
                  onChanged: _onOtpChanged,
                  keyboardType: TextInputType.number,
                  beforeTextPaste: (text) => true,
                ),
              ),
              Positioned.fill(
                child: TextField(
                  focusNode: _focusNode,
                  controller: widget.controller,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  enableSuggestions: true,
                  autocorrect: false,
                  showCursor: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  style: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 1,
                    height: 1,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                  ),
                  onChanged: _onOtpChanged,
                  onSubmitted: (_) {
                    TextInput.finishAutofillContext(shouldSave: false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
