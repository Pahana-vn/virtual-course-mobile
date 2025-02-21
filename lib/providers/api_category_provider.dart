// providers/api_category_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_dto.dart';
import '../services/api_category_service.dart';

final apiCategoryServiceProvider = Provider<ApiCategoryService>((ref) {
  return ApiCategoryService();
});

final allCategoriesProvider = FutureProvider<List<CategoryDTO>>((ref) async {
  final service = ref.watch(apiCategoryServiceProvider);
  return service.fetchAllCategories();
});
