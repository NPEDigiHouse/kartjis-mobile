import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/cores/helpers/app_size.dart';
import 'package:kartjis_mobile_app/cores/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/cores/utils/banner_utils.dart';
import 'package:kartjis_mobile_app/cores/utils/keys.dart';
import 'package:kartjis_mobile_app/cores/utils/routes.dart';
import 'package:kartjis_mobile_app/cores/utils/utilities.dart';
import 'package:kartjis_mobile_app/features/auth/src/presentation/components/_components.dart';

class OTPPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  final String phoneNumber;

  OTPPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final maxWidth = AppSize.getAppWidth(context);
    final fieldSize = (maxWidth / 4) - 40;

    return WillPopScope(
      onWillPop: () async {
        await Utilities.popPage(
          context: context,
          withDelay: true,
        );

        return false;
      },
      child: Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: AppSize.getAppHeight(context),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SafeArea(
                  child: AuthAppBar(
                    delayWhenBackButtonPressed: true,
                  ),
                ),
                const SizedBox(height: 64),
                Center(
                  child: SvgPicture.asset(
                    AssetPath.getVector('phone_otp.svg'),
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  'Masukkan\nKode OTP!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kode OTP telah terkirim ke nomor xxx${phoneNumber.substring(phoneNumber.length - 4)} melalui pesan. Masukkan kode tersebut untuk melanjutkan.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.5,
                        color: secondaryTextColor,
                      ),
                ),
                const SizedBox(height: 24),
                FormBuilder(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List<SizedBox>.generate(4, (index) {
                        return SizedBox(
                          width: fieldSize,
                          height: fieldSize,
                          child: FormBuilderTextField(
                            name: '$index',
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFEDEFF1),
                              contentPadding: const EdgeInsets.only(left: 2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            textInputAction: index != 3
                                ? TextInputAction.next
                                : TextInputAction.done,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                ),
                            onChanged: (value) {
                              if (value?.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => submitOTPCode(context),
                      icon: const Icon(Icons.chevron_right_rounded),
                      iconSize: 40,
                      color: scaffoldBackgroundColor,
                      tooltip: 'Submit',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitOTPCode(BuildContext context) {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    final data = _formKey.currentState!.value;

    final isValid = data.values.every((e) {
      if (e is! String) return false;

      return e.isNotEmpty;
    });

    if (isValid) {
      // hide material banner
      scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();

      // navigate to reset password page
      navigatorKey.currentState!.pushReplacementNamed(resetPasswordRoute);
    } else {
      final errorBanner = BannerUtils.createMaterialBanner(
        contentText: 'Kode OTP yang dimasukkan tidak valid!',
        foregroundColor: scaffoldBackgroundColor,
        backgroundColor: errorColor,
        leadingIcon: Icons.cancel_outlined,
      );

      // show material banner
      scaffoldMessengerKey.currentState!
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(errorBanner);
    }
  }
}
