import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hw4/bloc/authentication_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authBloc.logout();
            context.go('/login');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}