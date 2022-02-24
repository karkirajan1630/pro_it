import '../models/models.dart';

class RecentProductService {
  // static displayList(dynamic list, String name) {
  //   print("$name: [");
  //   for (var item in list) {
  //     print("${item.toMap()},");
  //   }
  //   print("]");
  // }

  static List<Product> getRecent(
      List<Product> main, List<ProductV> views) {
    // displayList(main, "Service");
    // displayList(views, "ProductV");
    List<Product> res = [];
    views.sort((a, b) => a.views.compareTo(b.views));
    // displayList(views, "Sorted ProductV according to views");
    for (var item in views) {
      res.add(main.where((e) => e.id == item.id).toList()[0]);
    }

    List<Product> finalRes = [];
    finalRes.addAll(res.reversed.toList());
    for (var a in main) {
      if (!finalRes.contains(a)) {
        finalRes.add(a);
      }
    }

    return finalRes;
  }
}
