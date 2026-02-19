import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus/core/utils/token_storage.dart';
import 'package:noviindus/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';

/* DATA SOURCE */
import 'data/datasource/auth_remote_ds.dart';
import 'data/datasource/home_remote_ds.dart';
import 'data/datasource/feed_remote_ds.dart';

/* REPOSITORIES */
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/home_repository_impl.dart';
import 'data/repositories/feed_repository_impl.dart';

/* USECASES */
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/get_home_usecase.dart';
import 'domain/usecases/upload_feed_usecase.dart';
import 'domain/usecases/my_feed_usecase.dart';

/* PROVIDERS */
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/providers/upload_provider.dart';
import 'presentation/providers/my_feed_provider.dart';
import 'presentation/providers/video_manager_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// CORE
    final apiClient = ApiClient();

    /// DATA SOURCES
    final authDS = AuthRemoteDS(apiClient);
    final homeDS = HomeRemoteDS(apiClient);
    final feedDS = FeedRemoteDS(apiClient);

    /// REPOSITORIES
    final authRepo = AuthRepositoryImpl(authDS);
    final homeRepo = HomeRepositoryImpl(homeDS);
    final feedRepo = FeedRepositoryImpl(feedDS);

    /// USECASES
    final loginUseCase = LoginUseCase(authRepo);
    final homeUseCase = GetHomeUseCase(homeRepo);
    final uploadUseCase = UploadFeedUseCase(feedRepo);
    final myFeedUseCase = MyFeedUseCase(feedRepo);
    final tokenStorage = TokenStorage();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(loginUseCase, tokenStorage),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider(homeUseCase)),
        ChangeNotifierProvider(create: (_) => UploadProvider(uploadUseCase)),
        ChangeNotifierProvider(create: (_) => MyFeedProvider(myFeedUseCase)),
        ChangeNotifierProvider(create: (_) => VideoManagerProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 898),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          title: 'Noviindus',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          home: LoginScreen(),
        ),
      ),
    );
  }
}
