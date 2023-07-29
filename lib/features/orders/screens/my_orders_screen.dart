import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:disaoled_people/features/orders/screens/edit_order_screen.dart';
import 'package:disaoled_people/features/orders/screens/orders_screen.dart';
import 'package:disaoled_people/features/orders/screens/widgets/order_card.dart';
import 'package:disaoled_people/features/orders/screens/widgets/selected_order_state.dart';
import 'package:disaoled_people/features/orders/services/order_db_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyOrdersScreen extends StatefulWidget {
  static const routeName = '/my-orders';
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  OrderState orderState = OrderState.available;

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
              const AppBarHeader(title: 'طلباتي'),
              sizedBoxLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SelectOrderState(
                    title: 'مسلمة',
                    state: OrderState.unavailable,
                    selected: orderState == OrderState.unavailable,
                    onTap: () {
                      setState(() {
                        orderState = OrderState.unavailable;
                      });
                    },
                  ),
                  SelectOrderState(
                    title: 'قيد التسليم',
                    state: OrderState.inProgress,
                    selected: orderState == OrderState.inProgress,
                    onTap: () {
                      setState(() {
                        orderState = OrderState.inProgress;
                      });
                    },
                  ),
                  SelectOrderState(
                    title: 'العامة',
                    state: OrderState.available,
                    selected: orderState == OrderState.available,
                    onTap: () {
                      setState(() {
                        orderState = OrderState.available;
                      });
                    },
                  )
                ],
              ),
              sizedBoxLarge,
              StreamBuilder<List<OrderModle>>(
                stream: OrderDbService().myOrders(
                  state: orderState,
                ),
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
                        return Slidable(
                            key: Key(order.id),
                            dragStartBehavior: DragStartBehavior.start,
                            useTextDirection: true,
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {}),
                              dragDismissible: false,
                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) async {
                                    await OrderDbService().deleteOrder(order.id);
                                  },
                                  backgroundColor: orange,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'حذف',
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.of(context).pushNamed(EditOrderScreen.routeName, arguments: order);
                                  },
                                  backgroundColor: secondaryColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'تعديل',
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ],
                            ),
                            child: OrderCard(order: order));
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
