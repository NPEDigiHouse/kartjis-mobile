import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';

class CustomField extends StatefulWidget {
  final String name;
  final String label;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final bool hasPrefixIcon;
  final IconData? prefixIcon;
  final List<String? Function(String?)>? validators;

  const CustomField({
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
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late final ValueNotifier<bool> isFocus;

  @override
  void initState() {
    super.initState();

    isFocus = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();

    isFocus.dispose();
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
            child: _buildCustomTextField(),
          )
        else
          _buildCustomTextField()
      ],
    );
  }

  FormBuilderTextField _buildCustomTextField() {
    return FormBuilderTextField(
      name: widget.name,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: TextAlignVertical.center,
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
                      backgroundColor: isFocus ? tertiaryColor : dividerColor,
                      child: Icon(
                        widget.prefixIcon,
                        color: isFocus ? backgroundColor : onDisableColor,
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
            icon: const Icon(Icons.visibility_outlined),
            iconSize: 16,
            onPressed: () {},
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
  }
}
