import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nubank_card/src/widgets/credit_card.dart';
import 'package:nubank_card/src/models/card_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode _nameFocusNode;
  late FocusNode _cardNumberFocusNode;
  late FocusNode _securityCodeFocusNode;
  late FocusNode _memberSinceFocusNode;
  late FocusNode _validThruFocusNode;

  double angle = 0;
  bool isFront = true;

  var maskCardNumberFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
  var maskMemberSinceFormatter =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  var maskValidThruFormatter =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});

  final _card = CardModel(
    name: '',
    cardNumber: '',
    securityCode: 0,
    memberSince: '',
    validThru: '',
  );

  void _flipCard() {
    setState(() {
      angle = (angle + math.pi) % (math.pi * 2);
      isFront = !isFront;
    });
  }

  @override
  void initState() {
    super.initState();

    _nameFocusNode = FocusNode();
    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus && !isFront) {
        _flipCard();
      }
    });

    _cardNumberFocusNode = FocusNode();
    _cardNumberFocusNode.addListener(() {
      if (_cardNumberFocusNode.hasFocus && isFront) {
        _flipCard();
      }
    });

    _securityCodeFocusNode = FocusNode();
    _securityCodeFocusNode.addListener(() {
      if (_securityCodeFocusNode.hasFocus && isFront) {
        _flipCard();
      }
    });

    _memberSinceFocusNode = FocusNode();
    _memberSinceFocusNode.addListener(() {
      if (_memberSinceFocusNode.hasFocus && isFront) {
        _flipCard();
      }
    });

    _validThruFocusNode = FocusNode();
    _validThruFocusNode.addListener(() {
      if (_validThruFocusNode.hasFocus && isFront) {
        _flipCard();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _nameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(174, 78, 237, 0.85),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: GestureDetector(
                    onTap: _flipCard,
                    child: CreditCard(
                      name: _card.name!,
                      cardNumber: _card.cardNumber!,
                      validThru: _card.validThru!,
                      securityCode: _card.securityCode!,
                      memberSince: _card.memberSince!,
                      angle: angle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25),
                          ],
                          keyboardType: TextInputType.name,
                          focusNode: _nameFocusNode,
                          onChanged: (value) {
                            setState(() {
                              _card.name = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name on card',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    maskCardNumberFormatter,
                                  ],
                                  focusNode: _cardNumberFocusNode,
                                  onChanged: (value) {
                                    setState(() {
                                      _card.cardNumber = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Card Number',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3)
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      _card.securityCode = int.parse(value);
                                    });
                                  },
                                  focusNode: _securityCodeFocusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'CVV',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: 3,
                            child: TextFormField(
                              focusNode: _memberSinceFocusNode,
                              inputFormatters: [
                                maskMemberSinceFormatter,
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _card.memberSince = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Member Since',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(),
                          ),
                          Flexible(
                            flex: 3,
                            child: TextFormField(
                              focusNode: _validThruFocusNode,
                              inputFormatters: [
                                maskValidThruFormatter,
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _card.validThru = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Valid Thru',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(130, 10, 209, 1),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text('Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
