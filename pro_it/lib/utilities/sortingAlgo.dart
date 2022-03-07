import 'package:pro_it/models/models.dart';

class SortingAlgo {

  /// views.sort((a, b) => a.views.compareTo(b.views));
  static void bubbleSort(List<ProductV> array) {
    for (int i = 0; i < array.length - 1; i++) {
      for (int j = 0; j < array.length - i - 1; j++) {
        if (array[j].views > array[j + 1].views) {
          ProductV temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
        }
      }
    }
  }

  static int partition(List<ProductV> a, int p, int r) {
    ProductV x = a[r];
    int i = p - 1;
    for (int j = p; j <= r - 1; j++) {
      if (a[j].views <= x.views) {
        i++;
        //exchange(a[i],a[j]);
        ProductV temp = a[i];
        a[i] = a[j];
        a[j] = temp;
      }
    }
    ProductV tmp = a[i + 1];
    a[i + 1] = a[r];
    a[r] = tmp;
    return i + 1;
  }

  static void quicksort(List<ProductV> views, int p, int r) {
    if (p < r) {
      int q = partition(views, p, r);
      quicksort(views, p, q - 1);
      quicksort(views, q + 1, r);
    }
  }
}
