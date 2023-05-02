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
import 'package:kartjis_mobile_app/presentation/widgets/loading_indicator.dart';
import 'package:kartjis_mobile_app/presentation/widgets/password_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final ValueNotifier<String> passwordNotifier;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    passwordNotifier = ValueNotifier('');
  }

  @override
  void dispose() {
    super.dispose();

    passwordNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: AppSize.getAppHeight(context),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SafeArea(
                child: AuthAppBar(),
              ),
              const SizedBox(height: 64),
              Center(
                child: SvgPicture.asset(
                  AssetPath.getVector('reset_password.svg'),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'Reset\nPassword',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ingat baik-baik password baru Anda agar tidak terjadi hal yang sama!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      color: secondaryTextColor,
                    ),
              ),
              const SizedBox(height: 24),
              FormBuilder(
                key: _formKey,
                autoFocusOnValidationFailure: true,
                child: Column(
                  children: <Widget>[
                    PasswordField(
                      name: 'password',
                      label: 'Password Baru',
                      hintText: 'Masukkan password baru Anda',
                      hasPrefixIcon: false,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Bagian ini harus diisi',
                        ),
                        FormBuilderValidators.match(
                          r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                          errorText:
                              'Password min. 8 karakter dengan angka dan huruf',
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          passwordNotifier.value = value;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: passwordNotifier,
                      builder: (context, password, child) {
                        return PasswordField(
                          name: 'confirm_password',
                          label: 'Konfirmasi Password',
                          hintText: 'Ulangi password di atas',
                          hasPrefixIcon: false,
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                            FormBuilderValidators.equal(
                              password,
                              errorText:
                                  'Harus sama dengan password sebelumnya',
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => resetPassword(context),
                  icon: const Icon(
                    Icons.lock_rounded,
                    size: 20,
                  ),
                  label: const Text('Reset Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
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

      // navigate to login page if success
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        loginRoute,
        (route) => false,
      );

      final successBanner = BannerUtils.createMaterialBanner(
        contentText:
            'Password berhasil direset. Silahkan masuk menggunakan password baru Anda.',
        foregroundColor: scaffoldBackgroundColor,
        backgroundColor: successColor,
        leadingIcon: Icons.check_circle_outlined,
      );

      // show material banner at next page
      scaffoldMessengerKey.currentState!
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(successBanner);
    }
  }
}
