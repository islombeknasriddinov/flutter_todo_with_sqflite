import 'package:darmon/custom/animation_list/item_diff.dart';
import 'package:darmon/custom/animation_list/list_model.dart';

class DiffUtil {
  static void calculate<A>(
      ListModel<A> model, List<ItemDiff<A>> oldList, List<ItemDiff<A>> newList) {
    assert(model != null);
    assert(newList != null);
    assert(oldList != null);
    List<A> deletedItems = [];
    List<A> insertedItems = [];

    for (var value in oldList) {
      if (newList.firstWhere((element) => value.areItemsTheSame(value.data, element.data),
              orElse: () => null) ==
          null) {
        deletedItems.add(value.data);
      }
    }

    for (var value in newList) {
      if (oldList.firstWhere((element) => value.areItemsTheSame(value.data, element.data),
              orElse: () => null) ==
          null) {
        insertedItems.add(value.data);
      }
    }

    deletedItems.forEach((element) {
      int deletedItem = model.indexOf(element);
      if (deletedItem != -1) model.removeAt(deletedItem);
    });

    insertedItems.forEach((element) {
      final int index = model.length;
      model.insert(index, element);
    });
  }
}
