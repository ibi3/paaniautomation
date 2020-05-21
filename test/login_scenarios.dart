import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import "package:paani/screens/login/login.dart";

void main() {
  testWidgets("testing login", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));
    var email = find.byKey(ValueKey("loginemail"));
    expect(email, findsOneWidget);
    var password = find.byKey(ValueKey("loginpassword"));
    await tester.enterText(email, "ahmed@email.com");
    await tester.enterText(password, "abcdef123");
    await tester.tap(find.byKey(ValueKey("login")));
    await tester.pump();
    expect(find.text("Incorrect email or password"), findsNothing);
  });
}
