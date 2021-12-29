import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/models/travelspot.dart';

class PopularPlacesView extends StatelessWidget {
  const PopularPlacesView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (kDefaultPadding / 414.0) * size.width,
          ),
          child: Row(
            children: [
              Text(
                "Right now at spark",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (16 / 414.0) * size.width,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text("See All"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: (20 / 815.0) * size.height,
        ),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                travelSpots.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    left: (kDefaultPadding / 414.0) * size.width,
                  ),
                  child: SizedBox(
                    width: (145 / 414.0) * size.width,
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.15,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(
                                      travelSpots.elementAt(index).image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Container(
                          width: (145 / 414.0) * size.width,
                          padding: EdgeInsets.all(
                            (kDefaultPadding / 414.0) * size.width,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [kDefualtShadow],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                travelSpots.elementAt(index).name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: (10 / 815.0) * size.height,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: (kDefaultPadding / 414.0) * size.width,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
