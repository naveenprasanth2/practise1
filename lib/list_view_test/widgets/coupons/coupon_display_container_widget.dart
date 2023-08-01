import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/widgets/coupons/coupon_detail_widget.dart';

class CouponDisplayContainerWidget extends StatelessWidget {
  const CouponDisplayContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(context: context, builder: (BuildContext context){
          return CouponDetailWidget();
        });
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
              "https://as1.ftcdn.net/v2/jpg/00/98/97/68/1000_F_98976874_2oufUlOChMQ1WwlkNyHkeOAHM6B0cRDV.jpg",
              fit: BoxFit.fill,
              height: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Up to 10% off",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Use code TFYTF10",
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
