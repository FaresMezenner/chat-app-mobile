import 'package:chat_app/core/constants/theme/colors.dart';
import 'package:chat_app/shared/logic/cubit/auth_cubit.dart';
import 'package:chat_app/shared/logic/cubit/internet_cubit.dart';
import 'package:chat_app/features/socket_io/logic/cubit/socket_io_cubit.dart';
import 'package:chat_app/shared/logic/state/auth_state.dart';
import 'package:chat_app/shared/services/dio_helper.dart';
import 'package:chat_app/shared/services/routing.dart';
import 'package:chat_app/shared/widgets/error_popup.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => InternetCubit(
            connectivity: Connectivity(),
          ),
        ),
        BlocProvider(
          create: (context) => SocketIoCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: secondaryColor,
          ),
        ),
        home: Builder(builder: (context) {
          return MultiBlocListener(
            listeners: <BlocListener<dynamic, dynamic>>[
              BlocListener<AuthCubit, AuthState>(
                listener: (BuildContext context, AuthState state) {
                  print("is connected: ${state.connected}");
                  if (!state.connected) {
                    showDialog(
                      // barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        // return AlertDialog(
                        //   title: const Text('Disconnected'),
                        //   content: const Text(
                        //       'You got disconnected from your account, please login again.'),
                        //   actions: <Widget>[
                        //     TextButton(
                        //       onPressed: () => print("Disconnected"),
                        //       child: const Text('OK'),
                        //     ),
                        //   ],
                        // );
                        return ErrorPopup(
                          title: "Disconnected",
                          message:
                              'You got disconnected from your account, please login again.',
                          buttons: <TextButton>[
                            TextButton(
                              onPressed: () => print("Disconnected"),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              BlocListener<SocketIoCubit, SocketIoState>(
                listener: (BuildContext context, SocketIoState state) {
                  if (state is SocketIoDisconnected || state is SocketIoError) {
                    String message = state is SocketIoDisconnected
                        ? state.message
                        : state is SocketIoError
                            ? state.message
                            : "";
                    showDialog(
                      // barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        // return AlertDialog(
                        //   title: const Text('Disconnected'),
                        //   content: Text(message),
                        //   actions: <Widget>[
                        //     TextButton(
                        //       onPressed: () => print(message),
                        //       child: const Text('OK'),
                        //     ),
                        //   ],
                        // );
                        return ErrorPopup(
                          title: "Disconnected",
                          message: message,
                          buttons: <TextButton>[
                            TextButton(
                              onPressed: () => print(message),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
            child: MaterialApp(
              onGenerateRoute: AppRouter.onGenerateRoute,
              title: 'Chat app',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: primaryColor,
                  primary: primaryColor,
                  secondary: secondaryColor,
                ),
                useMaterial3: true,
              ),
            ),
          );
        }),
      ),
    );
  }
}
