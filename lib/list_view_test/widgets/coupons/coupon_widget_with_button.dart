import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/coupon_model/coupon_model.dart';
import 'package:practise1/list_view_test/widgets/coupons/coupon_detail_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/calculation_provider.dart';
import '../../providers/coupon_state_provider.dart';
import '../../utils/dart_helper/sizebox_helper.dart';

class CouponWidgetWithButton extends StatelessWidget {
  final CouponModel couponModel;

  const CouponWidgetWithButton({
    super.key,
    required this.couponModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return CouponDetailWidget(
                couponModel: couponModel,
              );
            },
          );
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.network(
                couponModel.imageUrl,
                fit: BoxFit.fill,
                height: 40,
              ),
            SizedBoxHelper.sizedBox_10,
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              couponModel.shortDescription,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              couponModel.couponCode,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        Consumer<CouponStateProvider>(
                          builder: (context, couponStateProvider, _) {
                            return InkWell(
                              onTap: () async {
                                Provider.of<CalculationProvider>(context, listen: false)
                                    .setDiscounts(couponModel.percentage);
                                if (couponStateProvider.couponCode !=
                                    couponModel.couponCode) {
                                  couponStateProvider
                                      .setCouponCode(couponModel.couponCode);
                                  await Future.delayed(const Duration(milliseconds: 200))
                                      .then((value) => Navigator.pop(context));
                                } else {
                                  couponStateProvider.removeCouponCode();
                                  Provider.of<CalculationProvider>(context, listen: false)
                                      .resetDiscounts();
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 100,
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
                                        ? "Apply"
                                        : "Remove",
                                    style: TextStyle(
                                      color: couponStateProvider.couponCode !=
                                          couponModel.couponCode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(
                      couponModel.description,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600,
                          fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
