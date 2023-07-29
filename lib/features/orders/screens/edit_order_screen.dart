import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/features/auth/screens/selecte_account_type_screen.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:disaoled_people/features/orders/screens/complete_edit_order.dart';
import 'package:flutter/material.dart';

class EditOrderScreen extends StatefulWidget {
  static const routeName = '/edit-order';

  const EditOrderScreen({super.key});

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  final types = ['تبرع', 'استفادة'];
  int selectedType = -1;
  OrderType orderType = OrderType.donation;
  @override
  Widget build(BuildContext context) {
    OrderModle order = ModalRoute.of(context)!.settings.arguments as OrderModle;

    orderType = order.orderType;
    selectedType = orderType == OrderType.donation ? 1 : 2;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('اختر نوع الطلب', style: Theme.of(context).textTheme.headlineLarge),
                sizedBoxLarge,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        primaryColor,
                        secondaryColor,
                      ],
                    ),
                  ),
                  child: Column(children: [
                    SelectTypeWidget(
                      title: types[0],
                      isSelected: 1 == selectedType,
                      onTap: () {
                        setState(() {});
                        selectedType = 1;
                        orderType = OrderType.donation;
                      },
                    ),
                    SelectTypeWidget(
                      title: types[1],
                      isSelected: 2 == selectedType,
                      onTap: () {
                        setState(() {});
                        selectedType = 2;
                        orderType = OrderType.benefit;
                      },
                    ),
                  ]),
                ),
                ElevatedGradientButton(
                    onPressed: () {
                      if (selectedType != -1) {
                        order = order.copyWith(orderType: orderType);
                        Navigator.of(context).pushNamed(CompleteEditOrderScreen.routeName, arguments: order);
                        return;
                      }
                      showErrorSnackBar(context, 'الرجاء تحديد نوع');
                    },
                    text: 'التالي')
              ],
            )),
      ),
    );
  }
}
