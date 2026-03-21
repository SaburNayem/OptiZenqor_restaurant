import 'package:get/get.dart';

import '../../features/auth/screen/forgot_password_screen.dart';
import '../../features/auth/screen/login_screen.dart';
import '../../features/auth/screen/onboarding_screen.dart';
import '../../features/auth/screen/otp_verification_screen.dart';
import '../../features/auth/screen/signup_screen.dart';
import '../../features/auth/screen/splash_screen.dart';
import '../../features/cart/screen/cart_screen.dart';
import '../../features/checkout/screen/checkout_screen.dart';
import '../../features/checkout/screen/order_success_screen.dart';
import '../../features/main_nav/screen/main_nav_screen.dart';
import '../../features/notifications/screen/notifications_screen.dart';
import '../../features/orders/screen/order_detail_screen.dart';
import '../../features/orders/screen/order_tracking_screen.dart';
import '../../features/orders/screen/review_screen.dart';
import '../../features/profile/screen/edit_profile_screen.dart';
import '../../features/profile/screen/help_support_screen.dart';
import '../../features/profile/screen/legal_screen.dart';
import '../../features/profile/screen/payment_methods_screen.dart';
import '../../features/profile/screen/saved_addresses_screen.dart';
import '../../features/restaurants/screen/restaurant_detail_screen.dart';
import '../../features/restaurants/screen/restaurant_list_screen.dart';
import '../../features/search/screen/search_screen.dart';
import '../../features/settings/screen/settings_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.splash, page: SplashScreen.new),
    GetPage(name: AppRoutes.onboarding, page: OnboardingScreen.new),
    GetPage(name: AppRoutes.login, page: LoginScreen.new),
    GetPage(name: AppRoutes.signup, page: SignupScreen.new),
    GetPage(name: AppRoutes.forgotPassword, page: ForgotPasswordScreen.new),
    GetPage(name: AppRoutes.otpVerification, page: OtpVerificationScreen.new),
    GetPage(name: AppRoutes.mainNav, page: MainNavScreen.new),
    GetPage(name: AppRoutes.search, page: SearchScreen.new),
    GetPage(name: AppRoutes.restaurantList, page: RestaurantListScreen.new),
    GetPage(name: AppRoutes.restaurantDetail, page: RestaurantDetailScreen.new),
    GetPage(name: AppRoutes.cart, page: CartScreen.new),
    GetPage(name: AppRoutes.checkout, page: CheckoutScreen.new),
    GetPage(name: AppRoutes.orderSuccess, page: OrderSuccessScreen.new),
    GetPage(name: AppRoutes.orderTracking, page: OrderTrackingScreen.new),
    GetPage(name: AppRoutes.orderDetail, page: OrderDetailScreen.new),
    GetPage(name: AppRoutes.notifications, page: NotificationsScreen.new),
    GetPage(name: AppRoutes.reviews, page: ReviewScreen.new),
    GetPage(name: AppRoutes.editProfile, page: EditProfileScreen.new),
    GetPage(name: AppRoutes.addresses, page: SavedAddressesScreen.new),
    GetPage(name: AppRoutes.paymentMethods, page: PaymentMethodsScreen.new),
    GetPage(name: AppRoutes.helpSupport, page: HelpSupportScreen.new),
    GetPage(name: AppRoutes.legal, page: LegalScreen.new),
    GetPage(name: AppRoutes.settings, page: SettingsScreen.new),
  ];
}
