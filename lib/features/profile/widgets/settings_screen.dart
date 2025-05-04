import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/profile_cubit.dart';
import '../../../ui/core/themes/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State variables for settings
  bool _notificationsEnabled = true;
  bool _profilePubliclyVisible = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.kcolorTheme.primary,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          // Preferences section
          _buildSectionHeader('Preferences'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Enable push notifications'),
                  value: _notificationsEnabled,
                  activeColor: AppTheme.kcolorTheme.primary,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                Divider(height: 1, indent: 16, endIndent: 16, color: Colors.grey.withOpacity(0.2)),
                SwitchListTile(
                  title: const Text('Publicly Visible'),
                  subtitle: const Text('Show your profile to everyone'),
                  value: _profilePubliclyVisible,
                  activeColor: AppTheme.kcolorTheme.primary,
                  onChanged: (value) {
                    setState(() {
                      _profilePubliclyVisible = value;
                    });
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Account section
          _buildSectionHeader('Account'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade300,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Log Out', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showDeleteAccountDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade300,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Delete Account', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          
          // Version info at the bottom
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppTheme.kcolorTheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().logout().then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully')),
                  );
                  Navigator.pop(context); // Return to previous screen after logout
                });
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().deleteAccount().then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account deleted')),
                  );
                  Navigator.pop(context); // Return to previous screen after account deletion
                });
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
} 