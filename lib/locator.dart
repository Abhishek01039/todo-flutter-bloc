import 'package:get_it/get_it.dart';
import 'package:todolist/services/todoService.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton(() => TodoServices());
}
