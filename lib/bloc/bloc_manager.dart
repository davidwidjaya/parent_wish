import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/bloc/task_bloc/task_bloc.dart';

class BlocManager {
  // Declare all the blocs here
  static final authBloc = AuthBloc();
  static final taskBloc = TaskBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<TaskBloc>(
      create: (context) => taskBloc,
    ),
    // Add more BlocProviders as needed
  ];

  static final BlocManager _instance = BlocManager._internal();

  factory BlocManager() {
    return _instance;
  }

  BlocManager._internal();

  static void dispose() {
    authBloc.close();
    taskBloc.close();
    // Close other blocs if needed
  }
}
