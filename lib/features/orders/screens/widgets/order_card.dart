import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/features/chat/services/stream_chat_service.dart';
import 'package:disaoled_people/features/chat/widgets/slide_dialog.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:disaoled_people/features/orders/screens/widgets/order_details.dart';
import 'package:disaoled_people/features/orders/screens/widgets/order_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final OrderModle order;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> with TickerProviderStateMixin {
  late AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          showbottomSheetDialog(
              context: context, widget: OrderDetails(order: widget.order, animation: animation), animation: animation);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor,
                  secondaryColor,
                ],
              )),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrderHeader(order: widget.order),
                      sizedBoxMedium,
                      ReadMoreText(
                        widget.order.description,
                        trimLines: 2,
                        colorClickableText: const Color.fromARGB(255, 30, 233, 105),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' عرض المزيد ',
                        trimExpandedText: ' عرض اقل',
                        style: Theme.of(context).textTheme.bodySmall,
                        lessStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 30, 233, 105)),
                        moreStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 30, 233, 105)),
                      ),
                      sizedBoxMedium,
                      if (FirebaseAuth.instance.currentUser!.uid != widget.order.ownerId)
                        ElevatedGradientButton(
                            onPressed: () async {
                              await StreamChatService().createChannel(context, widget.order.ownerId);
                            },
                            text: 'تواصل معنا'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: widget.order.images!.isNotEmpty
                      ? Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.order.images![0],
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: widget.order.images!.length > 1
                              ? Center(
                                  child: CircleAvatar(
                                      backgroundColor: primaryColor.withOpacity(0.9),
                                      child: Text('+${widget.order.images!.length - 1}')))
                              : const SizedBox.shrink(),
                        )
                      : const SizedBox.shrink(),
                )
              ]),
        ),
      ),
    );
  }
}
