import 'dart:async';

import 'package:flutter/material.dart';

class Debonce {
  Timer? timer;

  void run(VoidCallback fn) {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(const Duration(milliseconds: 500), fn);
  }
}
