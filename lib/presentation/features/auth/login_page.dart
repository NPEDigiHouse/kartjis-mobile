import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final ValueNotifier<bool> isPasswordVisible;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    isPasswordVisible = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();

    isPasswordVisible.dispose();
  }

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
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset(
                          AssetPath.getIcon('kartjis_filled.svg'),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'KARTJIS',
                          style: GoogleFonts.titilliumWeb(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          '\tLogin untuk mulai mengeksplorasi Event!',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: secondaryTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'email',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Masukkan email kamu',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                            FormBuilderValidators.email(
                              errorText: 'Email tidak valid',
                            ),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder(
                          valueListenable: isPasswordVisible,
                          builder: (context, isVisible, child) {
                            return FormBuilderTextField(
                              name: 'password',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !isVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Masukkan password kamu',
                                prefixIcon:
                                    const Icon(Icons.lock_outline_rounded),
                                suffixIcon: IconButton(
                                  icon: isVisible
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                  onPressed: () =>
                                      isPasswordVisible.value = !isVisible,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Bagian ini harus diisi.',
                                ),
                              ]),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
