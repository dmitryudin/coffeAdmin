import 'package:flutter/material.dart';

import 'package:coffe_admin/utils/constance.dart';

ThemeData basicTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: kPrimaryColor,
      
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
        )
      ),
     
      textTheme: const TextTheme(
        bodyText2: TextStyle(
          fontFamily: 'PTSansNarrow',
          fontSize: 16,
          color: Colors.white,
        ),
        //Освоено
        bodyText1: TextStyle(
          fontFamily: FontNameDefault,
          fontSize: BodyTextSize,
          color: Colors.green,
        ),
      ),



      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),

      accentColor: Colors.white,
      buttonTheme: ButtonThemeData(
        height: 80,
        buttonColor: Colors.white,
        textTheme: ButtonTextTheme.accent,
      ),

      // bottomAppBarColor: Colors.deepPurple,
      // cardColor: Colors.orange.shade100,
      // scaffoldBackgroundColor: Colors.yellow,
    );
