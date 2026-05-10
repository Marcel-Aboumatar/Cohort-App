import 'package:flutter/material.dart';
import 'backend_service.dart';

Future<void> showSchoolLoginFlow(
  BuildContext context,
) async {
  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final codeController =
      TextEditingController();

  String email = '';
  String password = '';

  // STEP 1
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('School Login'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter your school login to import your schedule.',
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'School Email',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),

          FilledButton(
            onPressed: () async {
              email =
                  emailController.text.trim();

              password =
                  passwordController.text;

              await BackendService
                  .sendSchoolLoginCode(
                email: email,
                password: password,
              );

              Navigator.pop(context);
            },
            child: const Text('Continue'),
          ),
        ],
      );
    },
  );

  // BACKEND CALL TO SEND CODE HERE
  const code = '67';

  // STEP 2
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title:
            const Text('Verification Code'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PLEASE ENTER THE VERIFICATION CODE BELOW INTO YOUR PHONE.',
            ),
            SizedBox(height: 16),
            Text(
              code,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),

          FilledButton(
            onPressed: () async {
              await BackendService
                  .importScheduleWithLogin(
                email: email,
                password: password,
                code: codeController.text
                    .trim(),
              );

              Navigator.pop(context);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Schedule imported!',
                  ),
                ),
              );
            },
            child: const Text('Verify'),
          ),
        ],
      );
    },
  );
}