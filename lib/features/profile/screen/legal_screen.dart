import 'package:flutter/material.dart';

import '../../../core/widgets/app_shell.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Terms & Privacy')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text(
            'Terms of Service',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12),
          Text(
            'This demo frontend includes placeholder legal content intended for backend-ready app structure and navigation. Replace with your production policies before release.',
          ),
          SizedBox(height: 24),
          Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12),
          Text(
            'User data, addresses, payment method labels, and order history are mocked locally in this build and should be connected to your live API and compliance workflow later.',
          ),
        ],
      ),
    );
  }
}
