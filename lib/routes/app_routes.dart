import 'package:flutter/material.dart';

import '../screens/about_us_screen.dart';
import '../screens/additional_details_get.dart';
import '../screens/admin_appliction_list.dart';
import '../screens/admin_company_details_get.dart';
import '../screens/admin_company_list.dart';
import '../screens/admin_home_screen.dart';
import '../screens/admin_is_placed_student_list.dart';
import '../screens/admin_student_list.dart';
import '../screens/auth_screen.dart';
import '../screens/bottom_navigation_bar_screen.dart';
import '../screens/company_result_list_screen.dart';
import '../screens/education_info_get_screen.dart';
import '../screens/contact_us_screen.dart';
import '../screens/home_screen.dart';
import '../screens/job_description_screen.dart';
import '../screens/message_screen.dart';
import '../screens/personal_info_get.dart';
import '../screens/private_policy_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/student_result.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String authScreen = '/auth_screen';
  static const String homeScreen = '/home_screen';
  static const String settingScreen = '/setting_screen';
  static const String chatScreen = '/chat_screen';
  static const String personalInfoGetterScreen = '/personal_info_getter_screen';
  static const String educationGetterScreen = '/education_info_getter_screen';
  static const String additionalDetailsGetterScreen =
      '/additional_details_getter_screen';
  static const String bottomNavigationBarScreen =
      '/bottom_navigation_bar_screen';
  static const String jobDescriptionScreen = '/job_description_screen';
  static const String adminHomeScreen = '/admin_home_screen';
  static const String adminCompanyDetailsGetter =
      '/admin_company_details_getter';
  static const String adminStudentsList = '/admin_students_list';
  static const String adminCompaniesList = '/admin_companies_list';
  static const String profileScreen = '/profile_screen';
  static const String studentsApplicationListScreen =
      '/students_application_list_screen';
  static const String adminIsPlacedStudentsList =
      '/admin_is_placed_students_list';
  static const String aboutUsScreen = '/about_us_screen';
  static const String privacyPolicyScreen = '/privacy_policy_screen';
  static const String followUsScreen = '/follow_us_screen';
  static const String resultOfCompanyList = '/result_of_company_list';
  static const String selectedStudentsList = '/selected_students_list';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    authScreen: (context) => const AuthScreen(),
    homeScreen: (context) => const HomeScreen(),
    settingScreen: (context) => const SettingScreen(),
    personalInfoGetterScreen: (context) => const PersonalInfoGetter(),
    educationGetterScreen: (context) => const EducationGetterScreen(),
    additionalDetailsGetterScreen: (context) => const AdditionalDetailsGetter(),
    chatScreen: (context) => const ChatScreen(),
    bottomNavigationBarScreen: (context) => const BottomNavigationBarScreen(),
    jobDescriptionScreen: (context) => const JobDescriptionScreen(),
    adminHomeScreen: (context) => const AdminHomeScreen(),
    adminCompanyDetailsGetter: (context) => const AdminCompanyDetailsGetter(),
    adminStudentsList: (context) => const AdminStudentsList(),
    adminCompaniesList: (context) => const AdminCompanyList(),
    profileScreen: (context) => const ProfileScreen(),
    studentsApplicationListScreen: (context) =>
        const AdminStudentsApplicationListScreen(),
    adminIsPlacedStudentsList: (context) => const AdminIsPlacedStudentsList(),
    aboutUsScreen: (context) => const AboutUsScreen(),
    privacyPolicyScreen: (context) => const PrivacyPolicyScreen(),
    followUsScreen: (context) => const FollowUsScreen(),
    resultOfCompanyList: (context) => const ResultOfCompanyList(),
    selectedStudentsList: (context) => const SelectedStudentsList(),
  };
}
