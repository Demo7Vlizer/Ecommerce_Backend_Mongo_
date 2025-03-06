// ignore_for_file: unused_field

import 'package:e_commerce_flutter/models/api_response.dart';
import 'package:e_commerce_flutter/models/user.dart';
import 'package:e_commerce_flutter/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import '../../../models/category.dart';
// import '../../models/api_response.dart';
import '../../models/brand.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/sub_category.dart';
// import '../../models/user.dart';
import '../../services/http_services.dart';
// import '../../utility/constants.dart';
// import '../../utility/snack_bar_helper.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  // ignore: duplicate_ignore
  // ignore: unused_field
  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  // ignore: prefer_final_fields
  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  // ignore: duplicate_ignore
  // ignore: unused_field
  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _allProducts;

  // ignore: duplicate_ignore
  // ignore: unused_field
  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  // ignore: duplicate_ignore
  // ignore: unused_field
  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  DataProvider() {
    getAllOrders();
    print('=== DataProvider Initialization ===');
    print('1. Starting data provider initialization...');
    getAllProduct().then((_) {
      print('2. Products loaded');
      print('   - Product count: ${_allProducts.length}');
      if (_allProducts.isNotEmpty) {
        print('   - First product: ${_allProducts[0].name}');
        print(
            '   - First product images: ${_allProducts[0].images?.map((img) => img.url).toList()}');
      }
    });
    getAllCategory().then(
        (_) => print('3. Categories loaded - count: ${_allCategories.length}'));
    getAllSubCategory().then((_) =>
        print('4. SubCategories loaded - count: ${_allSubCategories.length}'));
    getAllBrands()
        .then((_) => print('5. Brands loaded - count: ${_allBrands.length}'));
    getAllPosters()
        .then((_) => print('6. Posters loaded - count: ${_allPosters.length}'));
  }

//---------------------------------------------------------------------------------------------------

//TODO: should complete getAllSubCategory
  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Category.fromJson(item)).toList(),
        ); // ApiResponse.fromJson
        _allCategories = apiResponse.data ?? [];
        _filteredCategories =
            List.from(_allCategories); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCategories;
  }

//TODO: should complete filterSubCategories
  void filterCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //TODO: should complete getAllCategory
  Future<List<SubCategory>> getAllSubCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'subCategories');
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => SubCategory.fromJson(item)).toList(),
        ); // ApiResponse.fromJson
        _allSubCategories = apiResponse.data ?? [];
        _filteredSubCategories = List.from(
            _allSubCategories); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredSubCategories;
  }

  //TODO: should complete filterCategories
  void filterSubCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subcategory) {
        return (subcategory.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //TODO: should complete getAllBrands -- done..
  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'brands');
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(
          response.body,
          (json) => (json as List).map((item) => Brand.fromJson(item)).toList(),
        ); // ApiResponse.fromJson
        _allBrands = apiResponse.data ?? [];
        _filteredBrands =
            List.from(_allBrands); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredBrands;
  }

  //TODO: should complete filterBrands  -- done..
  void filterBrands(String keyword) {
    if (keyword.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((brand) {
        return (brand.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //TODO: should complete getAllProduct
  Future<void> getAllProduct({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'products');
      ApiResponse<List<Product>> apiResponse =
          ApiResponse<List<Product>>.fromJson(
        response.body,
        (json) => (json as List).map((item) => Product.fromJson(item)).toList(),
      );
      _allProducts = apiResponse.data ?? [];
      _filteredProducts =
          List.from(_allProducts); // Initialize with original data
      notifyListeners();
      if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
  }

  //TODO: should complete filterProducts
  void filterProducts(String keyword) {
    if (keyword.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      final lowerKeyword = keyword.toLowerCase();

      _filteredProducts = _allProducts.where((product) {
        final productNameContainsKeyword =
            (product.name ?? '').toLowerCase().contains(lowerKeyword);
        final categoryNameContainsKeyword = product.proSubCategoryId?.name
                ?.toLowerCase()
                .contains(lowerKeyword) ??
            false;
        final subCategoryNameContainsKeyword = product.proSubCategoryId?.name
                ?.toLowerCase()
                .contains(lowerKeyword) ??
            false;

        //? You can add more conditions here if there are more fields to match against
        return productNameContainsKeyword ||
            categoryNameContainsKeyword ||
            subCategoryNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }

  //TODO: should complete getAllPosters
  Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'posters');
      if (response.isOk) {
        ApiResponse<List<Poster>> apiResponse =
            ApiResponse<List<Poster>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Poster.fromJson(item)).toList(),
        ); // ApiResponse.fromJson

        _allPosters = apiResponse.data ?? [];
        _filteredPosters = List.from(_allPosters);
        notifyListeners();

        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }

    return _filteredPosters;
  }

//---------------------------------------------------------------------------------------------------

  //TODO: should complete getAllCategory

  //TODO: should complete filterCategories

  //TODO: should complete getAllSubCategory

  //TODO: should complete filterSubCategories

  //TODO: should complete getAllBrands

  //TODO: should complete filterBrands

  //TODO: should complete getAllProduct

  //TODO: should complete filterProducts

  //TODO: should complete getAllPosters

  //TODO: should complete getAllOrderByUser
   Future<List<Order>> getAllOrders({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'orders');
      if (response.isOk) {
        ApiResponse<List<Order>> apiResponse =
            ApiResponse<List<Order>>.fromJson(
          response.body,
          (json) => (json as List).map((item) => Order.fromJson(item)).toList(),
        ); // ApiResponse.fromJson

        print(apiResponse.message);
        _allOrders = apiResponse.data ?? [];
        _filteredOrders = List.from(_allOrders);
        notifyListeners();

        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredOrders;
  }

  double calculateDiscountPercentage(num originalPrice, num? discountedPrice) {
    if (originalPrice <= 0) {
      throw ArgumentError('Original price must be greater than zero.');
    }

    //? Ensure discountedPrice is not null; if it is, default to the original price (no discount)
    num finalDiscountedPrice = discountedPrice ?? originalPrice;

    if (finalDiscountedPrice > originalPrice) {
      return originalPrice.toDouble();
    }

    double discount =
        ((originalPrice - finalDiscountedPrice) / originalPrice) * 100;

    //? Return the discount percentage as an integer
    return discount;
  }

  Future<List<Order>> getAllOrderByUser(User? user,
      {bool showSnack = false}) async {
    try {
      String userId = user?.sId ?? '';
      if (userId.isEmpty) {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar('User not found');
        }
        return [];
      }

      Response response =
          await service.getItems(endpointUrl: 'orders/orderByUserId/$userId');

      if (response.isOk) {
        ApiResponse<List<Order>> apiResponse =
            ApiResponse<List<Order>>.fromJson(
          response.body,
          (json) => (json as List).map((item) => Order.fromJson(item)).toList(),
        );

        if (showSnack && apiResponse.success) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }

        _allOrders = apiResponse.data ?? [];
        _filteredOrders = List.from(_allOrders);
        notifyListeners();
        return _filteredOrders;
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              response.body['message'] ?? 'Failed to fetch orders');
        }
        return [];
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(
            'Error fetching orders: ${e.toString()}');
      }
      return [];
    }
  }
}
