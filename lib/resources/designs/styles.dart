import 'package:flutter/material.dart';
import 'package:air_senderos/resources/designs/colors.dart';

final ButtonStyle mainFlatButtonStyle = TextButton.styleFrom(
  // ignore: deprecated_member_use
  primary: Colors.white,
  foregroundColor: Colors.white,
  backgroundColor: colorGreen,
  minimumSize: const Size(200, 50),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

final ButtonStyle secondaryFlatButtonStyle = TextButton.styleFrom(
  // ignore: deprecated_member_use
  primary: Colors.white,
  foregroundColor: Colors.white,
  backgroundColor: colorGray,
  minimumSize: const Size(200, 50),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  // ignore: deprecated_member_use
  onPrimary: Colors.black87,
  // ignore: deprecated_member_use
  primary: Colors.grey[300],
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

const TextStyle mainText = TextStyle(
  color: colorGreen,
);

const TextStyle mainBoldText = TextStyle(
  color: colorGreen,
  fontWeight: FontWeight.bold,
);

const TextStyle titleText = TextStyle(
  color: colorGreen,
  fontSize: 40,
  fontWeight: FontWeight.bold,
);

const TextStyle subtitleText = TextStyle(
  color: colorGray,
  fontSize: 20,
  fontWeight: FontWeight.w100,
);
