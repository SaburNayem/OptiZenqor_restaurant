import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:optizenqor_restaurant/features/auth/controller/auth_controller.dart';
import 'package:optizenqor_restaurant/features/auth/screen/login_screen.dart';

void main() {
  testWidgets('renders login screen', (WidgetTester tester) async {
    Get.put(AuthController());
    await tester.pumpWidget(const GetMaterialApp(home: LoginScreen()));

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
