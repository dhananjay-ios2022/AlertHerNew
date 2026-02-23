import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/subscription_view_model.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_view_model.dart';

final userProvider = [
  ChangeNotifierProvider<AuthViewModel>(create: (context) => AuthViewModel(context)),
  ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel(context)),
  ChangeNotifierProvider<SubscriptionProvider>(create: (context) => SubscriptionProvider()),

];
