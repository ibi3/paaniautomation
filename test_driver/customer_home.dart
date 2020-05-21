import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
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
    test('drawer navigation and close', () async {
      final SerializableFinder locateDrawer =
          find.byTooltip('Open navigation menu');

      // Open the drawer
      await driver.tap(locateDrawer);
      await driver.tap(find.byValueKey('home'));
      expect(await driver.getText(find.byValueKey("customerhomescreen")),
          "Paani - Home");
    });
  });
}
