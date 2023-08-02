import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/coupon_model/coupon_model.dart';
import 'package:practise1/list_view_test/widgets/coupons/coupon_detail_widget.dart';

class CouponDisplayContainerWidget extends StatelessWidget {
  final CouponModel couponModel;

  const CouponDisplayContainerWidget({
    super.key,
    required this.couponModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.network(
              couponModel.imageUrl,
              fit: BoxFit.fill,
              height: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
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
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
