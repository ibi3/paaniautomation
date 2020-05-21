import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Open User Profile', () {
    final signupbutton = find.byValueKey('signupbutton');
    final signupname = find.byValueKey('signupname');
    final signupemail = find.byValueKey('signupemail');
    final signupcontact = find.byValueKey("signupcontact");
    final signupaddress = find.byValueKey("signupaddress");
    final signuppassword = find.byValueKey('signuppassword');
    final signupcpassword = find.byValueKey("signupcpassword");
    final customer = find.byValueKey("customer");
    final signup = find.byValueKey("signup");
    // final navigateToNextFinder = find.byValueKey('navigation_next');
    // final navigationToPreviousFinder = find.byValueKey('navigation_previous');
    // final textFieldFinder = find.byValueKey('textfield');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.screenshot();
      }
    });

    // test('starts at 0', () async {
    //   expect(await driver.getText(counterTextFinder), "0");
    // });

    test('openning login', () async {
      await driver.tap(signupbutton);
      await driver.tap(customer);
      expect(await driver.getText(find.byValueKey("signup page")),
          'Sign up - Customer');
    });
    test('text signup', () async {
      await driver.tap(signupname);
      await driver.enterText("ahmed1");
      await driver.waitFor(find.text("ahmed1"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(signupemail);
      await driver.enterText("ahmed1@email.com");
      await driver.waitFor(find.text("ahmed1@email.com"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(signupcontact);
      await driver.enterText("03314193222");
      await driver.waitFor(find.text("03314193222"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(signupaddress);
      await driver.enterText("211 -J Hydarabad");
      await driver.waitFor(find.text("211 -J Hydarabad"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(signuppassword);
      await driver.enterText("abcdefg123");
      await driver.waitFor(find.text("abcdefg123"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(signupcpassword);
      await driver.enterText("abcdefg123");
      await driver.waitFor(find.text("abcdefg123"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(signup);
    });
    test("customer signed up", () async {
      expect(await driver.getText(find.byValueKey("account created")),
          'Your account has been created!');
    });
  });
}
