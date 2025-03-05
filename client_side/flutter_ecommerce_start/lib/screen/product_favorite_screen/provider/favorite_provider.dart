import 'package:e_commerce_flutter/utility/constants.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  // ignore: unused_field
  final DataProvider _dataProvider;
  final box = GetStorage();
  List<Product> favoriteProduct = [];
  FavoriteProvider(this._dataProvider);

  //TODO: should complete updateToFavoriteList
  updateToFavoriteList(String productId) {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    if (favoriteList.contains(productId)) {
      favoriteList.remove(productId);
    } else {
      favoriteList.add(productId);
    }
    checkIsItemFavorite(productId);
    box.write(FAVORITE_PRODUCT_BOX, favoriteList);
    loadFavoriteItems();
    notifyListeners();
  }

  //TODO: should complete checkIsItemFavorite
  bool checkIsItemFavorite(String productId) {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    bool isExist = favoriteList.contains(productId);
    return isExist;
  }

  //TODO: should complete loadFavoriteItems
  void loadFavoriteItems() {
    List<dynamic> favoriteListIds = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    favoriteProduct = _dataProvider.products.where((product) {
      return favoriteListIds.contains(product.sId);
    }).toList();
    notifyListeners();
  }

  //TODO: should complete clearFavoriteList
  clearFavoriteList() {
    box.remove(FAVORITE_PRODUCT_BOX);
  }

}
