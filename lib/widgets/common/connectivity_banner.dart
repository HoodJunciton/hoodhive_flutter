import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/network_service.dart';

final connectivityProvider = StreamProvider<bool>((ref) {
  return NetworkService.connectivityStream;
});

class ConnectivityBanner extends ConsumerWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityAsync = ref.watch(connectivityProvider);

    return connectivityAsync.when(
      data: (isConnected) {
        if (isConnected) {
          return const SizedBox.shrink();
        }
        
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.red.shade600,
              child: Row(
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'No internet connection. Using offline data.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Retry connection
                      ref.invalidate(connectivityProvider);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}