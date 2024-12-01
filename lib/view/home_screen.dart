import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:ecommerce_test/view/cart_page.dart';
import 'package:ecommerce_test/view/category_page.dart';
import 'package:ecommerce_test/view/checkout.dart';
import 'package:ecommerce_test/view/home_page.dart';
import 'package:ecommerce_test/view_model/cart_pageviewmodel.dart';
import 'package:ecommerce_test/view_model/category_pageviewmodel.dart';
import 'package:ecommerce_test/view_model/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 1;
  late PageController pageController;

  final ProductViewModel productViewModel = ProductViewModel();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    final categoryPageViewModel =
        CategoryPageViewModel(categoryPageName: "Category");

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.category, color: Colors.deepPurple),
          Icon(Icons.home, color: Colors.deepPurple),
          Icon(Icons.shopping_cart, color: Colors.deepPurple),
        ],
        inactiveIcons: const [
          Text("Category"),
          Text("Home"),
          Text("Cart"),
        ],
        color: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
            pageController.jumpToPage(_tabIndex);
          });
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.deepPurple,
        elevation: 10,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        children: [
          CategoryPage(categoryPageViewModel: categoryPageViewModel),
          HomePage(productViewModel: productViewModel),
          CartPage(cartPageViewModel: Provider.of<CartPageViewModel>(context)),
        ],
      ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const CheckoutScreen()));
          },
          child: const Icon(
            Icons.shopping_basket_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
