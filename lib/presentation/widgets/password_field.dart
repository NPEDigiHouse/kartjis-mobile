import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';

class PasswordField extends StatefulWidget {
  final String name;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final IconData? prefixIcon;
  final List<String? Function(String?)>? validators;

  const PasswordField({
    super.key,
    required this.name,
    this.textInputType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.hintText,
    this.prefixIcon,
    this.validators,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late final ValueNotifier<bool> isFocus;
  late final ValueNotifier<bool> isVisible;

  @override
  void initState() {
    super.initState();

    isFocus = ValueNotifier(false);
    isVisible = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();

    isFocus.dispose();
    isVisible.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.name,
          style: Theme.of(context).textTheme.labelLarge!,
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (value) => isFocus.value = value,
          child: ValueListenableBuilder(
            valueListenable: isVisible,
            builder: (context, isVisible, child) {
              return FormBuilderTextField(
                name: widget.name.toLowerCase(),
                keyboardType: widget.textInputType,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                textAlignVertical: TextAlignVertical.center,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 18,
                      end: 12,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: isFocus,
                      builder: (context, isFocus, child) {
                        return CircleAvatar(
                          radius: 19,
                          backgroundColor:
                              isFocus ? tertiaryColor : dividerColor,
                          child: Icon(
                            widget.prefixIcon,
                            color: isFocus ? backgroundColor : onDisableColor,
                            size: 18,
                          ),
                        );
                      },
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 4,
                    ),
                    child: IconButton(
                      icon: isVisible
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                      iconSize: 16,
                      onPressed: () => this.isVisible.value = !isVisible,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: tertiaryColor,
                    ),
                  ),
                ),
                validator: widget.validators != null
                    ? FormBuilderValidators.compose(widget.validators!)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
