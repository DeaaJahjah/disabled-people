import 'package:card_swiper/card_swiper.dart';
import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/features/chat/services/stream_chat_service.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:disaoled_people/features/orders/screens/widgets/order_header.dart';
import 'package:disaoled_people/features/orders/services/order_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({super.key, required this.animation, required this.order});

  OrderModle order;
  final AnimationController animation;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          )),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderHeader(order: widget.order),
            sizedBoxMedium,
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 170.0)),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    widget.order.images![index],
                    fit: BoxFit.contain,
                  );
                },
                autoplay: true,
                // indicatorLayout: PageIndicatorLayout.SLIDE,
                containerHeight: 200,
                // loop: true,
                pagination: const SwiperPagination(margin: EdgeInsets.all(5.0)),
                itemCount: widget.order.images!.length,
                itemWidth: 300.0,
                itemHeight: 200.0,
                // layout: SwiperLayout.DEFAULT,
              ),
            ),
            sizedBoxMedium,
            Text(widget.order.description, style: Theme.of(context).textTheme.bodyMedium),
            sizedBoxMedium,
            if (FirebaseAuth.instance.currentUser!.uid != widget.order.ownerId)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedGradientButton(
                      onPressed: () async {
                        await StreamChatService().createChannel(context, widget.order.ownerId);
                      },
                      text: 'تواصل معنا'),
                ],
              ),
            !isLoading &&
                    widget.order.orderState == OrderState.inProgress &&
                    FirebaseAuth.instance.currentUser!.uid == widget.order.ownerId
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedGradientButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final newOrder = widget.order
                                .copyWith(orderState: OrderState.available, deliverdTime: null, reciverId: null);
                            await OrderDbService().updateOrder(newOrder);

                            OrderDbService().myOrders(state: OrderState.available);
                            setState(() {
                              isLoading = false;
                            });
                            widget.animation.reverse();
                          },
                          text: 'الغاء الاتفاق'),
                      ElevatedGradientButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final newOrder = widget.order
                                .copyWith(orderState: OrderState.unavailable, deliverdTime: null, reciverId: null);
                            await OrderDbService().updateOrder(newOrder);

                            OrderDbService().myOrders(state: OrderState.unavailable);
                            setState(() {
                              isLoading = false;
                            });
                            widget.animation.reverse();
                          },
                          text: 'تم التسليم'),
                    ],
                  )
                : const SizedBox.shrink(),
            // Align(
            //   alignment: Alignment.center,
            //   child:
            // ),
            sizedBoxLarge
          ],
        ),
      ),
    );
  }
}
