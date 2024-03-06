import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/cores/components/_components.dart';
import 'package:kartjis_mobile_app/cores/components/brutalism_button.dart';
import 'package:kartjis_mobile_app/cores/core.dart';
import 'package:kartjis_mobile_app/cores/helpers/app_size.dart';
import 'package:kartjis_mobile_app/cores/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/cores/utils/banner_utils.dart';
import 'package:kartjis_mobile_app/cores/utils/keys.dart';
import 'package:kartjis_mobile_app/cores/utils/routes.dart';
import 'package:kartjis_mobile_app/features/auth/src/presentation/components/_components.dart';
import 'package:kartjis_mobile_app/features/auth/src/presentation/components/password_field.dart';
import 'package:kartjis_mobile_app/features/users/src/data/user.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: AppSize.getAppHeight(context),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const _LoginHeader(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          CustomField(
                            name: 'email',
                            label: 'Email',
                            hintText: 'johndoe@mail.com',
                            textInputType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_rounded,
                            hasSuffixIcon: false,
                            validators: [
                              FormBuilderValidators.required(
                                errorText: 'Bagian ini harus diisi',
                              ),
                              FormBuilderValidators.email(
                                errorText: 'Email tidak valid',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          PasswordField(
                            name: 'password',
                            label: 'Password',
                            hintText: 'password',
                            textInputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock_rounded,
                            validators: [
                              FormBuilderValidators.required(
                                errorText: 'Bagian ini harus diisi',
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              // hide material banner
                              scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();

                              // navigate to forgot password page
                              navigatorKey.currentState!.pushNamed(forgotPasswordRoute);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    color: Palette.primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BrutalismButton(
                        title: 'Log In',
                        onTap: () => login(context),
                        primaryColor: Colors.black,
                        layerColor: Palette.scaffoldBackgroundColor,
                        layerSpace: 4),
                    const SizedBox(height: 14),
                    const Text('OR'),
                    const SizedBox(height: 14),
                    BrutalismButton(
                      title: 'Continue with Google',
                      onTap: () => () {},
                      primaryColor: Palette.scaffoldBackgroundColor,
                      textColor: Palette.primaryTextColor,
                      layerColor: Palette.primaryColor,
                      leading: SvgPicture.asset(KartjisIcons.google),
                      layerSpace: 4,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account? Register\t',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            // hide material banner
                            scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();

                            // navigate to register page
                            navigatorKey.currentState!.pushNamed(registerRoute);
                          },
                          child: Text(
                            'here.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Palette.primaryColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      if (data['email'] != user.email || data['password'] != user.password) {
        final errorBanner = BannerUtils.createMaterialBanner(
          contentText: 'Email atau Password salah!',
          foregroundColor: Palette.scaffoldBackgroundColor,
          backgroundColor: Palette.errorColor,
          leadingIcon: Icons.cancel_outlined,
        );

        // show material banner
        scaffoldMessengerKey.currentState!
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(errorBanner);
      } else {
        // hide material banner
        scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();

        // navigate to main page
        navigatorKey.currentState!.pushReplacementNamed(mainRoute);
      }
    }
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            height: 255,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetPath.getImage('concert_bg.png'),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            height: 255,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Palette.primaryColor.withOpacity(.5),
                  Palette.primaryColor.withOpacity(.8),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  AssetPath.getIcon('kartjis_filled.svg'),
                ),
                const SizedBox(height: 24),
                Text(
                  'KARTJIS',
                  style: TextStyle(
                    fontFamily: 'Titillium Web',
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    height: 1,
                    color: Palette.primaryColor,
                  ),
                ),
                Text(
                  '\tLogin to start your event journey!',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
