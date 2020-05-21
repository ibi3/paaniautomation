@Timeout(const Duration(seconds: 50))
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
// import 'package:mockito/mockito.dart';

void main() {
  group('User Place Order', () {
    final loginbutton = find.byValueKey('loginbutton');
    final loginemail = find.byValueKey('loginemail');
    final loginpassword = find.byValueKey('loginpassword');
    final login = find.byValueKey("login");
    final drop = find.byValueKey('orderpackage');
    final orderinprogress =
        "Order Cannot be placed. \nAnother order is already in Progress!";
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
      await driver.tap(loginbutton);
    });
    test('text login', () async {
      await driver.tap(loginemail);
      await driver.enterText("ahmed@email.com");
      await driver.waitFor(find.text("ahmed@email.com"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(loginpassword);
      await driver.enterText("abcdefg123");
      await driver.waitFor(find.text("abcdefg123"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(login);
    });
    test("select company", () async {
      // await driver.waitFor(find.byValueKey(0));
      await driver.tap(find.byValueKey(0));
    });
    test("fill out user details", () async {
      await driver.tap(find.byValueKey("orderaddress"));
      await driver.enterText("203-L Nazimabad");
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(find.byValueKey("ordercontactnumber"));
      await driver.enterText("03112456723");
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(find.byValueKey("orderdatepicker"));
      await driver.tap(find.text("21"));
      await driver.tap(find.text("OK"));
      // await driver.enterText("203-L Nazimabad");
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(drop);
      await driver.tap(find.text('Package: 31'));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(find.byValueKey("orderplace"));
      await Future.delayed(Duration(seconds: 2));
    });
    test("order confirm", () async {
      // await driver.waitFor(find.byValueKey(0));
      await driver.tap(find.byValueKey("confirmorder"));
      expect(await driver.getText(find.byValueKey("orderinprogress")),
          orderinprogress);
    });
    // test('navigate to next page', () {
    //   driver.tap(navigateToNextFinder);
    // });

    // test('navigate to previous page', () async {
    //   await Future.delayed(Duration(seconds: 2));

    //   driver.tap(navigationToPreviousFinder);
    // });
  });
  group('Open User Profile', () {
    final loginbutton = find.byValueKey('loginbutton');
    final loginemail = find.byValueKey('loginemail');
    final loginpassword = find.byValueKey('loginpassword');
    final login = find.byValueKey("login");
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
      await driver.tap(loginbutton);
    });
    test('text login', () async {
      await driver.tap(loginemail);
      await driver.enterText("ahmed@email.com");
      await driver.waitFor(find.text("ahmed@email.com"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(loginpassword);
      await driver.enterText("abcdefg123");
      await driver.waitFor(find.text("abcdefg123"));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(login);
    });
    test('open drawer', () async {
      await driver.waitFor(find.byValueKey("drawer"));
    });
  });
}
