import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';
import '../../core/utils.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/credential_cubit.dart';
import 'main_page.dart';
import '../../core/theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
        final authState = context.watch<AuthCubit>().state;
        authState is Authenticated ? MainPage(uid: authState.uid) : _bodyWidget;
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
                    'Masuk',
                    style: headerTextStyle,
                  ),
                  const SizedBox(height: 30),
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
                      const Text('Belum punya akun?'),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/sign-up'),
                        child: const Text('Daftar disini'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _signInUser(),
                  child: credentialState is CredentialLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).indicatorColor,
                          ),
                        )
                      : const Text('Masuk'),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void _signInUser() {
    context.read<CredentialCubit>().signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }
}
