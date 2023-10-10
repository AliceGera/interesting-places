import 'package:interesting_places/data/di/injector.dart';
import 'package:interesting_places/domain/di/injector.dart';
import 'package:interesting_places/presentation/di/injector.dart';

Future<void> configureInjector() async {
  await configureDataDependencies();
  await configureDomainDependencies();
  await configurePresentationDependencies();
}
