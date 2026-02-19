import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus/core/theme/app_colours.dart';
import 'package:noviindus/core/theme/app_text_style.dart';
import 'package:noviindus/presentation/providers/auth_provider.dart';
import 'package:noviindus/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  String countryCode = "+91";
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty || phone.length < 10) {
      _showError("Enter valid phone number");
      return;
    }

    final authProvider = context.read<AuthProvider>();

    try {
      print("Logging in with phone: $countryCode$phone");
      await authProvider.login(phone);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.s,
          children: [
            SizedBox(height: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enter Your \nMobile Number', style: AppTextStyle.heading),

                SizedBox(height: 16),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Porta at id hac vitae. Et tortor at vehicula eulsmod mi viverra.',
                  style: AppTextStyle.body,
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: '+91',
                    items: ['+91', '+1', '+44', '+86']
                        .map(
                          (code) => DropdownMenuItem(
                            value: code,
                            child: Text(
                              code,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() => countryCode = v);
                      }
                    },
                    underline: SizedBox(),
                    dropdownColor: Colors.grey[900],
                    iconEnabledColor: Colors.white,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[600]!),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(child: SizedBox(height: 80)),

            ElevatedButton(
              onPressed: auth.loading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundSecondary,
                minimumSize: Size(0, 0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.textSecondary),
                  borderRadius: BorderRadius.circular(40),
                ),
                side: BorderSide(color: AppColors.textSecondary, width: 0.4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Continue", style: TextStyle(color: Colors.white)),

                  const SizedBox(width: 12),

                  // Circular red icon background
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.buttonPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 160.h),
          ],
        ),
      ),
    );
  }
}
