import 'package:flutter/material.dart';

import '../../../core/widgets/app_shell.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(appBar: null, child: _HelpSupportBody());
  }
}

class _HelpSupportBody extends StatelessWidget {
  const _HelpSupportBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        BackButton(),
        SizedBox(height: 12),
        Text(
          'Help & Support',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 18),
        Card(
          child: ListTile(
            title: Text('Live chat'),
            subtitle: Text('Typical response time: 2 minutes'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Call support'),
            subtitle: Text('+880 1234 567890'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('FAQ'),
            subtitle: Text('Delivery, payments, order changes, and refunds'),
          ),
        ),
      ],
    );
  }
}
