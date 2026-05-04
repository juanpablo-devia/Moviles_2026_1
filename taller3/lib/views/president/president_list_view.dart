import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_icons.dart';
import '../../models/president.dart';
import '../../services/president_service.dart';
import '../../widgets/state_widget.dart';
import '../../widgets/list_item_card.dart';

class PresidentListView extends StatefulWidget {
  const PresidentListView({super.key});

  @override
  State<PresidentListView> createState() => _PresidentListViewState();
}

class _PresidentListViewState extends State<PresidentListView> {
  ViewState _state = ViewState.loading;
  List<President> _items = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _state = ViewState.loading;
      _items = [];
    });
    try {
      final items = await PresidentService.getAll();
      setState(() {
        _items = items;
        _state = ViewState.success;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _state = ViewState.error;
      });
    }
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
        title: const Text(
          'Presidentes',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: StateWidget(
        state: _state,
        errorMessage: _errorMessage,
        onRetry: _fetchData,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListItemCard(
              title: '${item.name} ${item.lastName}',
              subtitle: '${item.startPeriodDate} - ${item.endPeriodDate}',
              onTap: () => context.go('/presidents/${item.id}'),
            );
          },
        ),
      ),
    );
  }
}
