import 'package:disaoled_people/features/auth/screens/complate_chirty_info_screen.dart';
import 'package:disaoled_people/features/auth/screens/complate_pation_info_screen.dart';
import 'package:disaoled_people/features/auth/screens/create_benefactor_account_screen.dart';
import 'package:disaoled_people/features/auth/screens/create_chirity_account_screen.dart';
import 'package:disaoled_people/features/auth/screens/create_pationt_account_screen.dart';
import 'package:disaoled_people/features/auth/screens/login_screen.dart';
import 'package:disaoled_people/features/auth/screens/selecte_account_type_screen.dart';
import 'package:disaoled_people/features/auth/screens/sms_verfication_screen.dart';
import 'package:disaoled_people/features/auth/screens/verfication_complated_screen.dart';
import 'package:disaoled_people/features/charity/screens/charities_screen.dart';
import 'package:disaoled_people/features/chat/messages_screen.dart';
import 'package:disaoled_people/features/game/screens/example_screen.dart';
import 'package:disaoled_people/features/game/screens/game_levels_screen.dart';
import 'package:disaoled_people/features/game/screens/level_screen.dart';
import 'package:disaoled_people/features/game/screens/quize_screen.dart';
import 'package:disaoled_people/features/game/screens/score_screen.dart';
import 'package:disaoled_people/features/healthTips/screens/health_tips_screen.dart';
import 'package:disaoled_people/features/home/home_screen.dart';
import 'package:disaoled_people/features/orders/screens/add_order_screen.dart';
import 'package:disaoled_people/features/orders/screens/complete_add_order.dart';
import 'package:disaoled_people/features/orders/screens/complete_edit_order.dart';
import 'package:disaoled_people/features/orders/screens/edit_order_screen.dart';
import 'package:disaoled_people/features/orders/screens/my_orders_screen.dart';
import 'package:disaoled_people/features/orders/screens/orders_screen.dart';
import 'package:disaoled_people/features/profile/screens/charity_profile_screen.dart';
import 'package:disaoled_people/features/profile/screens/edit_benfactor_profile.dart';
import 'package:disaoled_people/features/profile/screens/edit_charity_profile.dart';
import 'package:disaoled_people/features/profile/screens/edit_patient_profile.dart';
import 'package:disaoled_people/features/profile/screens/patient_profile_screen.dart';
import 'package:disaoled_people/features/profile/screens/person_profile_screen.dart';
import 'package:disaoled_people/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case SelectAccountTypeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SelectAccountTypeScreen());
    case CreateBenefactorAccountScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CreateBenefactorAccountScreen());
    case CreatePationtAccountScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CreatePationtAccountScreen());
    case CreateChirityAccountScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CreateChirityAccountScreen());
    case ComplateChirtyInfoScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ComplateChirtyInfoScreen(), settings: settings);
    case ComplatePationInfoScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ComplatePationInfoScreen(), settings: settings);
    case SmsVerficationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SmsVerficationScreen(), settings: settings);
    case VerficationComplateScreen.routeName:
      return MaterialPageRoute(builder: (_) => const VerficationComplateScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case PersonProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const PersonProfileScreen());
    case CharityProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CharityProfileScreen(), settings: settings);
    case CharitiesScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CharitiesScreen());
    case InstructionScreen.routeName:
      return MaterialPageRoute(builder: (_) => const InstructionScreen());
    case MessagesScreen.routeName:
      return MaterialPageRoute(builder: (_) => const MessagesScreen());
    case OrdersScreen.routeName:
      return MaterialPageRoute(builder: (_) => const OrdersScreen());
    case MyOrdersScreen.routeName:
      return MaterialPageRoute(builder: (_) => const MyOrdersScreen());
    case AddOrderScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddOrderScreen());
    case CompleteAddOrder.routeName:
      return MaterialPageRoute(builder: (_) => const CompleteAddOrder(), settings: settings);

    case EditOrderScreen.routeName:
      return MaterialPageRoute(builder: (_) => const EditOrderScreen(), settings: settings);
    case CompleteEditOrderScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CompleteEditOrderScreen(), settings: settings);

    case GameLevelsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const GameLevelsScreen(), settings: settings);
    case LevelScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LevelScreen(), settings: settings);
    case ExampleScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ExampleScreen(), settings: settings);
    case QuizScreen.routeName:
      return MaterialPageRoute(builder: (_) => const QuizScreen(), settings: settings);
    case ScoreScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ScoreScreen(), settings: settings);

    case EditChirityProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const EditChirityProfileScreen(), settings: settings);
    case EditBenefactorProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const EditBenefactorProfileScreen(), settings: settings);
    case PatientProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const PatientProfileScreen(), settings: settings);

    case EditPatientProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const EditPatientProfileScreen(), settings: settings);
  }

  return null;
}
