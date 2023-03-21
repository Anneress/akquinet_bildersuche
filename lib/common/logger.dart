import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// Bereitstellen des Loggers über Riverpod Provider
final loggerProvider = Provider(
  (ref) => Logger(),
);
