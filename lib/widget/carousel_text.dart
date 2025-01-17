import 'package:agrolyn_web/widget/typography.dart';
import 'package:flutter/material.dart';

RichText slide1Text = RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'Solusi', style: carouselBlueTextStyle),
      TextSpan(text: ' Pertanian ', style: carouselWhiteTextStyle),
      TextSpan(text: 'Cerdas', style: carouselBlueTextStyle)
    ],
  ),
  textAlign: TextAlign.center,
);

RichText slide2Text = RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'Agrolyn', style: carouselWhiteTextStyle),
      TextSpan(text: ' Web apps', style: carouselBlueTextStyle),
    ],
  ),
  textAlign: TextAlign.center,
);

// RichText slide3Text = RichText(
//   text: const TextSpan(
//     children: <TextSpan>[
//       TextSpan(text: 'Create', style: carouselBlueTextStyle),
//       TextSpan(text: ' faster ', style: carouselWhiteTextStyle),
//       TextSpan(text: 'apps', style: carouselBlueTextStyle)
//     ],
//   ),
//   textAlign: TextAlign.center,
// );

// RichText slide4Text = RichText(
//   text: const TextSpan(
//     children: <TextSpan>[
//       TextSpan(text: 'Target', style: carouselBlueTextStyle),
//       TextSpan(text: ' mobile, web, & desktop ', style: carouselWhiteTextStyle),
//       TextSpan(text: 'apps', style: carouselBlueTextStyle)
//     ],
//     style: TextStyle(height: 1.1),
//   ),
//   textAlign: TextAlign.center,
// );
