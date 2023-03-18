// ignore_for_file: file_names
part of '../header.dart';

class TextStyling {
  styleText1() => const TextStyle(color: Colors.grey);
  styleText2(double size) => TextStyle(color: defWhite, fontWeight: FontWeight.bold, fontSize: size);
  styleText3(double size) => TextStyle(color: defWhite, fontSize: size);
  styleText4(double size) => TextStyle(color: Colors.black, fontSize: size);
  styleText5(double size, Color color) => TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size);
  styleText6(double size, Color color) => TextStyle(color: color, fontSize: size);

  //McLaren
  mcLarenBold(double size, Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: size,
        fontFamily: "Mclaren",
      );
  mcLarenDef(double size, Color color) => TextStyle(
        color: color,
        fontSize: size,
        fontFamily: "Mclaren",
      );

  //Nunito
  nunitoBold(double size, Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: size,
        fontFamily: "Nunito",
      );
  nunitonDef(double size, Color color) => TextStyle(
        color: color,
        fontSize: size,
        fontFamily: "Nunito",
      );
}
