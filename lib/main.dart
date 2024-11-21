import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/cart_bloc.dart';
import 'package:shopping_app/blocs/order_bloc.dart';
import 'package:shopping_app/blocs/product_bloc.dart';
import 'screens/product_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()..add(FetchProducts())),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => OrderBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Shopping App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ProductListScreen(),
      ),
    );
  }
}
