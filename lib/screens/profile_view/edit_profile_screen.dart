import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../login_page/forgot_password_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/profile_page";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: "SiteAdmin");
  final TextEditingController _emailController = TextEditingController(text: "SiteAdmin@Orienseam");
  final TextEditingController _passwordController = TextEditingController();
  // Used for Segmented Control value
  int? _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
              enabled: false, // Disable editing
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              enabled: false, // Disable editing
            ),
            const SizedBox(height: 16),
            // TextFormField(
            //   controller: _passwordController,
            //   decoration: const InputDecoration(
            //     labelText: "Password",
            //   ),
            //   obscureText: true,
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).push("/forgot-password");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ForgotPasswordPage(),
                  ),
                );
              },
              child: const Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }

  Container profileTextField(String label) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade50),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          label: Text(label),
        ),
      ),
    );
  }

  Widget buildSegment(String text) => Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ));
}
