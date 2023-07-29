import 'package:disaoled_people/config/extensions/stream_sdk.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:disaoled_people/features/chat/chat_screen.dart';
import 'package:flutter/material.dart';

import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class StreamChatService {
  Future<void> createChannel(BuildContext context, String userId) async {
    final core = StreamChatCore.of(context);
    final channel = core.client.channel('messaging', extraData: {
      'members': [
        core.currentUser!.id,
        userId,
      ]
    });
    await channel.watch();

    Navigator.of(context).push(
      ChatScreen.routeWithChannel(channel),
    );
  }

  updateUser(UserModle user, BuildContext context) async {
    try {
      await StreamChatCore.of(context)
          .client
          .updateUser(User(id: context.currentUser!.id, name: user.name, image: user.image));
    } catch (e) {
      print(e);
    }
  }
}
