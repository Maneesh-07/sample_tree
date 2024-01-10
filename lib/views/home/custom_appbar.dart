import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String tittle;
  const CustomAppBar({
    super.key,
    bool? isScrolled,
    this.details = false,
    required this.tittle,
  }) : _isScrolled = isScrolled;

  final bool? _isScrolled;
  final details;
  final Size preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(tittle)],
        ),
      ),
    );
  }
}
