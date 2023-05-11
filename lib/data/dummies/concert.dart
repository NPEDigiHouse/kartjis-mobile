import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';

class Concert {
  final String title;
  final DateTime date;
  final String place;
  final String price;
  final String posterPath;
  final String organizerName;
  final String organizerLogoPath;

  Concert({
    required this.title,
    required this.date,
    required this.place,
    required this.price,
    required this.posterPath,
    required this.organizerName,
    required this.organizerLogoPath,
  });
}

final concerts = <Concert>[
  Concert(
    title: '2023 World Tour: BLACKPINK IN YOUR AREA',
    date: DateTime(2023, 6, 10),
    place: 'Gelora Bung Karno Stadium, Jakarta',
    price: 'Rp 750.000',
    posterPath: AssetPath.getImage('poster1.jpg'),
    organizerName: 'Ticket.com',
    organizerLogoPath: AssetPath.getImage('organizer_logo.png'),
  ),
  Concert(
    title: 'Justin Bieber World Tour 2023: GHOST',
    date: DateTime(2023, 7, 13),
    place: 'Mall Phinisi Point, Makassar',
    price: 'Rp 810.000',
    posterPath: AssetPath.getImage('poster2.jpg'),
    organizerName: 'Ticket.com',
    organizerLogoPath: AssetPath.getImage('organizer_logo.png'),
  ),
  Concert(
    title: 'COLDPLAY: MUSIC of the SPHERES',
    date: DateTime(2023, 12, 6),
    place: 'ICE BSD, Tangerang',
    price: 'Rp 1.500.000',
    posterPath: AssetPath.getImage('poster3.jpg'),
    organizerName: 'Ticket.com',
    organizerLogoPath: AssetPath.getImage('organizer_logo.png'),
  ),
  Concert(
    title: 'Konser Gajah: TULUS - Jakarta',
    date: DateTime(2023, 10, 2),
    place: 'Gelora Bung Karno Stadium, Jakarta',
    price: 'Rp 299.000',
    posterPath: AssetPath.getImage('poster4.jpg'),
    organizerName: 'Ticket.com',
    organizerLogoPath: AssetPath.getImage('organizer_logo.png'),
  ),
  Concert(
    title: 'RED VELVET: REDMARE',
    date: DateTime(2023, 10, 2),
    place: 'Mall Phinisi Point, Makassar',
    price: 'Rp 649.000',
    posterPath: AssetPath.getImage('poster5.jpg'),
    organizerName: 'Ticket.com',
    organizerLogoPath: AssetPath.getImage('organizer_logo.png'),
  ),
];
