

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/widgets/custom_back_button.dart';
import 'package:restaurant_app/src/dummy_data/order_list.dart'; // Import the dummy orders data
import 'package:restaurant_app/src/features/history/widgets/history_order_card.dart';
import 'package:restaurant_app/src/model/order/customer_order_model.dart';
import 'package:restaurant_app/src/model/order/customer_rider_model.dart';
import 'package:restaurant_app/src/router/routes.dart'; // Import the model for completed orders

List<CustomerOrder> completedOrders = dummyOrders
    .where((order) => order.status == OrderStatus.completed)
    .toList();

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Filter completed orders from dummy data
    List<CustomerOrder> completedOrders = dummyOrders
        .where((order) => order.status == OrderStatus.completed)
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.bgImage,
                  color: Colors.black,
                  height: 100,
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
                      child: Row(
                        children: [
                          CustomBackButton(),
                          SizedBox(width: width * 0.02),
                          Text(
                            "Orders History",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: completedOrders.length,
                itemBuilder: (context, index) {
                  final order = completedOrders[index];
                  return OrderCard(
                    order: order, 
                    onTap: (){

                     context.pushNamed(AppRoute.orderDetailPage, extra: {'order': order, 'onAction': () {             },});

                    });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
