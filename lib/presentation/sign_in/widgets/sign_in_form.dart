import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        builder: (ctx, state) {
          return Form(
              child: ListView(
            children: [
              Text(
                "📝",
                style: TextStyle(
                  fontSize: 100,
                ),
              )
            ],
          ));
        },
        listener: (ctx, state) {});
  }
}
