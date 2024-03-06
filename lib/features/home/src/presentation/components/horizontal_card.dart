import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/features/event/src/data/concert.dart';

class HorizontalCard extends StatelessWidget {
  final Concert concert;

  const HorizontalCard({super.key, required this.concert});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                concert.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      concert.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      maxLines: 1,
                      text: TextSpan(
                        style:  TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Palette.secondaryColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${concert.price.split(" ")[0]}\t',
                            style: const TextStyle(fontSize: 10),
                          ),
                          TextSpan(
                            text: concert.price.split(' ')[1],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Organized by',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Palette.tertiaryColor,
                            letterSpacing: 0,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Image.asset(
                      concert.organizerLogoPath,
                      height: 20,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            DateFormat('d MMM y').format(concert.date),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Palette.secondaryTextColor),
                          ),
                        ),
                        const SizedBox(width: 8),
                         CircleAvatar(
                          backgroundColor: Palette.secondaryTextColor,
                          radius: 2.5,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            concert.place,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Palette.secondaryTextColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
