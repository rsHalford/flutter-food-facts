import 'dart:async';

//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

//import 'package:FoodFacts/services/admob_service.dart';

import 'package:FoodFacts/widgets/container_widget.dart';
import 'package:FoodFacts/widgets/nutriments_widget.dart';
import 'package:FoodFacts/widgets/titlebar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String barcode = '';
  int barcodeNumber;
  //BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    //FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    //_bannerAd = BannerAd(
    //  adUnitId: AdManager.bannerAdUnitId,
    //  size: AdSize.fullBanner,
    //);
    //_loadBannerAd();
  }

  _scan() async {
    return await FlutterBarcodeScanner.scanBarcode(
            '#0000FF', 'CANCEL', false, ScanMode.BARCODE)
        .then((value) => setState(() => barcode = value));
  }

  Future<void> getProduct() async {
    ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.ENGLISH,
      fields: [
        ProductField.ALL,
      ],
    );
    ProductResult result = await OpenFoodAPIClient.getProduct(configuration);
    if (result.status == 1) {
      print(barcode);
      return result.product;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          shape: ContinuousRectangleBorder(),
          icon: Icon(Icons.qr_code_scanner),
          label: Text('SCAN BARCODE'),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          onPressed: () => _scan(),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              //SizedBox(height: 68),
              TitleBarWidget(),
              FutureBuilder(
                future: getProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ContainerWidget(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${snapshot.data.brands}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data.productName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Barcode: ',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${snapshot.data.barcode}',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ContainerWidget(
                            child: Column(
                              children: <Widget>[
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                                  color: Colors.grey.withOpacity(0.3),
                                  dataLabel: 'Nutrition Facts',
                                  dataLabelSize: 22,
                                  dataLabelWeight: FontWeight.w800,
                                  dataValue: 'per 100 g/ml',
                                  dataValueSize: 18,
                                  dataValueWeight: FontWeight.w800,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                                  color: Colors.white,
                                  dataLabel: 'Energy (kJ)',
                                  dataLabelSize: 18,
                                  dataLabelWeight: FontWeight.w700,
                                  dataValue:
                                      '${snapshot.data.nutriments.energy.toString()} kJ',
                                  dataValueSize: 18,
                                  dataValueWeight: FontWeight.w700,
                                ),
                                Divider(height: 0, thickness: 2),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  color: Colors.white,
                                  dataLabel: 'Energy (kcal)',
                                  dataLabelSize: 18,
                                  dataLabelWeight: FontWeight.w700,
                                  dataValue:
                                      '${snapshot.data.nutriments.energyKcal.toString()} kcal',
                                  dataValueSize: 18,
                                  dataValueWeight: FontWeight.w700,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  color: Colors.orange.withOpacity(0.3),
                                  dataLabel: 'Fat',
                                  dataLabelSize: 18,
                                  dataLabelWeight: FontWeight.w700,
                                  dataValue:
                                      '${snapshot.data.nutriments.fat.toString()} g',
                                  dataValueSize: 18,
                                  dataValueWeight: FontWeight.w700,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                  color: Colors.white,
                                  dataLabel: 'Saturated Fat',
                                  dataLabelSize: 14,
                                  dataLabelWeight: FontWeight.w500,
                                  dataValue:
                                      '${snapshot.data.nutriments.saturatedFat.toString()} g',
                                  dataValueSize: 15,
                                  dataValueWeight: FontWeight.w500,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  color: Colors.blue.withOpacity(0.3),
                                  dataLabel: 'Carbohydrates',
                                  dataLabelSize: 18,
                                  dataLabelWeight: FontWeight.w700,
                                  dataValue:
                                      '${snapshot.data.nutriments.carbohydrates.toString()} g',
                                  dataValueSize: 18,
                                  dataValueWeight: FontWeight.w700,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 3),
                                  color: Colors.white,
                                  dataLabel: 'Sugars',
                                  dataLabelSize: 14,
                                  dataLabelWeight: FontWeight.w500,
                                  dataValue:
                                      '${snapshot.data.nutriments.sugars.toString()} g',
                                  dataValueSize: 15,
                                  dataValueWeight: FontWeight.w500,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(30, 3, 10, 5),
                                  color: Colors.white,
                                  dataLabel: 'Fibre',
                                  dataLabelSize: 14,
                                  dataLabelWeight: FontWeight.w500,
                                  dataValue:
                                      '${snapshot.data.nutriments.fiber.toString()} g',
                                  dataValueSize: 15,
                                  dataValueWeight: FontWeight.w500,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  color: Colors.green.withOpacity(0.3),
                                  dataLabel: 'Protein',
                                  dataLabelSize: 18,
                                  dataLabelWeight: FontWeight.w700,
                                  dataValue:
                                      '${snapshot.data.nutriments.proteins.toString()} g',
                                  dataValueSize: 18,
                                  dataValueWeight: FontWeight.w700,
                                ),
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  color: Colors.white,
                                  dataLabel: 'Salt',
                                  dataLabelSize: 18,
                                  dataLabelWeight: FontWeight.w700,
                                  dataValue:
                                      '${snapshot.data.nutriments.salt.toString()} g',
                                  dataValueSize: 18,
                                  dataValueWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                          ContainerWidget(
                            child: Column(
                              children: <Widget>[
                                NutrimentsWidget(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  color: Colors.grey.withOpacity(0.3),
                                  dataLabel: 'Ingredients',
                                  dataLabelSize: 18,
                                  dataLabelWeight: FontWeight.w800,
                                  dataValue: '',
                                  dataValueSize: 14,
                                  dataValueWeight: FontWeight.w800,
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  child: Text(
                                    '${snapshot.data.ingredientsText}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 70),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ContainerWidget(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Brand',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Name of food item',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Barcode: ',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    TextSpan(
                                      text: '-',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ContainerWidget(
                          child: Column(
                            children: <Widget>[
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                                color: Colors.grey.withOpacity(0.3),
                                dataLabel: 'Nutrition Facts',
                                dataLabelSize: 22,
                                dataLabelWeight: FontWeight.w800,
                                dataValue: 'per 100 g/ml',
                                dataValueSize: 18,
                                dataValueWeight: FontWeight.w800,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                                color: Colors.white,
                                dataLabel: 'Energy (kJ)',
                                dataLabelSize: 18,
                                dataLabelWeight: FontWeight.w700,
                                dataValue: '-',
                                dataValueSize: 18,
                                dataValueWeight: FontWeight.w700,
                              ),
                              Divider(height: 0, thickness: 2),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                color: Colors.white,
                                dataLabel: 'Energy (kcal)',
                                dataLabelSize: 18,
                                dataLabelWeight: FontWeight.w700,
                                dataValue: '-',
                                dataValueSize: 18,
                                dataValueWeight: FontWeight.w700,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                color: Colors.orange.withOpacity(0.3),
                                dataLabel: 'Fat',
                                dataLabelSize: 18,
                                dataLabelWeight: FontWeight.w700,
                                dataValue: '-',
                                dataValueSize: 18,
                                dataValueWeight: FontWeight.w700,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                color: Colors.white,
                                dataLabel: 'Saturated Fat',
                                dataLabelSize: 14,
                                dataLabelWeight: FontWeight.w500,
                                dataValue: '-',
                                dataValueSize: 15,
                                dataValueWeight: FontWeight.w500,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                color: Colors.blue.withOpacity(0.3),
                                dataLabel: 'Carbohydrates',
                                dataLabelSize: 18,
                                dataLabelWeight: FontWeight.w700,
                                dataValue: '-',
                                dataValueSize: 18,
                                dataValueWeight: FontWeight.w700,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(30, 5, 10, 3),
                                color: Colors.white,
                                dataLabel: 'Sugars',
                                dataLabelSize: 14,
                                dataLabelWeight: FontWeight.w500,
                                dataValue: '-',
                                dataValueSize: 15,
                                dataValueWeight: FontWeight.w500,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(30, 3, 10, 5),
                                color: Colors.white,
                                dataLabel: 'Fibre',
                                dataLabelSize: 14,
                                dataLabelWeight: FontWeight.w500,
                                dataValue: '-',
                                dataValueSize: 15,
                                dataValueWeight: FontWeight.w500,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                color: Colors.green.withOpacity(0.3),
                                dataLabel: 'Protein',
                                dataLabelSize: 18,
                                dataLabelWeight: FontWeight.w700,
                                dataValue: '-',
                                dataValueSize: 18,
                                dataValueWeight: FontWeight.w700,
                              ),
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                color: Colors.white,
                                dataLabel: 'Salt',
                                dataLabelSize: 18,
                                dataLabelWeight: FontWeight.w700,
                                dataValue: '-',
                                dataValueSize: 18,
                                dataValueWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                        ContainerWidget(
                          child: Column(
                            children: <Widget>[
                              NutrimentsWidget(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                color: Colors.grey.withOpacity(0.3),
                                dataLabel: 'Ingredients',
                                dataLabelSize: 18,
                                dataLabelWeight: FontWeight.w800,
                                dataValue: '',
                                dataValueSize: 14,
                                dataValueWeight: FontWeight.w800,
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //void _loadBannerAd() {
  //  _bannerAd
  //    ..load()
  //    ..show(anchorType: AnchorType.top, anchorOffset: 24);
  //}

  //@override
  //void dispose() {
  //  _bannerAd?.dispose();
  //  super.dispose();
  //}
}
