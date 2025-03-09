import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/dummy_data/order_list.dart';
import 'package:restaurant_app/src/features/new_order/widgets/custom_tab_list.dart';
import 'package:restaurant_app/src/model/order/customer_rider_model.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({super.key});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.bgImage,
                  color: Colors.black,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: width * 0.02),
                              Text(
                                "Orders",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // TabBar design inside the Stack
                          TabBar(
                            controller: _tabController,
                            labelColor: AppColors.blue,
                            unselectedLabelColor: AppColors.lightText,
                            indicatorColor: AppColors.blue,
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            tabs: const [
                              Tab(text: "Order"),
                              Tab(text: "Preparing"),
                              Tab(text: "Completed"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    OrderListWidget(
                      currentStatus: OrderStatus.newOrder,
                      nextStatus: OrderStatus.preparing,
                      orders: dummyOrders,
                    ), // New Orders
                    OrderListWidget(
                      currentStatus: OrderStatus.preparing,
                      nextStatus: OrderStatus.completed,
                      orders: dummyOrders,
                    ), // Preparing Orders
                    OrderListWidget(
                      currentStatus: OrderStatus.completed,
                      nextStatus: null,
                      orders: dummyOrders,
                    ), // Completed Orders
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
