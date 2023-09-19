import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/coupon_model/coupon_model.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/providers/coupon_state_provider.dart';
import 'package:provider/provider.dart';

class CouponDetailWidget extends StatelessWidget {
  final CouponModel couponModel;

  const CouponDetailWidget({super.key, required this.couponModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Image.network(
                            couponModel.imageUrl,
                            fit: BoxFit.fill,
                            height: 40,
                          ),
                          Text(couponModel.couponCode),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                Text(couponModel.description),
                Text(couponModel.shortDescription),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Consumer<CouponStateProvider>(
                builder: (context, couponStateProvider, _) {
                  return InkWell(
                    onTap: () async {
                      Provider.of<CalculationProvider>(context, listen: false)
                          .setDiscounts(couponModel.percentage);
                      if (couponStateProvider.couponCode !=
                          couponModel.couponCode) {
                        couponStateProvider.setCouponCode(couponModel);
                      } else {
                        couponStateProvider.removeCouponCode();
                        Provider.of<CalculationProvider>(context, listen: false)
                            .resetDiscounts();
                      }
                      await Future.delayed(const Duration(milliseconds: 200))
                          .then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: couponStateProvider.couponCode !=
                                couponModel.couponCode
                            ? Colors.red.shade600
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          couponStateProvider.couponCode !=
                                  couponModel.couponCode
                              ? "Apply Now"
                              : "Remove",
                          style: TextStyle(
                            color: couponStateProvider.couponCode !=
                                    couponModel.couponCode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
