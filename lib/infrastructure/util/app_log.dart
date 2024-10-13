import 'dart:developer';

import 'package:flutter/foundation.dart';

/// responsible for printing a personalized logo on the terminal
/// => EX: printTest('ÇÇ1', item.label)
void logInfo(String labelTest, Object? object) {
  if (kDebugMode) {
    log('-=-=-=-=-=-=-=-=-=-=-=-=-=-=(PrintTest)-=-=-=-=-=-=-=-=-=-=-=-=-=-=-'
        '\nidentification: $labelTest \n\n$object\n\n'
        '-=-=-=-=-=-=-=-=-=-=-=-=-=-=(PrintTest)'
        '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n');
  }
}