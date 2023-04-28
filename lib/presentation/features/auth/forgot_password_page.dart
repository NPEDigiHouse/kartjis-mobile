import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/common/helpers/app_size.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/utils/banner_utils.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';
import 'package:kartjis_mobile_app/common/utils/routes.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/widgets/auth_app_bar.dart';
import 'package:kartjis_mobile_app/presentation/widgets/custom_field.dart';
import 'package:kartjis_mobile_app/presentation/widgets/loading_indicator.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: AppSize.getAppHeight(context),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AuthAppBar(),
                const SizedBox(height: 64),
                Center(
                  child: SvgPicture.asset(
                    AssetPath.getVector('forgot_password.svg'),
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  'Lupa\nPassword?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Masukkan No. HP yang telah terdaftar dan Kami akan mengirimkan konfirmasi untuk me-reset password Anda.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.5,
                        color: secondaryTextColor,
                      ),
                ),
                const SizedBox(height: 24),
                FormBuilder(
                  key: _formKey,
                  autoFocusOnValidationFailure: true,
                  child: CustomField(
                    name: 'phone_number',
                    label: 'No. HP',
                    hintText: '08xxxxx',
                    hasPrefixIcon: false,
                    hasSuffixIcon: false,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Bagian ini harus diisi',
                      ),
                      FormBuilderValidators.minLength(
                        8,
                        errorText: 'No. HP minimal 8 digit',
                      ),
                      FormBuilderValidators.integer(
                        errorText: 'No. HP tidak valid',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 44,
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => sendOTPCode(context),
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Transform.rotate(
                        angle: -45 * math.pi / 180,
                        child: const Icon(
                          Icons.send_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                    label: const Text('Kirim Kode OTP'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendOTPCode(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final phoneNumber =
          _formKey.currentState!.value['phone_number'] as String;

      // show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      // proccess...
      await Future.delayed(const Duration(seconds: 3));

      // close loading indicator
      navigatorKey.currentState!.pop();

      // navigate to otp page if success
      navigatorKey.currentState!.pushNamed(
        otpRoute,
        arguments: phoneNumber,
      );

      final successBanner = BannerUtils.createMaterialBanner(
        contentText:
            'Kode OTP telah terkirim ke nomor xxxxx${phoneNumber.substring(phoneNumber.length - 3)}',
        foregroundColor: scaffoldBackgroundColor,
        backgroundColor: successColor,
        leadingIcon: Icons.check_circle_outlined,
      );

      // show material banner
      scaffoldMessengerKey.currentState!
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(successBanner);
    }
  }
}
