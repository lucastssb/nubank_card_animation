import 'package:flutter/material.dart';
import 'dart:math' as math;

class CreditCard extends StatelessWidget {
  final String name;
  final String cardNumber;
  final String memberSince;
  final String validThru;
  final int securityCode;
  final double angle;
  const CreditCard(
      {Key? key,
      required this.name,
      required this.cardNumber,
      required this.validThru,
      required this.securityCode,
      required this.angle,
      required this.memberSince})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: angle),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double val, __) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(val),
          child: Card(
            elevation: 10,
            color: Colors.transparent,
            child: (val >= math.pi / 2)
                ? CardBack(
                    cardNumber: cardNumber,
                    memberSince: memberSince,
                    validThru: validThru,
                    securityCode: securityCode)
                : CardFront(name: name),
          ),
        );
      },
    );
  }
}

class CardFront extends StatelessWidget {
  final String name;
  const CardFront({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.4, 0.8, 1],
          colors: [
            Color.fromRGBO(130, 10, 209, 1),
            Color.fromRGBO(174, 78, 237, 1),
            Color.fromRGBO(174, 78, 237, 0.85),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 30,
            bottom: 30,
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Image.asset('assets/images/nubank_logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          Positioned(
            left: 35,
            top: 65,
            child: Row(
              children: [
                Container(
                  width: 50,
                  child: Image.asset('assets/images/chip.png'),
                  margin: const EdgeInsets.only(right: 10),
                ),
                Transform.rotate(
                  angle: 90 * math.pi / 180,
                  child: const Icon(
                    Icons.wifi,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 30,
            top: 30,
            child: SizedBox(
              width: 60,
              child: Image.asset('assets/images/mastercard_logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  final String cardNumber;
  final String validThru;
  final int securityCode;
  final String memberSince;
  const CardBack({
    Key? key,
    required this.cardNumber,
    required this.validThru,
    required this.securityCode,
    required this.memberSince,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(math.pi),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: 360,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.4, 0.8, 1],
                colors: [
                  Color.fromRGBO(130, 10, 209, 1),
                  Color.fromRGBO(174, 78, 237, 1),
                  Color.fromRGBO(174, 78, 237, 0.85),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 20,
                  child: Container(
                    height: 60,
                    width: constraints.maxWidth,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: SizedBox(
                    width: 60,
                    child: Image.asset('assets/images/cirrus_logo.png'),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardNumber,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(children: [
                          SizedBox(
                            width: 60,
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                const Flexible(
                                  flex: 2,
                                  child: Text(
                                    'MEMBER SINCE',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 4),
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Text(
                                    memberSince,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 70,
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                const Flexible(
                                  flex: 2,
                                  child: Text(
                                    'VALID THRU',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 4),
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Text(
                                    validThru,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.only(left: 10),
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                const Flexible(
                                  flex: 2,
                                  child: Text(
                                    'SECURITY CODE',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 4),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    securityCode == 0
                                        ? ''
                                        : securityCode.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
