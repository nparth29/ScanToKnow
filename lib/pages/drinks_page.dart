// lib/pages/drinks_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:main_project_files/models/food_item.dart';
import 'package:main_project_files/services/food_service.dart';
import 'package:main_project_files/widgets/product_card.dart';

class DrinksPage extends StatefulWidget {
  final String? initialCategory;
  const DrinksPage({super.key, this.initialCategory});

  @override
  State<DrinksPage> createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  // pagination state
  int _page = 0;
  final int _limit = 24;

  // items accumulated after initial load
  final List<FoodItem> _items = [];

  // control flags
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isInitialLoaded = false;

  // scroll controller for infinite scroll
  final ScrollController _scrollController = ScrollController();

  // initial fetch future (used by FutureBuilder)
  late Future<FoodResponse> _initialFuture;

  @override
  void initState() {
    super.initState();
    _initialFuture = FoodService.fetchFoods(
      primaryCategory: widget.initialCategory ?? "drinks",
      page: 0,
      limit: _limit,
    );

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // called when scrolling near bottom
  void _onScroll() {
    if (!_hasMore || _isLoadingMore) return;
    if (_scrollController.position.extentAfter < 400) {
      _loadMore();
    }
  }

  // load next page and append
  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    try {
      final nextPage = _page + 1;
      final resp = await FoodService.fetchFoods(
        primaryCategory: widget.initialCategory ?? "drinks",
        page: nextPage,
        limit: _limit,
      );

      if (resp.foods.isNotEmpty) {
        setState(() {
          _items.addAll(resp.foods);
          _page = resp.page;
          _hasMore = resp.hasMore;
        });
      } else {
        setState(() => _hasMore = false);
      }
    } catch (e) {
      // For load-more errors, show a small toast/snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load more items: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  // retry initial load
  void _retryInitial() {
    setState(() {
      _initialFuture = FoodService.fetchFoods(
        primaryCategory: widget.initialCategory ?? "drinks",
        page: 0,
        limit: _limit,
      );
      // reset local list/state so FutureBuilder will re-bootstrap
      _items.clear();
      _page = 0;
      _hasMore = true;
      _isInitialLoaded = false;
    });
  }

  // navigate to detail (placeholder page provided below)
  void _openDetail(FoodItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailPage(barcode: item.barcode, productName: item.productName)),
    );
  }

  // small skeleton tile used for initial loading
  Widget _skeletonTile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(height: 100, color: Colors.grey.shade200),
          const SizedBox(height: 8),
          Container(height: 12, color: Colors.grey.shade200),
          const SizedBox(height: 6),
          Container(height: 12, width: 80, color: Colors.grey.shade200),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // main appbar
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialCategory != null ? widget.initialCategory! : 'Drinks & Juices'),
        centerTitle: true,
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: FutureBuilder<FoodResponse>(
        future: _initialFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_isInitialLoaded) {
            // show skeleton grid while initial load
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                controller: _scrollController,
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.62,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (_, __) => _skeletonTile(),
              ),
            );
          }

          if (snapshot.hasError && !_isInitialLoaded) {
            // error during initial load
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Failed to load products:\n${snapshot.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: _retryInitial, child: const Text('Retry')),
                ],
              ),
            );
          }

          if (snapshot.hasData && !_isInitialLoaded) {
            // bootstrap initial items from snapshot into local list once
            final resp = snapshot.data!;
            if (_items.isEmpty) {
              _items.addAll(resp.foods);
              _page = resp.page;
              _hasMore = resp.hasMore;
            }
            _isInitialLoaded = true;
          }

          // main content: grid with items
          return RefreshIndicator(
            onRefresh: () async {
              // refresh: reset everything and re-fetch initial
              setState(() {
                _items.clear();
                _page = 0;
                _hasMore = true;
                _isInitialLoaded = false;
                _initialFuture = FoodService.fetchFoods(
                  primaryCategory: widget.initialCategory ?? "drinks",
                  page: 0,
                  limit: _limit,
                );
              });
              await _initialFuture;
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                controller: _scrollController,
                itemCount: _items.length + (_isLoadingMore ? 2 : 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.62,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  if (index < _items.length) {
                    final item = _items[index];
                    return ProductCard(
                      item: item,
                      onTap: () => _openDetail(item),
                    );
                  } else {
                    // loading more skeletons at bottom
                    return _skeletonTile();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Minimal placeholder product detail page so card taps work until you have real page.
class ProductDetailPage extends StatelessWidget {
  final String? barcode;
  final String productName;
  const ProductDetailPage({super.key, required this.barcode, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Center(
        child: Text(
          barcode != null ? 'Product detail for\n$barcode' : 'Product detail',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
