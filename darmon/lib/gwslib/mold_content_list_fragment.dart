import 'package:darmon/gwslib/mold_content_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/mold/fragment.dart';
import 'package:rxdart/rxdart.dart';

typedef FilterSearchTextCallback<E> = bool Function(E element, String text);

typedef Predicate<E> = bool Function(E element);

abstract class MoldContentListFragment<E, VM extends ViewModel> extends MoldContentFragment<VM> {
  _FilterList<E> _filterList = _FilterList();

  IconData _emptyIcon;
  String _emptyString;
  Widget _emptyWidget;

  void setItems(List<E> items) {
    this._filterList.filter(items);
  }

  void setEmptyIcon(IconData icon) {
    this._emptyIcon = icon;
  }

  void setEmptyString(String message) {
    this._emptyString = message;
  }

  void setEmptyWidget(Widget widget) {
    this._emptyWidget = widget;
  }

  Widget adapterPopulateWidget(BuildContext context, E element);

  Widget _emptyContent(BuildContext context) {
    if (this._emptyWidget != null) {
      return this._emptyWidget;
    }

    if (_emptyIcon == null && _emptyString == null) {
      return Container();
    }

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Padding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(this._emptyIcon, size: 150, color: Colors.black12),
                Padding(
                  child: Text(this._emptyString ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 22)),
                  padding: EdgeInsets.all(24),
                ),
              ],
            ),
            padding: EdgeInsets.only(bottom: 36),
          ),
        )
      ],
    );
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return StreamBuilder(
      initialData: null,
      stream: this._filterList.getFilterItemsSubject(),
      builder: (buildContext, snapshot) {
        if (snapshot.data == null || (snapshot.data as Iterable<E>).length == 0) {
          return this._emptyContent(context);
        }

        List<E> list = snapshot.data;
        return ListView.builder(
          itemBuilder: (buildContext, index) {
            return adapterPopulateWidget(buildContext, list[index]);
          },
          itemCount: list.length,
        );
      },
    );
  }

  @override
  void onDestroy() {
    super.onDestroy();
    this._filterList.stop();
  }
}

// class SearchActionFilter<E> extends SearchAction {
//   MoldContentListFragment _listContent;
//   FilterSearchTextCallback<E> filterCallback;
//   String _lastText;
//
//   SearchActionFilter(this.filterCallback) : super(onTextChange: null, onSubmitted: null);
//
//   void setListContent(MoldContentListFragment content) {
//     this._listContent = content;
//   }
//
//   void onFilterSearchText(String text) {
//     if (text == null) {
//       this._listContent._filterList.setSearchPredicate(null);
//     } else {
//       if (text.length == 0) {
//         this._listContent._filterList.setSearchPredicate((element) {
//           return true;
//         });
//       } else {
//         if (this._listContent != null &&
//             this.filterCallback != null &&
//             (_lastText == null || _lastText != text)) {
//           this._listContent._filterList.setSearchPredicate((element) {
//             return this.filterCallback.call(element, text);
//           });
//         }
//       }
//     }
//     this._lastText = text;
//   }
//
//   @override
//   void onTextChange(String text) {
//     onFilterSearchText(text);
//   }
//
//   @override
//   void onSubmitted(String text) {
//     onFilterSearchText(text);
//   }
//
//   @override
//   void onCancel() {
//     super.onCancel();
//     if (_listContent != null) {
//       _listContent._filterList.setSearchPredicate(null);
//     }
//   }
// }

class _FilterList<E> {
  List<E> _items;

  // ignore: close_sinks
  BehaviorSubject<List<E>> _filterItems = BehaviorSubject.seeded([]);

  Predicate<E> _filterPredicate;
  Predicate<E> _searchPredicate;

  void setFilterPredicate(Predicate<E> predicate) {
    this._filterPredicate = predicate;
    this.filter(this._items);
  }

  void setSearchPredicate(Predicate<E> predicate) {
    this._searchPredicate = predicate;
    this.filter(this._items);
  }

  Subject<Iterable<E>> getFilterItemsSubject() => this._filterItems;

  void filter(List<E> items) {
    this._items = items;

    Iterable<E> result;

    if (this._searchPredicate == null && this._filterPredicate == null) {
      result = this._items;
    } else {
      result = items;
      if (this._searchPredicate != null) {
        result = result.where(this._searchPredicate);
      }
      if (this._filterPredicate != null) {
        result = result.where(this._filterPredicate);
      }
    }

    if (result == null) {
      return;
    }

    if (this._filterItems == null) {
      this._filterItems = BehaviorSubject.seeded(_items);
    } else {
      this._filterItems.add(result.toList());
    }
  }

  void stop() {
    if (this._filterItems != null && !this._filterItems.isClosed) {
      this._filterItems.close();
    }
  }
}
