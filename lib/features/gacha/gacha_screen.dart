import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';
import '../../core/firestore_repository.dart';

class GachaScreen extends ConsumerWidget {
  const GachaScreen({super.key});

  Future<void> _drawGacha(BuildContext context, WidgetRef ref, int currentPoints, List<String> unlockedSkins, int currentTickets) async {
    // 1. Validation
    if (currentPoints < 100) return;

    // 2. Define Drop Table (Mock)
    const availableSkins = [
      'skin_crown', 'skin_scarf', 'skin_shades', 'skin_bowtie', 
      'skin_tophat', 'skin_party', 'skin_flowers'
    ];
    
    // 3. Draw
    final rnd = DateTime.now().millisecondsSinceEpoch % availableSkins.length;
    final drawnSkin = availableSkins[rnd];
    
    // 4. Check Duplicate
    final isDuplicate = unlockedSkins.contains(drawnSkin);
    
    // 5. Update Data
    final user = ref.read(userStreamProvider).value;
    if (user == null) return;
    
    final updates = <String, dynamic>{
      'currentPoints': currentPoints - 100,
    };
    
    if (isDuplicate) {
      updates['ticketCount'] = currentTickets + 1;
    } else {
      updates['unlockedSkins'] = [...unlockedSkins, drawnSkin];
    }
    
    try {
      await ref.read(firestoreRepositoryProvider).updateUser(user.uid, updates);
      
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(isDuplicate ? '被りました！' : 'New Item!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                   isDuplicate ? Icons.confirmation_number : Icons.checkroom,
                   size: 60,
                   color: isDuplicate ? Colors.blueGrey : Colors.orange,
                ),
                const SizedBox(height: 16),
                Text(
                  isDuplicate 
                    ? '既に持っているアイテムです。\nチケット1枚に変換されました。'
                    : '新しいスキンを獲得しました！\n($drawnSkin)',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ガチャ & ショップ'),
      ),
      body: userAsync.when(
        data: (user) {
          final points = user?.currentPoints ?? 0;
          final tickets = user?.ticketCount ?? 0;
          final skins = user?.unlockedSkins ?? [];

          return Column(
            children: [
              // Header / Wallet
              Container(
                padding: const EdgeInsets.all(24),
                color: Colors.amber[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('ポイント', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                        Text('$points pt', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('チケット', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                        Text('$tickets 枚', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Gacha Machine
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag, size: 120, color: Colors.orange),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: points >= 100
                            ? () => _drawGacha(context, ref, points, skins, tickets)
                            : null,
                        child: Column(
                          children: const [
                             Text('ガチャを引く', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                             Text('100 pt', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      if (points < 100)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('ポイントが足りません', style: TextStyle(color: Colors.red)),
                        ),
                        
                      const SizedBox(height: 40),
                      if (tickets >= 5)
                        ElevatedButton.icon(
                          onPressed: () => _showExchangeDialog(context, ref, skins, tickets),
                          icon: const Icon(Icons.star),
                          label: const Text('チケット5枚で好きなスキンと交換'),
                        ),
                        
                      const SizedBox(height: 40),
                      // Debug Section (Requested by User for verification)
                      const Divider(),
                      const Text('デバッグ用 (検証後削除)', style: TextStyle(color: Colors.grey)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => _debugAddPoints(ref, 1000),
                            child: const Text('+1000 pt'),
                          ),
                          TextButton(
                            onPressed: () => _debugAddTickets(ref, 5),
                            child: const Text('+5 Tickets'),
                          ),
                           TextButton(
                            onPressed: () => _debugResetSkins(ref),
                            child: const Text('Reset Skins'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  // --- Exchange Logic ---
  Future<void> _showExchangeDialog(BuildContext context, WidgetRef ref, List<String> unlockedSkins, int currentTickets) async {
    const allSkins = [
      'skin_crown', 'skin_scarf', 'skin_shades', 'skin_bowtie', 
      'skin_tophat', 'skin_party', 'skin_flowers'
    ];
    
    // Filter locked skins
    final lockedSkins = allSkins.where((s) => !unlockedSkins.contains(s)).toList();
    
    if (lockedSkins.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('全てのスキンを持っています！')));
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('スキン交換 (チケット5枚)'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: lockedSkins.length,
            itemBuilder: (context, index) {
              final skin = lockedSkins[index];
              return ListTile(
                leading: const Icon(Icons.checkroom, color: Colors.grey),
                title: Text(skin),
                trailing: ElevatedButton(
                  onPressed: () {
                    _processExchange(context, ref, skin, unlockedSkins, currentTickets);
                    Navigator.pop(ctx);
                  },
                  child: const Text('交換'),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('キャンセル')),
        ],
      ),
    );
  }

  Future<void> _processExchange(BuildContext context, WidgetRef ref, String targetSkin, List<String> currentSkins, int currentTickets) async {
    final user = ref.read(userStreamProvider).value;
    if (user == null) return;
    
    try {
      await ref.read(firestoreRepositoryProvider).updateUser(
        user.uid, 
        {
          'ticketCount': currentTickets - 5,
          'unlockedSkins': [...currentSkins, targetSkin],
        }
      );
      if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$targetSkin を入手しました！')));
      }
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // --- Debug Logic ---
  Future<void> _debugAddPoints(WidgetRef ref, int amount) async {
    final user = ref.read(userStreamProvider).value;
    if (user == null) return;
    await ref.read(firestoreRepositoryProvider).updateUser(
      user.uid, 
      {'currentPoints': (user.currentPoints) + amount}
    );
  }

  Future<void> _debugAddTickets(WidgetRef ref, int amount) async {
    final user = ref.read(userStreamProvider).value;
    if (user == null) return;
    await ref.read(firestoreRepositoryProvider).updateUser(
      user.uid, 
      {'ticketCount': (user.ticketCount) + amount}
    );
  }

  Future<void> _debugResetSkins(WidgetRef ref) async {
    final user = ref.read(userStreamProvider).value;
    if (user == null) return;
    await ref.read(firestoreRepositoryProvider).updateUser(
      user.uid, 
      {'unlockedSkins': [], 'ticketCount': 0, 'currentPoints': 0}
    );
  }
}
