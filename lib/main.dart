import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_wish/bloc/app_bloc_observer.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/bloc/bloc_manager.dart';
import 'package:parent_wish/utils/routers.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Bloc observer
  Bloc.observer = AppBlocObserver();

  runApp(const ParentWish());
}

class ParentWish extends StatefulWidget {
  const ParentWish({super.key});

  @override
  State<ParentWish> createState() => _ParentWishState();
}

class _ParentWishState extends State<ParentWish> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: BlocManager.blocProviders,
        child: MaterialApp(
          title: 'Parent Wish',
          theme: ThemeData(
            textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
            // primarySwatch: Colors.blue,
            // visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const Scaffold(
            body: Center(
              child: Text('Welcome to Parent Wish!'),
            ),
          ),
          onGenerateRoute: AppRouter.generateRoute,
        ));
  }

  @override
  void dispose() {
    BlocManager.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
