import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';


///Snack Bar Default
void snackBarDefault({
  required BuildContext context,
  String? message,
  bool? isLoading = false,
  required SnackBarSeverity severity,
}) async {
  FlutterSnackBar.showTemplated(
    context,
    title: severity.getLabel(),
    message: message,
    leading: Icon(
      severity.getIcon(),
      size: 32,
      color: severity.getColorIcon(),
    ),
    style: FlutterSnackBarStyle(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      radius: BorderRadius.circular(6),

      backgroundColor: severity.getColor(context),
      shadow: BoxShadow(
        color: Colors.black.withOpacity(0.55),
        blurRadius: 32,
        offset: const Offset(0, 12),
        blurStyle: BlurStyle.normal,
        spreadRadius: -10,
      ),
      leadingSpace: 22,
      trailingSpace: 12,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      titleStyle: const TextStyle(fontSize: 20, color: Colors.white),
      messageStyle:
      TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
      titleAlignment: TextAlign.start,
      messageAlignment: TextAlign.start,
      loadingBarColor: Colors.yellow,
      loadingBarRailColor: Colors.yellow.withOpacity(0.4),
      contentCrossAxisAlignment: CrossAxisAlignment.center,
    ),
    configuration: FlutterSnackBarConfiguration(
      location: FlutterSnackBarLocation.bottom,
      distance: 35,
      animationCurve: Curves.ease,
      animationDuration: const Duration(milliseconds: 500),
      showDuration: const Duration(seconds: 2),
      persistent: false,
      dismissible: true,
      dismissDirection: DismissDirection.none,
      showLoadingBar: isLoading,
    ),
  );
}

///Enum to set the severity of the Info bar default 2
enum SnackBarSeverity {
  ///Error severity
  error,

  ///Warning severity
  warning,

  ///Success severity
  success;

  ///Method to get the severity color
  Color getColor(BuildContext context) {


    return switch (this) {
      error => Colors.red,
      warning => Colors.orange.shade400,
      success => Colors.green,
    };
  }

  ///Method to get the severity color
  Color getColorIcon() {
    return switch (this) {
      error => Colors.red,
      warning => Colors.white,
      success => Colors.white,
    };
  }

  ///Method to get the severity label
  String getLabel() {
    return switch (this) {
      error => 'Erro',
      warning => 'Aviso',
      success => 'Sucesso',
    };
  }

  ///Method to get the severity label
  IconData getIcon() {
    return switch (this) {
      error => Icons.error_rounded,
      warning => Icons.warning_rounded,
      success => Icons.check_circle_rounded,
    };
  }
}