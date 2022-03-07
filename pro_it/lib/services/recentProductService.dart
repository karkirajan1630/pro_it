import 'package:pro_it/utilities/sortingAlgo.dart';

import '../models/models.dart';

class RecentProductService {
  static displayList(dynamic list, String name) {
    print("$name: [");
    for (var item in list) {
      print("${item.toMap()},");
    }
    print("]");
  }

  static List<Product> getRecent(List<Product> main, List<ProductV> views) {
    SortingAlgo.quicksort(views,0,views.length - 1);
    // SortingAlgo.bubbleSort(views);
    List<Product> resultV = [];
    for (var item in views) {
      resultV.add(main.where((e) => e.id == item.id).toList()[0]);
    }
    List<Product> finalResult = resultV.reversed.toList();
    for (Product a in main) {
      if (!finalResult.contains(a)) {
        finalResult.add(a);
      }
    }

    return finalResult;
  }
}
