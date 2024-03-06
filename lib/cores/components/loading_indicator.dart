import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final bool withScaffold;

  const LoadingIndicator({
    Key? key,
    this.size = 50.0,
    this.withScaffold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: _buildLoadingIndicator(),
          )
        : _buildLoadingIndicator();
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: SpinKitFoldingCube(
        size: size,
        duration: const Duration(milliseconds: 2000),
        itemBuilder: (context, index) {
          final colors = <Color>[
            Palette.primaryColor,
            Palette.primaryColor.withOpacity(.9),
            Palette.primaryColor.withOpacity(.8),
           Palette. primaryColor.withOpacity(.7),
          ];

          return DecoratedBox(
            decoration: BoxDecoration(
              color: colors[index % colors.length],
            ),
          );
        },
      ),
    );
  }
}
