import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/get_coin_controller.dart';

class GetCoinView extends GetView<GetCoinController> {
  const GetCoinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetCoinView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GetCoinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
