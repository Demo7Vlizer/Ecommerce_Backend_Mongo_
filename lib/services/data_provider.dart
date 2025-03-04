import '../models/brand.dart';

class DataProvider {
  List<Brand> brands = [];

  // Method to set brands
  void setBrands(List<Brand> newBrands) {
    brands = newBrands;
  }
}
