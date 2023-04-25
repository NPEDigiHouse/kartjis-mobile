import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';

class CustomField extends StatefulWidget {
  final String name;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final IconData? prefixIcon;
  final List<String? Function(String?)>? validators;

  const CustomField({
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
          widget.name,
          style: Theme.of(context).textTheme.labelLarge!,
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (value) => isFocus.value = value,
          child: FormBuilderTextField(
            name: widget.name.toLowerCase(),
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            textAlignVertical: TextAlignVertical.center,
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
                      backgroundColor: isFocus ? tertiaryColor : dividerColor,
                      child: Icon(
                        widget.prefixIcon,
                        color: isFocus ? backgroundColor : onDisableColor,
                        size: 18,
                      ),
                    );
                  },
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
          ),
        ),
      ],
    );
  }
}
