import 'package:get_it/get_it.dart';
import 'package:zimbo/services/shared_service.dart';
import 'services/common_service.dart';
import 'services/network_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => CommonService());
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => SharedService());
}
