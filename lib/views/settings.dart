import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:spendy/views/settings/privacy_policy.dart';
import 'package:spendy/views/settings/terms_of_use.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Минимальный размер по высоте
          children: [
            _buildSettingsButton(CupertinoIcons.star, "Rate this app",
                Colors.orange, _openAppStore),
            _buildSettingsButton(
                CupertinoIcons.share, "Share this app", Colors.blue, _shareApp),
            _buildSettingsButton(CupertinoIcons.lock_shield, "Privacy Policy",
                Colors.red, () => _openScreen(context, PrivacyPolicyScreen())),
            _buildSettingsButton(CupertinoIcons.doc_text, "Terms of Use",
                Colors.green, () => _openScreen(context, TermsOfUseScreen())),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(
      IconData icon, String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: double.infinity, // Растягиваем по ширине
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(icon, size: 28, color: color),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _openAppStore() async {
    final Uri url = Uri.parse(
        "https://apps.apple.com/app/id123456789"); // Замените на ваш ID
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Не удалось открыть $url';
    }
  }

  Future<void> _shareApp() async {
    const String appUrl = "https://apps.apple.com/app/id123456789";
    await Share.share("Try this app! $appUrl");
  }
}
