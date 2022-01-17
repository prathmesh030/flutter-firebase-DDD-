import 'package:notes_app/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError({required this.valueFailure});
  @override
  String toString() {
    String explanation =
        "Encountered a ValueFailure at an unrecoverable point. Terminating.";

    return Error.safeToString("$explanation Failure was: $valueFailure");
  }
}
