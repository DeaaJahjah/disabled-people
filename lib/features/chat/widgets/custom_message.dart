import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/extensions/stream_sdk.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/features/orders/services/order_db_services.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomMessage extends StatelessWidget {
  final Message message;
  const CustomMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final messageStatus = message.extraData['status'];
    final bool myMessage = message.user?.id == context.currentUser?.id;
    print(message.extraData);
    return Align(
      alignment: myMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: myMessage
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: myMessage
                    ? [AppColors.secondary, const Color.fromARGB(255, 90, 136, 237)]
                    : [primaryColor, secondaryColor],
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: myMessage ? const EdgeInsets.fromLTRB(60, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 60, 5),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(message.text.toString()),
              sizedBoxMedium,
              Text('${message.extraData['location'].toString()} الموقع'),
              sizedBoxMedium,
              Text('${Jiffy(message.extraData['deliverd_date']).yMEd} تاريخ التسليم'),
              if (messageStatus == 'panding')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!myMessage)
                      ElevatedButton(
                        onPressed: () async {
                          message.extraData['status'] = 'aproved';
                          await StreamChannel.of(context).channel.updateMessage(message);

                          print(message.extraData['order_id']);
                          await OrderDbService().updateOrderFileds({
                            'id': message.extraData['order_id'],
                            'order_state': OrderState.inProgress.name,
                            'deliverd_date': message.extraData['deliverd_time'],
                            'reciver_id': message.user!.id
                          });
                        },
                        child: const Text('قبول'),
                      ),
                    ElevatedButton(
                        onPressed: () async {
                          message.extraData['status'] = 'rejected';
                          await StreamChannel.of(context).channel.updateMessage(message);
                        },
                        child: Text(!myMessage ? 'رفض' : 'الغاء')),
                  ],
                ),
              if (messageStatus != 'panding')
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 28, 28, 28)),
                  child: Text(messageStatus == 'rejected' ? 'ملغي' : 'تم القبول'),
                )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              Jiffy(message.createdAt.toLocal()).jm,
              style: const TextStyle(
                color: AppColors.textFaded,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
