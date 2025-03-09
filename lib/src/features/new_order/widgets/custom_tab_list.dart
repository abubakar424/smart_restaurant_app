// order_list_widget.dart

import 'package:flutter/material.dart';
import 'package:restaurant_app/src/features/new_order/widgets/custom_new_order_card.dart';
import 'package:restaurant_app/src/model/order/customer_order_model.dart';
import 'package:restaurant_app/src/model/order/customer_rider_model.dart';

class OrderListWidget extends StatelessWidget {
  final OrderStatus currentStatus;
  final OrderStatus? nextStatus;
  final List<CustomerOrder> orders;

  const OrderListWidget({
    Key? key,
    required this.currentStatus,
    required this.nextStatus,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomerOrder> filteredOrders =
        orders.where((order) => order.status == currentStatus).toList();

    if (filteredOrders.isEmpty) {
      String statusText = _getOrderStatusText(currentStatus);
      return Center(child: Text('No $statusText Orders'));
    }

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return OrderWidget(
          order: order,
          onAction: () {
            // If the nextStatus is not null, move the order to the next status
            if (nextStatus != null) {
              order.status = nextStatus!;
            }
          },
        );
      },
    );
  }

  // Helper method to get the string representation of the OrderStatus
  String _getOrderStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.newOrder:
        return "New";
      case OrderStatus.preparing:
        return "Preparing";
      case OrderStatus.completed:
        return "Completed";
      case OrderStatus.cancelled:
        return "Cancelled";
      default:
        return "Unknown";
    }
  }
}
