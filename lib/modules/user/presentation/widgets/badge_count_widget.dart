import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeCountWidget extends StatefulWidget {
  const BadgeCountWidget({Key? key}) : super(key: key);

  @override
  _BadgeCountWidgetState createState() => _BadgeCountWidgetState();
}

class _BadgeCountWidgetState extends State<BadgeCountWidget> {
  int _badgeCount = 2;

  @override
  void initState() {
    super.initState();
    _loadBadgeCount();
  }

  _loadBadgeCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _badgeCount = prefs.getInt('badge_count') ?? 0;
    });
  }

  // Update the badge count (called when a new notification is received)
  _updateBadgeCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('badge_count', count);

    setState(() {
      _badgeCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _updateBadgeCount(0);
            context.push(Routes.notification);
          },
          child: SvgPicture.asset(
            ConstImages.notification,
            height: 24,
            width: 24,
          ),
        ),
        if (_badgeCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              height: 10,
              width: 10,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),

            ),
          ),
      ],
    );
  }
}
