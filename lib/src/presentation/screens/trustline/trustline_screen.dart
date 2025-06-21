import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'trustline/trustline_bloc.dart';

class TrustlineScreen extends StatelessWidget {
  final _assetCodeController = TextEditingController();
  final _issuerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Trustline')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _assetCodeController,
              decoration: InputDecoration(labelText: 'REAL8)'),
            ),
            TextField(
              controller: _issuerController,
              decoration: InputDecoration(labelText: 'GBVYYQ7XXRZW6ZCNNCL2X2THNPQ6IM4O47HAA25JTAG7Z3CXJCQ3W4CD'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TrustlineBloc>().add(AddTrustlineEvent(
                  assetCode: _assetCodeController.text,
                  issuer: _issuerController.text,
                ));
              },
              child: Text('Add Trustline'),
            ),
          ],
        ),
      ),
    );
  }
}