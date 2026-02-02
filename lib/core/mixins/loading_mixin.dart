import 'package:flutter/material.dart';

/// Mixin for loading state management in StatefulWidget
mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    if (mounted) {
      setState(() {
        _isLoading = value;
      });
    }
  }

  Future<void> withLoading(Future<void> Function() action) async {
    setLoading(true);
    try {
      await action();
    } finally {
      setLoading(false);
    }
  }
}
