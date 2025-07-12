import 'package:parent_wish/data/repositories/auth_repository.dart';
import 'package:parent_wish/data/repositories/task_repository.dart';

class RepositoryManager {
  static final authRepository = AuthRepository();
  static final taskRepository = TaskRepository();
}
