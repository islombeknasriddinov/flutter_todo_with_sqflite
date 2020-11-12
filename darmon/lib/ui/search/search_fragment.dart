import 'package:darmon/ui/search/search_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';

class SearchFragment extends ViewModelFragment<SearchViewModel> {
  static final String ROUTE_NAME = "/search_fragment";

  static void open(BuildContext context) {
    Mold.openContent(context, ROUTE_NAME);
  }

  TextEditingController _searchQuery;

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);
    _searchQuery = new TextEditingController();
  }

  @override
  SearchViewModel onCreateViewModel(BuildContext buildContext) => SearchViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: BackButton(
          color: Colors.black87,
        ),
        title: _buildSearchField(),
        actions: _buildActions(),
        backgroundColor: Colors.white,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'sd',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      MyIcon.icon(
        Icons.clear,
        color: Colors.black87,
        onTap: () {
          if (_searchQuery == null || _searchQuery.text.isEmpty) {
            Mold.onBackPressed(this);
            return;
          }
          _clearSearchQuery();
        },
      ),
    ];
  }

  void _clearSearchQuery() {
    print("close search box");
    _searchQuery.clear();
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.black54),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    print("search query " + newQuery);
  }
}
