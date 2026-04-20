import 'package:go_router/go_router.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/department/department_list_view.dart';
import '../views/department/department_detail_view.dart';
import '../views/president/president_list_view.dart';
import '../views/president/president_detail_view.dart';
import '../views/natural_area/natural_area_list_view.dart';
import '../views/natural_area/natural_area_detail_view.dart';
import '../views/touristic_attraction/touristic_attraction_list_view.dart';
import '../views/touristic_attraction/touristic_attraction_detail_view.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: '/departments',
        name: 'departmentList',
        builder: (context, state) => const DepartmentListView(),
      ),
      GoRoute(
        path: '/departments/:id',
        name: 'departmentDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DepartmentDetailView(id: id);
        },
      ),
      GoRoute(
        path: '/presidents',
        name: 'presidentList',
        builder: (context, state) => const PresidentListView(),
      ),
      GoRoute(
        path: '/presidents/:id',
        name: 'presidentDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PresidentDetailView(id: id);
        },
      ),
      GoRoute(
        path: '/natural-areas',
        name: 'naturalAreaList',
        builder: (context, state) => const NaturalAreaListView(),
      ),
      GoRoute(
        path: '/natural-areas/:id',
        name: 'naturalAreaDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return NaturalAreaDetailView(id: id);
        },
      ),
      GoRoute(
        path: '/touristic',
        name: 'touristicList',
        builder: (context, state) => const TouristicAttractionListView(),
      ),
      GoRoute(
        path: '/touristic/:id',
        name: 'touristicDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TouristicAttractionDetailView(id: id);
        },
      ),
    ],
  );
}
