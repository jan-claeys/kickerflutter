import 'package:flutter/material.dart';

class ListWidget<T> extends StatefulWidget {
  final Widget Function(T, int index, Function removeItem) tileBuilder;
  final Future Function(int pageNumber) loadMoreItems;
  final ScrollController scrollController;

  const ListWidget({
    super.key,
    required this.tileBuilder,
    required this.loadMoreItems,
    required this.scrollController,
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
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void removeItem(T item) {
    setState(() {
      _items.remove(item);
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
      controller: widget.scrollController,
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
        return widget.tileBuilder(_items[index], index, removeItem);
      },
    );
  }
}
