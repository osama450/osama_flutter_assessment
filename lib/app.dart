import 'package:shop_plus/config/themes/app_theme.dart';
import 'package:shop_plus/config/themes/app_theme_dark.dart';
import 'package:shop_plus/core/utils/app_strings.dart';
import 'package:shop_plus/core/utils/multi_bloc_manager.dart';
import 'package:shop_plus/features/shared/cubit/shared_cubit.dart';
import 'package:shop_plus/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_wrapper/responsive_wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    return MultiBlocProvider(
      providers: MultiBlocManager.multiBlocProviderList,
      child: MultiBlocListener(
        listeners: MultiBlocManager.multiBlocListenersList,
        child: BlocBuilder<SharedCubit, SharedState>(
          builder: (context, state) {
            final cubit = context.read<SharedCubit>();
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              title: AppStrings.appName,
              locale: Locale(cubit.currentLangCode),
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme(lang: cubit.currentLangCode),
              darkTheme: AppThemeDark.theme(lang: cubit.currentLangCode),
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) {
                return ResponsiveWrapper(
                  useShortestSide: false,
                  builder: (context, screenInfo) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.noScaling),
                    child: child!,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
