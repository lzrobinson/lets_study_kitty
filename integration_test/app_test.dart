import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lets_study_kitti/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:uuid/uuid.dart';

final signInButtonFinder = find.text(' Login/Sign Up');
final signUpButtonFinder = find.text("don't have an account? Sign Up");

final emailInputFinder = find.descendant(
    of: find.byKey(Key('emailInput')),
    matching: find.byType(FormBuilderTextField));
final passwordInputFinder = find.descendant(
    of: find.byKey(Key('passwordInput')),
    matching: find.byType(FormBuilderTextField));
final nameInputFinder = find.descendant(
    of: find.byKey(Key('nameInput')),
    matching: find.byType(FormBuilderTextField));
final majorInputFinder = find.descendant(
    of: find.byKey(Key('majorInput')),
    matching: find.byType(FormBuilderTextField));
final passwordCInputFinder = find.descendant(
    of: find.byKey(Key('passwordCInput')),
    matching: find.byType(FormBuilderTextField));

final logInButtonFinder = find.text("LOG IN");
final createAccountButtonFinder = find.text("CREATE ACCOUNT");
/*
class AuthCreds {
  final String email;
  final String password;

  AuthCreds(this.email, this.password);

  static AuthCreds generate() {
    return AuthCreds('${Uuid().v1()}@example.com', "thisisapassword");
  }
}*/

extension WidgetTesterExtension on WidgetTester {
  /*
  Future enterAuthCreds(AuthCreds creds) async {
    await tap(emailInputFinder);
    await pumpAndSettle();
    await enterText(emailInputFinder, creds.email);
    await pumpAndSettle();

    await tap(passwordInputFinder);
    await pumpAndSettle();
    await enterText(passwordInputFinder, creds.password);
    await pumpAndSettle();
  }

  Future register(AuthCreds creds) async {
    await enterAuthCreds(creds);
    await tap(signUpButtonFinder);
    await pumpAndSettle();
    await pump(Duration(seconds: 5));
    await pump(Duration(seconds: 5));
    await pump(Duration(seconds: 5));
  }

  Future signIn(AuthCreds creds) async {
    await enterAuthCreds(creds);

    await tap(signInButtonFinder);
    await pumpAndSettle();
    await pump(Duration(seconds: 5));
    await pump(Duration(seconds: 5));
    await pump(Duration(seconds: 5));
  }

  Future startApp() async {
    app.main();
    await pumpAndSettle();
  }*/

  Future signOut() async {
    await tap(find.text(" Sign Out"));
    await pumpAndSettle();
  }

  Future goToProfileScreen() async {
    await tap(find.byKey(ValueKey("profileButton")));

    await pumpAndSettle();
  }

  Future goToAddReviewScreen() async {
    await tap(find.byKey(ValueKey("addReviewButton")));
    await pumpAndSettle();
  }

  Future logIn({required String email, required String password}) async {
    await tap(signInButtonFinder);
    await pumpAndSettle();
    await pump(Duration(seconds: 5));
    await pump(Duration(seconds: 5));
    await pump(Duration(seconds: 5));

    await tap(emailInputFinder);
    await pumpAndSettle();
    await enterText(emailInputFinder, email);
    await pumpAndSettle();

    await tap(passwordInputFinder);
    await pumpAndSettle();
    await enterText(passwordInputFinder, password);
    await pumpAndSettle();

    await tap(logInButtonFinder);
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  final email = '${Uuid().v1()}@example.com';
  final password = 'thisisapassword';

  final verifiedEmail = 'senturner@gmail.com';
  final verifiedPassword = 'demons';

  testWidgets(
    'Starter page display correctly',
    (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      await Future.delayed(Duration(seconds: 10));
      //expect(tester.firstElement(signInButtonFinder), isNotNull);
      expect(tester.firstElement(find.byKey(ValueKey("profileButton"))),
          isNotNull);
      expect(tester.firstElement(find.byKey(ValueKey("addReviewButton"))),
          isNotNull);
    },
  );

  testWidgets(
    'Can navigate out of the starter page',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 10));

      await tester.tap(signInButtonFinder);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'Can register user',
    (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5));

      await tester.tap(signInButtonFinder);
      await tester.pumpAndSettle();

      await tester.tap(signUpButtonFinder);
      await tester.pumpAndSettle();

      await tester.tap(emailInputFinder);
      await tester.pumpAndSettle();
      await tester.enterText(emailInputFinder, email);
      await tester.pumpAndSettle();

      await tester.tap(passwordInputFinder);
      await tester.pumpAndSettle();
      await tester.enterText(passwordInputFinder, password);
      await tester.pumpAndSettle();

      await tester.tap(passwordCInputFinder);
      await tester.pumpAndSettle();
      await tester.enterText(passwordInputFinder, password);
      await tester.pumpAndSettle();

      await tester.tap(nameInputFinder);
      await tester.pumpAndSettle();
      await tester.enterText(passwordInputFinder, 'firstname lastname');
      await tester.pumpAndSettle();

      await tester.tap(majorInputFinder);
      await tester.pumpAndSettle();
      await tester.enterText(passwordInputFinder, 'major');
      await tester.pumpAndSettle();

      await tester.tap(createAccountButtonFinder);
      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));
      await tester.signOut();
    },
  );

  testWidgets(
    'Can login and log out user',
    (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5));
      await tester.tap(signInButtonFinder);
      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));

      await tester.tap(emailInputFinder);
      await tester.pumpAndSettle();
      await tester.enterText(emailInputFinder, verifiedEmail);
      await tester.pumpAndSettle();

      await tester.tap(passwordInputFinder);
      await tester.pumpAndSettle();
      await tester.enterText(passwordInputFinder, verifiedPassword);
      await tester.pumpAndSettle();

      await tester.tap(logInButtonFinder);
      await tester.pump(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));

      await tester.goToProfileScreen();

      expect(tester.widget(find.text("Edit Profile")), isNotNull);

      await tester.signOut();
      await tester.pumpAndSettle();
    },
  );

  testWidgets('Can add a review', (tester) async {
    app.main();

    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 5));

    await tester.logIn(email: verifiedEmail, password: verifiedPassword);

    await Future.delayed(Duration(seconds: 5));

    await tester.goToAddReviewScreen();

    await tester.signOut();
  });

  testWidgets('Can view profile', (tester) async {
    app.main();

    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 5));

    await tester.logIn(email: verifiedEmail, password: verifiedPassword);

    await Future.delayed(Duration(seconds: 5));

    await tester.goToProfileScreen();

    await tester.signOut();
  });
}
