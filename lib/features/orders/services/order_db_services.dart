import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/features/home/home_screen.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:disaoled_people/features/orders/screens/my_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  addOrder(OrderModle order, BuildContext context) async {
    try {
      await _db.collection('orders').add(order.toJson());
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);

      showSuccessSnackBar(context, 'تم انشاء الطلب بنجاح');
    } on FirebaseException catch (e) {
      showErrorSnackBar(context, e.message.toString());
    }
  }

  List<OrderModle> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return OrderModle.fromFirestore(doc);
    }).toList();
  }

  Stream<List<OrderModle>> getOrderByCategory({required OrderType orderType}) {
    return _db
        .collection('orders')
        .where('order_type', isEqualTo: orderType.name)
        .where('order_state', isEqualTo: OrderState.available.name)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Future<OrderModle?> getOrderPostById(String id) async {
    var doc = await _db.collection('orders').doc(id).get();
    if (doc.exists) {
      return OrderModle.fromFirestore(doc);
    }
    return null;
  }

  Stream<List<OrderModle>> myOrders({required OrderState state}) {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    return _db
        .collection('orders')
        .where('owner_id', isEqualTo: uid)
        .where('order_state', isEqualTo: state.name)
        .snapshots()
        .map(_orderListFromSnapshot);

    // var query = await _db
    //     .collection('orders')
    //     .where(
    //       'owner_id',
    //       isEqualTo: uid,
    //     )
    //     .get();

    // for (var doc in query.docs) {
    //   final order = OrderModle.fromFirestore(doc);
    //   if (order.orderState == state) {
    //     orders.add(order);
    //   }
    // }
    // return orders;
  }

  Future<List<OrderModle>> myFutureOrders() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    List<OrderModle> orders = [];
    var query = await _db
        .collection('orders')
        .where('owner_id', isEqualTo: uid)
        .where('order_state', isEqualTo: OrderState.available.name)
        .get();

    for (var doc in query.docs) {
      orders.add(OrderModle.fromFirestore(doc));
    }
    return orders;
  }

  Future<void> deleteOrder(String id) async {
    await _db.collection('orders').doc(id).delete();
  }

  //update post
  Future<void> updateOrder(OrderModle order) async {
    try {
      await _db.collection('orders').doc(order.id).update(order.toJson());
      // showSuccessSnackBar(context, 'تم تعديل الطلب بنجاح');
    } on FirebaseException {
      // showErrorSnackBar(context, e.message.toString());
    }
  }

  Future<void> updateOrderFileds(Map<String, dynamic> order) async {
    try {
      await _db.collection('orders').doc(order['id']).update(order);
      // showSuccessSnackBar(context, 'تم تعديل الطلب بنجاح');
    } on FirebaseException {
      // showErrorSnackBar(context, e.message.toString());
    }
  }

  Future<void> updateMyOrder(OrderModle order, context) async {
    try {
      await _db.collection('orders').doc(order.id).update(order.toJson());
      showSuccessSnackBar(context, 'تم تعديل الطلب بنجاح');
      Navigator.of(context).pushNamedAndRemoveUntil(MyOrdersScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      showErrorSnackBar(context, e.message.toString());
    }
  }
}
