import 'package:flutter/material.dart';

const APP_TITLE = "Smart Cane";

const APP_ICON = "assets/imgs/app_icon.png";

const DEFAULT_PROFILE_PICTURE =
    "https://i.ibb.co/FgnFSQc/default-profile-picture.jpg";

// TODO : Define a text theme & App theme - light & dark

/* Fonts - 
  Hyperlinks - nunito
  large Text & Home page - DM sans
  Textfields & small hint text - mulish
  Titles, Buton - Cabin - w500, w600, Inter

*/

const COLOR_THEME = {
  'primary': Color.fromRGBO(65, 193, 186, 1),
  'secondary': Color.fromRGBO(200, 254, 251, 1),
  'tertiary': Color.fromRGBO(54, 91, 109, 1)
};

const DEFAULT_TEXT_THEME = TextTheme(
  bodyText1: TextStyle(
    fontFamily: 'mulish',
    fontSize: 18,
    color: Colors.white,
  ),
  headline1: TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 60,
  ),
  headline2: TextStyle(
    fontFamily: 'Cabin',
    fontSize: 60,
    fontWeight: FontWeight.w600,
  ),
  headline3: TextStyle(
    fontFamily: 'Cabin',
    fontSize: 60,
    fontWeight: FontWeight.w500,
  ),
  subtitle1: TextStyle(
    fontFamily: 'Cabin',
    fontSize: 20,
  ),
  subtitle2: TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 26,
  ),
  button: TextStyle(
    fontFamily: 'Cabin',
    fontSize: 20,
  ),
);
