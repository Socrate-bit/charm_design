import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/profile_cubit.dart';
import '../../../data/repositories/user_repository.dart';
import 'profile_option_tile.dart';
import 'profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        userRepository: UserRepository(),
      )..loadProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.error != null) {
            return Scaffold(
              body: Center(child: Text('Error: ${state.error}')),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: Theme.of(context).colorScheme.surfaceBright,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeader(user: state.user),
                  const SizedBox(height: 24),
                  const Divider(),
                  ProfileOptionTile(
                    title: 'Edit Profile',
                    icon: Icons.edit,
                    onTap: () {
                      // Navigate to edit profile screen
                    },
                  ),
                  ProfileOptionTile(
                    title: 'Change Profile Picture',
                    icon: Icons.image,
                    onTap: () {
                      _showImagePickerSheet(context);
                    },
                  ),
                  ProfileOptionTile(
                    title: 'Notification Settings',
                    icon: Icons.notifications,
                    onTap: () {
                      // Navigate to notification settings
                    },
                  ),
                  ProfileOptionTile(
                    title: 'Privacy Settings',
                    icon: Icons.lock,
                    onTap: () {
                      // Navigate to privacy settings
                    },
                  ),
                  const Divider(),
                  ProfileOptionTile(
                    title: 'Logout',
                    icon: Icons.logout,
                    iconColor: Colors.orange,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                  ProfileOptionTile(
                    title: 'Delete Account',
                    icon: Icons.delete_forever,
                    iconColor: Colors.red,
                    onTap: () {
                      _showDeleteAccountDialog(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImagePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  // In a real app, this would open the camera
                  // For demo purposes, update with a placeholder
                  context.read<ProfileCubit>().updateProfilePicture(
                    'https://i.pravatar.cc/150?img=${DateTime.now().second % 10}',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  // In a real app, this would open the image picker
                  // For demo purposes, update with a placeholder
                  context.read<ProfileCubit>().updateProfilePicture(
                    'https://i.pravatar.cc/150?img=${DateTime.now().second % 10 + 10}',
                  );
                },
              ),
            ],
          ),
        );
      },
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
                  // In a real app, this would navigate to login screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully')),
                  );
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
                  // In a real app, this would navigate to login screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account deleted')),
                  );
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