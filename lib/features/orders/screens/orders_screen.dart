import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:disaoled_people/features/orders/screens/widgets/order_card.dart';
import 'package:disaoled_people/features/orders/screens/widgets/select_order_type.dart';
import 'package:disaoled_people/features/orders/services/order_db_services.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderType orderType = OrderType.benefit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg.png',
                ),
                fit: BoxFit.cover),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              const AppBarHeader(title: 'الطلبات'),
              sizedBoxLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SelectOrderType(
                    title: 'تبرع',
                    type: OrderType.donation,
                    selected: orderType == OrderType.donation,
                    onTap: () {
                      setState(() {
                        orderType = OrderType.donation;
                      });
                    },
                  ),
                  SelectOrderType(
                    title: 'استفادة',
                    type: OrderType.benefit,
                    selected: orderType == OrderType.benefit,
                    onTap: () {
                      setState(() {
                        orderType = OrderType.benefit;
                      });
                    },
                  )
                ],
              ),
              sizedBoxLarge,
              StreamBuilder<List<OrderModle>>(
                stream: OrderDbService().getOrderByCategory(orderType: orderType),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CustomProgress(),
                    );
                  }
                  if (snapshot.hasError) {
                    snapshot.error.toString;
                    return Center(
                        child: Text(
                      snapshot.error.toString(),
                      // 'حدث خطأ اثناء جلب البيانات',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ));
                  }
                  if (snapshot.hasData) {
                    final orders = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return OrderCard(order: order);
                      },
                    );
                  } else {
                    return const Center(child: Text('لا يوجد طلبات'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: primaryColor),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: primaryColor),
        ));
  }
}
