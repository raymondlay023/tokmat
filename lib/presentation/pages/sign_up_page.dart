import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';

import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../domain/entities/user_entity.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/credential_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final credentialState = context.watch<CredentialCubit>().state;
      if (credentialState is CredentialSuccess) {
        context.read<AuthCubit>().loggedIn();
      } else if (credentialState is CredentialFailure) {
        toast("Invalid email and password!");
      }
      return _bodyWidget(credentialState);
    });
  }

  Widget _bodyWidget(CredentialState credentialState) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Image.asset(
                'assets/tokmat-logo.png',
                height: 180,
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftar',
                    style: headerTextStyle,
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Nama',
                    hintText: 'Masukkan nama Anda disini',
                  ),
                  const SizedBox(height: 35),
                  CustomTextFormField(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Masukkan username Anda disini',
                  ),
                  const SizedBox(height: 35),
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Masukkan email Anda disini',
                  ),
                  const SizedBox(height: 35),
                  CustomTextFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Masukkan password Anda disini',
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 42),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Sudah punya akun?'),
                      Builder(
                        builder: (context) => TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, PageConst.signInPage),
                          child: const Text('Masuk disini'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _signUpUser(),
                  child: credentialState is CredentialLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).indicatorColor,
                          ),
                        )
                      : const Text('Daftar'),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void _signUpUser() {
    context.read<CredentialCubit>().signUp(UserEntity(
          name: _nameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ));
  }
}
