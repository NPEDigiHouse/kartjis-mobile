import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/common/helpers/app_size.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/widgets/auth_app_bar.dart';

class OTPPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  final String phoneNumber;

  OTPPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
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
                'Kode OTP telah terkirim ke nomor xxxxx${phoneNumber.substring(phoneNumber.length - 3)} melalui pesan. Masukkan kode tersebut untuk melanjutkan.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      color: secondaryTextColor,
                    ),
              ),
              const SizedBox(height: 24),
              FormBuilder(
                key: _formKey,
                autoFocusOnValidationFailure: true,
                child: FormBuilderTextField(
                  name: '0',
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
                    onPressed: () {},
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
    );
  }
}
