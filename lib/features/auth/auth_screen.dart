import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../core/firestore_repository.dart';
import '../../models/user_model.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Habit Penguin',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('育成型タスク管理', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('ゲストとしてはじめる'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () async {
                try {
                  final cred = await ref.read(firebaseAuthProvider).signInAnonymously();
                  if (cred.user != null) {
                    final repo = ref.read(firestoreRepositoryProvider);
                    // Check if user doc exists (via stream is slow, use direct get if possible, or just try create)
                    // Since Repository doesn't have `getUser`, we'll just create a default one if it's a new anonymous sign in.
                    // Ideally we check if it's a *new* user.
                    if (cred.additionalUserInfo?.isNewUser == true) {
                       final newUser = UserModel(
                        uid: cred.user!.uid,
                        name: 'ゲスト',
                        groupId: null,
                        createdAt: DateTime.now(),
                      );
                      await repo.createUser(newUser);
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('ログインエラー: $e')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
