// ignore_for_file: unused_field

import '../../../models/brand.dart';
import '../../../models/category.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';

class ProductByCategoryProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  Category? mySelectedCategory;
  SubCategory? mySelectedSubCategory;
  List<SubCategory> subCategories = [];
  List<Brand> brands = [];
  List<Brand> selectedBrands = [];
  List<Product> filteredProduct = [];

  ProductByCategoryProvider(this._dataProvider);

  //Done: should complete filterInitialProductAndSubCategory
  filterInitialProductAndSubCategory(Category selectedCategory) {
    mySelectedCategory = selectedCategory;
    mySelectedSubCategory = SubCategory(name: 'All');
    subCategories = _dataProvider.subCategories
        .where((element) => element.categoryId?.sId == selectedCategory.sId)
        .toList();
    subCategories.insert(0, SubCategory(name: 'All'));
    filteredProduct = _dataProvider.products
        .where(
            (element) => element.proCategoryId?.name == selectedCategory.name)
        .toList();
    notifyListeners();
  }

  //Done: should complete filterProductBySubCategory
  filterProductBySubCategory(SubCategory subCategory) {
    mySelectedSubCategory = subCategory; //-- Changes Made
    if (subCategory.name?.toLowerCase() == 'all') {
      filteredProduct = _dataProvider.products
          .where((element) =>
              element.proCategoryId?.name == mySelectedCategory?.name)
          .toList();
      brands = [];
    } else {
      filteredProduct = _dataProvider.products
          .where(
              (element) => element.proSubCategoryId?.name == subCategory.name)
          .toList();
      brands = _dataProvider.brands
          .where((element) => element.subcategoryId?.sId == subCategory.sId)
          .toList();
    }
    notifyListeners();
  }

  //Done: should complete filterProductByBrand
  void filterProductByBrand() {
    if (selectedBrands.isEmpty) {
      // If no brands are selected, show all products in the category
      filteredProduct = _dataProvider.products
          .where((product) =>
              product.proSubCategoryId?.name == mySelectedSubCategory?.name)
          .toList();
    } else {
      // Filter products by selected brands
      filteredProduct = _dataProvider.products
          .where((product) =>
              product.proSubCategoryId?.name == mySelectedSubCategory?.name &&
              selectedBrands
                  .any((brand) => product.proBrandId?.sId == brand.sId))
          .toList();
    }
    notifyListeners();
  }

  //Done: should complete sortProducts
  void sortProducts({required bool ascending}) {
    filteredProduct.sort((a, b) {
      if (ascending) {
        return a.price!.compareTo(b.price ?? 0); // Sort in ascending order
      } else {
        return b.price!.compareTo(a.price ?? 0); // Sort in descending order
      }
    });
    notifyListeners();
  }



  void updateUI() {
    notifyListeners();
  }
}
