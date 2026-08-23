import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/data/models/forgot_password.dart';
import 'package:slipwise/modules/auth/screens/shared/user_notifier.dart';
import 'package:slipwise/modules/auth/data/models/update_profile.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    final userAsync = ref.watch(userProvider);
    final user = userAsync.value;

    final username = user?.username ?? 'Guest';
    final email = user?.email ?? '';
    final profileUrl = 'https://api.dicebear.com/10.x/blobs/svg?seed=$username';

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140.0,
            pinned: true,
            backgroundColor: colorScheme.background,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.55),
                      colorScheme.primary.withValues(alpha: 0.35),
                      colorScheme.primary.withValues(alpha: 0.25),
                      colorScheme.primary.withValues(alpha: 0.15),
                      colorScheme.primary.withValues(alpha: 0.08),
                      colorScheme.primary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.25, 0.45, 0.65, 0.85, 1.0],
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Profile',
                style: theme.textTheme.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.foreground,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Profile Header Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.card,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: colorScheme.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.primary.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: SvgPicture.network(
                              profileUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: theme.textTheme.h4.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.foreground,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                email,
                                style: theme.textTheme.small.copyWith(
                                  color: colorScheme.mutedForeground,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LucideIcons.edit2,
                            size: 16,
                            color: colorScheme.foreground,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Menu Items
                  _buildMenuGroup(
                    theme: theme,
                    colorScheme: colorScheme,
                    title: 'Account',
                    items: [
                      _buildMenuItem(
                        icon: LucideIcons.user,
                        label: 'Personal Information',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Personal Information',
                          PersonalInfoModal(
                            currentUsername: username,
                            currentEmail: email,
                          ),
                        ),
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.lock,
                        label: 'Security & Password',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Security & Password',
                          SecurityModal(email: email),
                        ),
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.bell,
                        label: 'Notifications',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Notifications',
                          const Center(
                            child: Text('Notification settings coming soon.'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildMenuGroup(
                    theme: theme,
                    colorScheme: colorScheme,
                    title: 'Support',
                    items: [
                      _buildMenuItem(
                        icon: LucideIcons.helpCircle,
                        label: 'Help & Support',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Help & Support',
                          const Center(
                            child: Text('Contact us at support@slipwise.app'),
                          ),
                        ),
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.messageSquare,
                        label: 'Submit Feedback',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Anonymous Feedback',
                          const FeedbackModal(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ShadButton.destructive(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => ShadDialog(
                            title: const Text('Log Out'),
                            description: const Text(
                              'Are you sure you want to log out of your account?',
                            ),
                            actions: [
                              ShadButton.outline(
                                child: const Text('Cancel'),
                                onPressed: () => Navigator.pop(ctx, false),
                              ),
                              ShadButton.destructive(
                                child: const Text('Log Out'),
                                onPressed: () => Navigator.pop(ctx, true),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          await ref.read(userProvider.notifier).logout();
                          if (context.mounted) {
                            context.go('/get-started');
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.logOut, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Log Out',
                            style: theme.textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.destructiveForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGroup({
    required String title,
    required List<Widget> items,
    required ShadThemeData theme,
    required ShadColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.small.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.mutedForeground,
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colorScheme.border),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              if (isLast) {
                return item;
              }

              return Column(
                children: [
                  item,
                  Padding(
                    padding: const EdgeInsets.only(left: 56),
                    child: Divider(height: 1, color: colorScheme.border),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ShadThemeData theme,
    required ShadColorScheme colorScheme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: colorScheme.foreground),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.foreground,
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: colorScheme.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheetModal(
    BuildContext context,
    String title,
    Widget content,
  ) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              border: Border.all(color: colorScheme.border),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.muted,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.foreground,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            LucideIcons.x,
                            color: colorScheme.mutedForeground,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: colorScheme.border),
                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: content,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FeedbackModal extends HookConsumerWidget {
  const FeedbackModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isSubmitting = useState(false);

    // Rebuild when text changes to check length
    useListenable(controller);

    final isValid =
        controller.text.trim().length >= 10 &&
        controller.text.trim().length <= 2000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Tell us what you think! We are constantly trying to improve SlipWise.',
        ),
        const SizedBox(height: 16),
        ShadInputFormField(
          controller: controller,
          maxLines: 5,
          placeholder: const Text('Type your feedback here (min 10 chars)...'),
        ),
        const SizedBox(height: 32),
        ShadButton(
          enabled: isValid && !isSubmitting.value,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            isSubmitting.value = true;
            final error = await ref
                .read(userProvider.notifier)
                .submitFeedback(controller.text.trim());
            isSubmitting.value = false;

            if (context.mounted) {
              if (error == null) {
                Navigator.pop(context);
                ShadToaster.of(context).show(
                  const ShadToast(
                    title: Text('Success'),
                    description: Text('Thank you for your feedback!'),
                  ),
                );
              } else {
                ShadToaster.of(context).show(
                  ShadToast(
                    title: const Text('Error'),
                    description: Text(error),
                  ),
                );
              }
            }
          },
          child: isSubmitting.value
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Send Feedback'),
        ),
      ],
    );
  }
}

class PersonalInfoModal extends HookConsumerWidget {
  final String currentUsername;
  final String currentEmail;

  const PersonalInfoModal({
    super.key,
    required this.currentUsername,
    required this.currentEmail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: currentUsername);
    final isSubmitting = useState(false);
    useListenable(controller);

    final isValid =
        controller.text.trim().isNotEmpty &&
        controller.text.trim() != currentUsername;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ShadInputFormField(
          label: const Text('Username'),
          controller: controller,
        ),
        const SizedBox(height: 16),
        ShadInputFormField(
          label: const Text('Email'),
          initialValue: currentEmail,
          enabled: false,
          description: const Text('Email cannot be changed.'),
        ),
        const SizedBox(height: 32),
        ShadButton(
          enabled: isValid && !isSubmitting.value,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            isSubmitting.value = true;

            final req = UpdateProfileRequest(username: controller.text.trim());
            final res = await ref
                .read(authRepositoryProvider)
                .updateProfile(req);

            isSubmitting.value = false;
            if (context.mounted) {
              res.fold(
                ifLeft: (failure) {
                  ShadToaster.of(context).show(
                    ShadToast(
                      title: const Text('Error'),
                      description: Text(failure.message),
                    ),
                  );
                },
                ifRight: (_) {
                  ref.read(userProvider.notifier).fetch();
                  Navigator.pop(context);
                  ShadToaster.of(context).show(
                    const ShadToast(
                      title: Text('Success'),
                      description: Text('Profile updated successfully.'),
                    ),
                  );
                },
              );
            }
          },
          child: isSubmitting.value
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save Changes'),
        ),
      ],
    );
  }
}

class SecurityModal extends HookConsumerWidget {
  final String email;

  const SecurityModal({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmitting = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'To change your password, we will send a verification code to your email.',
        ),
        const SizedBox(height: 32),
        ShadButton(
          enabled: !isSubmitting.value,
          onPressed: () async {
            isSubmitting.value = true;
            final req = ForgotPasswordRequest(email: email);
            final res = await ref
                .read(authRepositoryProvider)
                .forgotPassword(req);
            isSubmitting.value = false;

            if (context.mounted) {
              res.fold(
                ifLeft: (failure) {
                  ShadToaster.of(context).show(
                    ShadToast(
                      title: const Text('Error'),
                      description: Text(failure.message),
                    ),
                  );
                },
                ifRight: (_) {
                  Navigator.pop(context);
                  // Logout to secure session before reset
                  ref.read(userProvider.notifier).logout();
                  context.go('/reset-password', extra: email);
                },
              );
            }
          },
          child: isSubmitting.value
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Send Reset Code'),
        ),
      ],
    );
  }
}
