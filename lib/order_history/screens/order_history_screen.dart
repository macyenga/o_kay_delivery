import 'package:flutter/material.dart';
import 'package:o_kay_delivery/home/controllers/order_controller.dart';
import 'package:o_kay_delivery/home/widgets/order_card.dart';
import 'package:o_kay_delivery/models/order.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const String routeName = '/order-history-screen';
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<Order> orders = [];

  getData() async {
    OrderController orderController = OrderController();
    orders = await orderController.fetchOrderHistory();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Delivery History',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getData();
        },
        child: orders.isEmpty
            ? const SizedBox()
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderCard(
                    order: order,
                    pickUpOrder: () {},
                    isHistoryView: true,
                  );
                }),
      ),
    );
  }
}
