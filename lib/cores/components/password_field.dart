import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';

class PasswordField extends StatefulWidget {
  final String name;
  final String label;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final bool hasPrefixIcon;
  final IconData? prefixIcon;
  final List<String? Function(String?)>? validators;
  final ValueChanged<String?>? onChanged;

  const PasswordField({
    super.key,
    required this.name,
    required this.label,
    this.textInputType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.hintText,
    this.hasPrefixIcon = true,
    this.prefixIcon,
    this.validators,
    this.onChanged,
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
          widget.label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        if (widget.hasPrefixIcon)
          Focus(
            onFocusChange: (value) => isFocus.value = value,
            child: _buildPasswordTextField(),
          )
        else
          _buildPasswordTextField()
      ],
    );
  }

  ValueListenableBuilder<bool> _buildPasswordTextField() {
    return ValueListenableBuilder(
      valueListenable: isVisible,
      builder: (context, isVisible, child) {
        return FormBuilderTextField(
          name: widget.name,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          textAlignVertical: TextAlignVertical.center,
          obscureText: !isVisible,
          decoration: InputDecoration(
            contentPadding: !widget.hasPrefixIcon
                ? const EdgeInsets.fromLTRB(16, 12, 16, 12)
                : null,
            hintText: widget.hintText,
            prefixIcon: widget.hasPrefixIcon
                ? Padding(
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
                              isFocus ? Palette.tertiaryColor : Palette.dividerColor,
                          child: Icon(
                            widget.prefixIcon,
                            color: isFocus ? Palette.backgroundColor : Palette.onDisableColor,
                            size: 18,
                          ),
                        );
                      },
                    ),
                  )
                : null,
            suffixIcon: Padding(
              padding: EdgeInsetsDirectional.only(
                end: widget.hasPrefixIcon ? 4 : 0,
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
              borderSide:  BorderSide(
                color: Palette.tertiaryColor,
              ),
            ),
          ),
          validator: widget.validators != null
              ? FormBuilderValidators.compose(widget.validators!)
              : null,
          onChanged: widget.onChanged,
        );
      },
    );
  }
}
