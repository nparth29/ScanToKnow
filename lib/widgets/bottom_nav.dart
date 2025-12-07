import 'package:flutter/material.dart';

/// BottomNavBar (programmatic icons, no image assets)
/// - Simple, plain icons so it won't match the sample exactly.
/// - Selected item shows a subtle circular background.
/// - Fires onTabSelected(index) when tapped.
class BottomNavBar extends StatefulWidget {
  final ValueChanged<int>? onTabSelected;
  final int initialIndex;

  const BottomNavBar({super.key, this.onTabSelected, this.initialIndex = 0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  // Keep the mapping here so it's easy to change icons or labels.
  final List<_NavItem> _items = const [
    _NavItem(label: 'Home', icon: Icons.home_rounded),
    _NavItem(label: 'Search', icon: Icons.search_rounded),
    _NavItem(label: 'Scan', icon: Icons.qr_code_scanner_rounded),
    _NavItem(label: 'Categories', icon: Icons.grid_view_rounded),
    _NavItem(label: 'Upload', icon: Icons.cloud_upload_rounded),
    _NavItem(label: 'Smart Read', icon: Icons.document_scanner_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onTap(int index) {
    if (_selectedIndex == index) {
      // Already selected — still provide feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_items[index].label} tapped (placeholder)')),
      );
      return;
    }

    setState(() => _selectedIndex = index);
    widget.onTabSelected?.call(index);

    // Default placeholder action:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_items[index].label} tapped (placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final Color selectedColor = const Color(0xFF6B4EFF); // distinct purple-ish color (not sample)
    final Color inactiveColor = Colors.grey.shade600;

    return Material(
      elevation: 10,
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(
            top: 8,
            bottom: bottomPadding > 0 ? bottomPadding : 10,
            left: 6,
            right: 6,
          ),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final bool selected = index == _selectedIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => _onTap(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // icon container with circular selected background
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 44,
                        height: 44,
                        decoration: selected
                            ? BoxDecoration(
                          color: selectedColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        )
                            : null,
                        alignment: Alignment.center,
                        child: Icon(
                          item.icon,
                          size: 22,
                          color: selected ? selectedColor : inactiveColor,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // label
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          color: selected ? selectedColor : inactiveColor,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem({required this.label, required this.icon});
}
