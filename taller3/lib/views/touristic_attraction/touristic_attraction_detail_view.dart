import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_icons.dart';
import '../../models/touristic_attraction.dart';
import '../../services/touristic_attraction_service.dart';
import '../../themes/app_theme.dart';
import '../../widgets/state_widget.dart';

class TouristicAttractionDetailView extends StatefulWidget {
  final String id;
  const TouristicAttractionDetailView({super.key, required this.id});

  @override
  State<TouristicAttractionDetailView> createState() =>
      _TouristicAttractionDetailViewState();
}

class _TouristicAttractionDetailViewState
    extends State<TouristicAttractionDetailView> {
  ViewState _state = ViewState.loading;
  TouristicAttraction? _item;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _state = ViewState.loading);
    try {
      final item = await TouristicAttractionService.getById(
        int.parse(widget.id),
      );
      setState(() {
        _item = item;
        _state = ViewState.success;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _state = ViewState.error;
      });
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.tertiaryColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1A),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(AppIcons.back, color: Color(0xFF7C4DFF)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _item?.name ?? 'Atracción',
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: StateWidget(
        state: _state,
        errorMessage: _errorMessage,
        onRetry: _fetchData,
        child: _item == null
            ? const SizedBox()
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
                    backgroundColor: const Color(0xFF0D0D1A),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        _item!.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.tertiaryColor,
                              AppTheme.backgroundColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            AppIcons.name,
                            'Nombre',
                            _item!.name,
                          ),
                          _buildInfoRow(
                            AppIcons.description,
                            'Descripción',
                            _item!.description,
                          ),
                          _buildInfoRow(
                            AppIcons.location,
                            'Latitud',
                            _item!.latitude?.toString() ?? 'N/A',
                          ),
                          _buildInfoRow(
                            AppIcons.location,
                            'Longitud',
                            _item!.longitude?.toString() ?? 'N/A',
                          ),
                          _buildInfoRow(
                            AppIcons.location,
                            'Ciudad',
                            _item!.cityName ?? 'ID: ${_item!.cityId}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
