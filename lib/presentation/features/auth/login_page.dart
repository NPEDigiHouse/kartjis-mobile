import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/utils/banner_utils.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';
import 'package:kartjis_mobile_app/common/utils/routes.dart';
import 'package:kartjis_mobile_app/data/dummies.dart';
import 'package:kartjis_mobile_app/presentation/widgets/custom_field.dart';
import 'package:kartjis_mobile_app/presentation/widgets/password_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    height: 240,
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
                    height: 240,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          primaryColor.withOpacity(.5),
                          primaryColor.withOpacity(.8),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset(
                          AssetPath.getIcon('kartjis_filled.svg'),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'KARTJIS',
                          style: TextStyle(
                            fontFamily: 'Titillium Web',
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                            height: 1,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          '\tLogin untuk mulai mengeksplorasi Event!',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: secondaryTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _formKey,
                    autoFocusOnValidationFailure: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        CustomField(
                          name: 'Email',
                          hintText: 'Masukkan email Anda',
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_rounded,
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
                          name: 'Password',
                          hintText: 'Masukkan password kamu',
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
                          onTap: () {},
                          child: Text(
                            'Lupa Password?',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0,
                                      color: primaryColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => login(context),
                      child: const Text('Masuk'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text('Atau'),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            AssetPath.getIcon('google_filled.svg'),
                          ),
                          const SizedBox(width: 8),
                          const Text('Lanjutkan dengan Google'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Belum punya akun? Buat akun baru ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      GestureDetector(
                        onTap: () => navigatorKey.currentState!.pushNamed(
                          registerRoute,
                        ),
                        child: Text(
                          'di sini.',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
    );
  }

  void login(BuildContext context) {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;

      if (value['email'] != defaultEmail &&
          value['password'] != defaultPassword) {
        final errorBanner = BannerUtils.createMaterialBanner(
          contentText: 'Email atau Password salah!',
          foregroundColor: scaffoldBackgroundColor,
          backgroundColor: errorColor,
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
        navigatorKey.currentState!.pushReplacementNamed(homeRoute);
      }
    }
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.36);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
