import 'package:injectable/injectable.dart';
import 'package:notes_app/injection.config.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.I;

@injectableInit
Future<void> configureInjection(String env) async {
  $initGetIt(getIt, environment: env);
}
