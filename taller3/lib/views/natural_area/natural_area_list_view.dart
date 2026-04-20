import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_icons.dart';
import '../../models/natural_area.dart';
import '../../services/natural_area_service.dart';
import '../../widgets/state_widget.dart';
import '../../widgets/list_item_card.dart';

class NaturalAreaListView extends StatefulWidget {
  const NaturalAreaListView({super.key});

  @override
  State<NaturalAreaListView> createState() => _NaturalAreaListViewState();
}

class _NaturalAreaListViewState extends State<NaturalAreaListView> {
  ViewState _state = ViewState.loading;
  List<NaturalArea> _items = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _state = ViewState.loading);
    try {
      final items = await NaturalAreaService.getAll();
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
          'Áreas Naturales',
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
              title: item.name,
              subtitle:
                  '${item.categoryName} - ${item.landArea?.toStringAsFixed(0) ?? '?'} ha',
              onTap: () => context.go('/natural-areas/${item.id}'),
            );
          },
        ),
      ),
    );
  }
}
