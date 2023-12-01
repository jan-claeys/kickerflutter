import 'package:flutter/material.dart';

class ListWidget<T> extends StatefulWidget {
  final Widget Function(T, int index, Function reloadList) tileBuilder;
  final Future Function(int pageNumber) loadMoreItems;

  const ListWidget({
    super.key,
    required this.tileBuilder,
    required this.loadMoreItems,
  });

  @override
  State<ListWidget> createState() => _ListWidgetState<T>();
}

class _ListWidgetState<T> extends State<ListWidget<T>> {
  final List<T> _items = [];
  bool _isLoading = true;
  bool _hasMore = true;
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMoreItems();
  }

  @override 
  void setState(VoidCallback fn){
    if(mounted){
      super.setState(fn);
    }
  }

  void reloadList(){
    setState(() {
      _isLoading = true;
      _hasMore = true;
      pageNumber = 1;
      _items.clear();
      _loadMoreItems();
    });
  }

  void _loadMoreItems() {
    _isLoading = true;

    widget.loadMoreItems(pageNumber).then((items) {
      if (items.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          pageNumber++;
          _items.addAll(items);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _hasMore ? _items.length + 1 : _items.length,
      itemBuilder: (context, index) {
        if (index >= _items.length) {
          // Don't trigger if one async loading is already under way
          if (!_isLoading) {
            _loadMoreItems();
          }
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return widget.tileBuilder(_items[index], index, reloadList);
      },
    );
  }
}
