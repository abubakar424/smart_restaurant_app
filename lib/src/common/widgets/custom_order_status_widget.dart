import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/global_variables.dart';
import 'package:restaurant_app/src/model/order_status_model.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderStatusModel orderStatus;

  const OrderStatusWidget({Key? key, required this.orderStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusTextColor;
    Color statusContainerColor;

    // Determine colors based on status
    switch (orderStatus.status) {
      case 'Received':
        statusTextColor = AppColors.green;
        statusContainerColor = AppColors.green.withOpacity(0.1);
        break;
      case 'Preparing':
        statusTextColor = colorScheme(context).primary;
        statusContainerColor = colorScheme(context).primary.withOpacity(0.1);
        break;
      case 'Completed':
        statusTextColor = colorScheme(context).secondary;
        statusContainerColor = colorScheme(context).secondary.withOpacity(0.1);
        break;
      case 'Delivered':
        statusTextColor = colorScheme(context).onSurface;
        statusContainerColor = colorScheme(context).onSurface.withOpacity(0.1);
        break;
      default:
        statusTextColor = colorScheme(context).outline;
        statusContainerColor = colorScheme(context).outline.withOpacity(0.1);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: colorScheme(context).outline),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderStatus.orderNumber,
            style: textTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme(context).outline,
                ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderStatus.orderDetail,
                style: textTheme(context)
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              Text(
                orderStatus.estimatedTime,
                style: textTheme(context).bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme(context).outline,
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: statusContainerColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  orderStatus.status,
                  style: textTheme(context).bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: statusTextColor,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
