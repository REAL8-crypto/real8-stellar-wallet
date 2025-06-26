import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TrustlineScreen extends StatefulWidget {
  const TrustlineScreen({super.key});

  @override
  State<TrustlineScreen> createState() => _TrustlineScreenState();
}

class _TrustlineScreenState extends State<TrustlineScreen> {
  final _assetCodeController = TextEditingController();
  final _issuerController = TextEditingController();

  @override
  void dispose() {
    _assetCodeController.dispose();
    _issuerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trustline'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _assetCodeController,
              decoration: const InputDecoration(labelText: 'Asset Code'),
            ),
            TextField(
              controller: _issuerController,
              decoration: const InputDecoration(labelText: 'Issuer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add trustline logic here
                final assetCode = _assetCodeController.text;
                final issuer = _issuerController.text;
                
                // Clear fields after adding
                _assetCodeController.clear();
                _issuerController.clear();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added trustline for $assetCode')),
                );
              },
              child: const Text('Add Trustline'),
            ),
          ],
        ),
      ),
    );
  }
}