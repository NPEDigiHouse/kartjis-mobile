import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/widgets/custom_clip_path.dart';
import 'package:kartjis_mobile_app/presentation/widgets/custom_field.dart';
import 'package:kartjis_mobile_app/presentation/widgets/password_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
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
                          primaryColor.withOpacity(.5),
                          primaryColor.withOpacity(.8),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: scaffoldBackgroundColor.withOpacity(.15),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () => navigatorKey.currentState!.pop(),
                            icon: const Icon(Icons.chevron_left_rounded),
                            iconSize: 32,
                            color: scaffoldBackgroundColor,
                            tooltip: 'Back',
                          ),
                        ),
                        const SizedBox(height: 56),
                        SvgPicture.asset(
                          AssetPath.getIcon('kartjis_filled.svg'),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Buat Akun',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                        ),
                        const SizedBox(height: 2),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodySmall,
                            children: const <TextSpan>[
                              TextSpan(
                                text:
                                    'Daftarkan akun Anda, lalu jelajahi berbagai event & konser menarik di ',
                                style: TextStyle(
                                  height: 1.5,
                                  color: secondaryTextColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Kartjis.',
                                style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _formKey,
                    autoFocusOnValidationFailure: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        CustomField(
                          name: 'name',
                          label: 'Nama',
                          hintText: 'Masukkan nama Anda',
                          hasPrefixIcon: false,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                            FormBuilderValidators.maxLength(
                              100,
                              errorText: 'Nama maksimal 100 karakter',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomField(
                          name: 'email',
                          label: 'Email',
                          hintText: 'Masukkan email Anda',
                          hasPrefixIcon: false,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
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
                          hintText: 'Masukkan password Anda',
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
                                  'Password minimal 8 karakter dan mengandung angka dan huruf',
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              passwordNotifier.value = value;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          name: 'confirm_password',
                          label: 'Konfirmasi Password',
                          hintText: 'Ulangi password di atas',
                          hasPrefixIcon: false,
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                            FormBuilderValidators.equal(
                              passwordNotifier.value,
                              errorText:
                                  'Harus sama dengan password sebelumnya',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomField(
                          name: 'date_of_birth',
                          label: 'Tanggal Lahir',
                          hintText: 'dd/mm/yyyy',
                          hasPrefixIcon: false,
                          textInputAction: TextInputAction.next,
                          validators: [
                            FormBuilderValidators.required(
                              errorText: 'Bagian ini harus diisi',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
