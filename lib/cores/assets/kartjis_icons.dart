part of core;

class KartjisIcons {
  KartjisIcons._();

  static const String _root = 'assets';

  // icon
  static const String _icon = '$_root/icon';

  static const String home = '$_icon/home.svg';
  static const String profile = '$_icon/user.svg';
  static const String search = '$_icon/search.svg';
  static const String ticket = '$_icon/ticket.svg';
  static const String kartjis = '$_icon/kartjis_filled.svg';
  static const String device = '$_icon/device_mobile.svg';
  static const String chat = '$_icon/chat.svg';
  static const String star = '$_icon/star.svg';
}

class KartjisAssets {
  static Widget get logo => SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              KartjisIcons.kartjis,
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'KARTJIS',
              style: TextStyle(
                fontFamily: 'Titillium Web',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 1,
                color: Palette.primaryColor,
              ),
            )
          ],
        ),
      );
}
