import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({
    super.key,
    required this.order,
  });

  final OrderModle order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          order.ownerPic != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(order.ownerPic!),
                )
              : const SizedBox(
                  height: 30,
                  width: 30,
                ),
          const SizedBox(
            width: 8,
          ),
          Column(
            children: [
              Text(order.ownerName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white, fontWeight: FontWeight.bold)),
              Text(order.location, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white)),
            ],
          )
        ],
      ),
    );
  }
}
