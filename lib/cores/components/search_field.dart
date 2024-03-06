import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/cores/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';

class SearchField extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;

  const SearchField({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController controller;
  late final ValueNotifier<bool> isFocus;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    isFocus = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    isFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) => isFocus.value = value,
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          onChanged: widget.onChanged,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: Palette.primaryColor,
              ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: 'Cari event',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: Palette.secondaryTextColor,
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:  BorderSide(
                color: Palette.dividerColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:  BorderSide(
                color: Palette.primaryColor,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 10,
              ),
              child: ValueListenableBuilder(
                valueListenable: isFocus,
                builder: (context, isFocus, child) {
                  return SvgPicture.asset(
                    AssetPath.getIcon('search_outlined.svg'),
                    width: 20,
                    color: isFocus ? Palette.primaryColor : Palette.secondaryTextColor,
                  );
                },
              ),
            ),
            suffixIcon: widget.text.isEmpty
                ? const SizedBox()
                : IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 16,
                    ),
                    onPressed: () {
                      controller.clear();
                      widget.onChanged('');
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
