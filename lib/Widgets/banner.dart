import 'package:baby_hub_store_app/Utils/colors.dart';
import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.23,
      width: size.width,
      color: bannerColor,
      child: Padding(
        padding: EdgeInsets.only(left: 27),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NEW ARRIVALS",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -2),
                ),
                Row(
                  children: [
                    Text(
                      "5",
                      style: TextStyle(
                          fontSize: 40,
                          height: 0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -3),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "%",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "OFF",
                          style: TextStyle(
                              fontSize: 10,
                              letterSpacing: -1.5,
                              fontWeight: FontWeight.bold,
                              height: 0.6),
                        )
                      ],
                    )
                  ],
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.black,
                  child: Text(
                    "SHOP NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "/banner.png",
                height: size.height * 0.80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
