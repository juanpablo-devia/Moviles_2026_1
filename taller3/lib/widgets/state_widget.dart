import 'package:flutter/material.dart';
import '../config/app_icons.dart';
import '../themes/app_theme.dart';

enum ViewState { loading, success, error }

class StateWidget extends StatelessWidget {
  final ViewState state;
  final String? errorMessage;
  final VoidCallback onRetry;
  final Widget child;

  const StateWidget({
    super.key,
    required this.state,
    this.errorMessage,
    required this.onRetry,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppTheme.secondaryColor),
              const SizedBox(height: 16),
              Text(
                'Cargando...',
                style: TextStyle(color: Colors.white60, fontSize: 16),
              ),
            ],
          ),
        );
      case ViewState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(AppIcons.error, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                errorMessage ?? 'Error desconocido',
                style: TextStyle(color: Colors.white60, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                ),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        );
      case ViewState.success:
        return child;
    }
  }
}
