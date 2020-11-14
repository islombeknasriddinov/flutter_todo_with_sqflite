import 'package:darmon/custom/animation_list/item_diff.dart';

class MedisineDiff implements ItemDiff<String> {
  @override
  String data;

  MedisineDiff(this.data);

  @override
  bool areContentsTheSame(String oldItem, String newItem) {
    return oldItem == newItem;
  }

  @override
  bool areItemsTheSame(String oldItem, String newItem) {
    return oldItem == newItem;
  }
}
