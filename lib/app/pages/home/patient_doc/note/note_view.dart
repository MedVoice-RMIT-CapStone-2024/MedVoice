import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_controller.dart';
import 'package:med_voice/app/pages/home/patient_doc/nurse_note/nurse_note_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

class NoteView extends clean.View {
  const NoteView({Key? key, required this.items}) : super(key: key);
  final Map<String, dynamic> items;
  @override
  State<StatefulWidget> createState() {
    return _NoteViewState();
  }
}

class _NoteViewState extends BaseStateView<NoteView, NoteController> {
  _NoteViewState() : super(NoteController());

  TextStyle _customTextStyle({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
  }) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 14,
      fontFamily: 'Poppins',
    );
  }

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "voice00${widget.items['id']}";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    NoteController _controller = controller as NoteController;
    Map<String, dynamic> items = widget.items;

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(toSize(16.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: toSize(20.0)),

                _buildRow('Age', items['age'], 36.0),
                _buildRow('Gender', items['gender'], 36.0),
                _buildRow('Diagnosis', items['diagnosis'], 20.0),
                _buildRow('Occupation status', items['occupationStatus'], 20.0),
                SizedBox(height: toSize(20.0)),
                _buildRow('Voice Handicap Index (VHI) Score', items['vhiScore'],
                    25.0),
                _buildRow('Reflux Symptom Index (RSI) Score', items['rsiScore'],
                    25.0),
                SizedBox(height: toSize(20.0)),
                _buildRow('Smoker', items['smoker'], 31.0),
                _buildRow('Number of cigarettes smoked per day',
                    items['cigarettesPerDay'], 20.0),
                SizedBox(height: toSize(20.0)),
                _buildRow(
                    'Alcohol consumption', items['alcoholConsumption'], 20.0),
                _buildRow(
                    'Number of glasses containing alcoholic \n beverage drinked in a day',
                    items['alcoholPerDay'],
                    10.0),
                _buildRow("Amount of water's litres drink every day",
                    items['waterIntake'], 20.0),
                SizedBox(height: toSize(20.0)),
                _buildRow(
                    'Carbonated beverages', items['carbonatedBeverages'], 20.0),
                _buildRow('Amount of glasses drinked in a day',
                    items['carbonatedPerDay'], 20.0),
                SizedBox(height: toSize(20.0)),
                // Another section
                Row(
                  children: [
                    const Text(
                      'Eating Habit',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const VerticalDivider(),
                    Container(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ],
                ),
                SizedBox(height: toSize(10.0)),
                _buildRow('Coffee', items['coffee'], 20),
                _buildRow('Amount of glasses drinked in a day',
                    items['coffeePerDay'], 20),
                SizedBox(height: toSize(20.0)),
                _buildRow('Tomatoes', items['tomatoes'], 20),
                SizedBox(height: toSize(20.0)),
                _buildRow('Chocolate', items['chocolate'], 20),
                _buildRow(
                    'Number of glasses containing alcoholic \n beverage drinked in a day',
                    items['chocolatePerDay'],
                    20),
                SizedBox(height: toSize(20.0)),
                _buildRow('Chocolate', items['chocolate'], 20),
                _buildRow('Gramme of chocolate eaten in a day',
                    items['chocolatePerDay'], 20),
                SizedBox(height: toSize(20.0)),
                _buildRow('Soft cheese', items['softCheese'], 20),
                _buildRow('Gramme of soft cheese eaten in a day',
                    items['softCheesePerDay'], 20),
                SizedBox(height: toSize(20.0)),
                _buildRow('Citrus fruits', items['citrusFruits'], 20),
                _buildRow('Gramme of citrus fruits eaten in a day',
                    items['citrusPerDay'], 20),
                SizedBox(height: toSize(20.0)),
              ],
            )));
  }

  Widget _buildRow(String label, dynamic value, double maxLines) {
    return Row(
      children: [
        Text(
          label,
          style: _customTextStyle(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        SizedBox(width: toSize(maxLines)),
        Text(
          value.toString(),
          style: _customTextStyle(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
