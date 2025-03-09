import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/constants/app_colors.dart';
import '../../../model/order/customer_order_model.dart';
import '../../../model/order/customer_rider_model.dart';
import '../../../router/routes.dart';

class OrderWidget extends StatelessWidget {
  final CustomerOrder order;
  final VoidCallback onAction;

  const OrderWidget({Key? key, required this.order, required this.onAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to order detail screen when the card is tapped
        context.pushNamed(AppRoute.orderDetailPage,
            extra: {'order': order, 'onAction': onAction});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the card

          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: AppColors.lightText.withOpacity(0.3), // Slight shadow
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Number and Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0,
                        ),
                  ),
                  _buildStatusBadge(order.status),
                ],
              ),
              const SizedBox(height: 3),

              // Address
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Address: ${order.address}',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.lightText,
                                letterSpacing: 0,
                              ),
                      overflow: TextOverflow
                          .ellipsis, // This will add the ellipsis (...) if the text is too long
                      maxLines: 1, // Ensures it stays on one line
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Total Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0,
                        ),
                  ),
                  Text(
                    '\$${order.totalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.green,
                          letterSpacing: 0,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Status Badge Builder
  Widget _buildStatusBadge(OrderStatus status) {
    Color badgeColor;
    String statusText;

    switch (status) {
      case OrderStatus.newOrder:
        badgeColor = AppColors.red;
        statusText = 'New';
        break;
      case OrderStatus.preparing:
        badgeColor = AppColors.orangeBg;
        statusText = 'Preparing';
        break;
      case OrderStatus.completed:
        badgeColor = AppColors.green;
        statusText = 'Completed';
        break;
      case OrderStatus.cancelled:
        badgeColor = AppColors.red;
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
