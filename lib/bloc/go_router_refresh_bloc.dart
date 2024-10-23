import 'package:flutter/material.dart';
import 'dart:async';

class GoRouterRefreshBloc extends ChangeNotifier {
  GoRouterRefreshBloc(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}