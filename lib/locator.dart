import 'package:get_it/get_it.dart';
import 'services/common_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => CommonService());
}
