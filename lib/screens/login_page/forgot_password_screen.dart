import 'package:dms_dealers/base/base_state.dart';
import 'package:dms_dealers/screens/login_page/login_bloc.dart';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/extensions/constants.dart';
import 'login_event.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgot-password';

  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode(); // Added FocusNode
  late final LoginBloc _loginBloc;

  bool get validate => _formKey.currentState?.validate() ?? false;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();

    // Automatically focus the email input field when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose(); // Dispose of FocusNode
    _loginBloc.close(); // Close the bloc to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: BlocProvider(
        create: (_) => _loginBloc,
        child: BlocListener<LoginBloc, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.successResponse ?? 'Success')),
              );
            } else if (state is FailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.errorMessage}')),
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey, // Added Form for validation
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode, // Attach FocusNode
                        decoration: InputDecoration(
                          labelText: StringConstants.emailTitle,
                          hintText: StringConstants.emailHint,
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderSide:  BorderSide(color: ColorResource.primaryColor,style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          // Basic email regex validation
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorResource.primaryColor,

                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: InkWell(
                          onTap: _sendPasswordResetLink,
                          borderRadius: BorderRadius.circular(8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Text(
                                'Send Password Reset Link',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendPasswordResetLink() {
    if (validate) {
      _loginBloc.add(ForgotPasswordRequested(_emailController.text.trim()));
    }
  }
}
