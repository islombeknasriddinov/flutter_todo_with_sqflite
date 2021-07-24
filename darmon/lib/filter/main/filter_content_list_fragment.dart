
import 'package:darmon/filter/main/filter_viewmodel.dart';
import 'package:darmon/filter/main/ui/filter_bottom_sheet_container.dart';
import 'package:darmon/gwslib/mold_content_list_fragment.dart';

abstract class FilterContentListFragment<E, VM extends FilterViewModel>
    extends MoldContentListFragment<E, VM> {
  void showFilterBottomSheetDialog() {
    FilterBottomSheetDialog.show(getContext(), viewmodel.filterProtocol);
  }
}
