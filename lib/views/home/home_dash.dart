import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/views/home/card.dart';
import 'package:sample_tree/views/home/custom_appbar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: scaffoldBgColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: scaffoldBgColor,
              actions: [
                CustomAppBar(isScrolled: _isScrolled,tittle: '',),
              ],
            ),
            body: ListView(
              controller: _scrollController,
              children: const [
                Responsive(
                  mobile: CategoryCard(),
                  desktop: CategoryCard(),
                  mobileLarge: CategoryCard(),
                  tablet: CategoryCard(),
                ),
            
                // const RecentView(),
                // OfferZone(title: 'Offers for travel info'),
                // OfferZone(
                //   title: 'Where will you find joy?',
                //   subtitle: 'see more',
                //   isSub: true,
                // ),
                // PopularActivity(
                //   title: 'Popular activities',
                // )
              ],
            ),
          ),
        ));
  }
}
