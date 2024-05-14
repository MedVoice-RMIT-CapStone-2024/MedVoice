import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/user_profile/nurse_note/nurse_note_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

class NurseNoteView extends clean.View {
  NurseNoteView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NurseNoteViewState();
  }
}

class _NurseNoteViewState
    extends BaseStateView<NurseNoteView, NurseNoteController> {
  _NurseNoteViewState() : super(NurseNoteController());

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
    return "voice001";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    NurseNoteController _controller = controller as NurseNoteController;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(toSize(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Age', '32', 56.0),
            _buildRow('Gender', 'Male', 36.0),
            _buildRow('Diagnosis', 'hyperkinetic dysphonia', 20.0),
            _buildRow('Occupation status', 'Researcher', 20.0),
            SizedBox(height: toSize(20.0)),
            _buildRow('Voice Handicap Index (VHI) Score', '15', 25.0),
            _buildRow('Reflux Symptom Index (RSI) Score', '5', 25.0),
            SizedBox(height: toSize(20.0)),
            _buildRow('Smoker', 'No', 31.0),
            _buildRow('Number of cigarettes smoked per day', 'NU', 20.0),
            SizedBox(height: toSize(20.0)),
            _buildRow('Alcohol consumption', 'casual drinker', 20.0),
            _buildRow(
                'Number of glasses containing alcoholic \n beverage drinked in a day',
                '5',
                10.0),
            _buildRow("Amount of water's litres drink every day", '1.5', 20.0),
            SizedBox(height: toSize(20.0)),
            _buildRow('Carbonated beverages', 'No', 20.0),
            _buildRow('Amount of glasses drinked in a day', 'NU', 20.0),
            SizedBox(height: toSize(20.0)),
            //Another section
            Row(
              children: [
                const Text('Eating Habit',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    )),
                const VerticalDivider(),
                Container(
                  height: 1.0,
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(height: toSize(10.0)),
            _buildRow('Coffee', 'almost always', 20),
            _buildRow('Amount of glasses drinked in a day', 'NU', 20),
            SizedBox(height: toSize(20.0)),
            _buildRow('Tomatoes', 'sometimes', 20),
            SizedBox(height: toSize(20.0)),
            _buildRow('Chocolate', 'almost never', 20),
            _buildRow(
                'Number of glasses containing alcoholic \n beverage drinked in a day',
                'NU',
                20),
            SizedBox(height: toSize(20.0)),
            _buildRow('Chocolate', 'sometimes', 20),
            _buildRow('Gramme of chocolate eaten in a day', 'NU', 20),
            SizedBox(height: toSize(20.0)),
            _buildRow('Soft cheese', 'sometimes', 20),
            _buildRow('Gramme of soft cheese eaten in a day', 'NU', 20),
            SizedBox(height: toSize(20.0)),
            _buildRow('Citrus fruits', 'sometimes', 20),
            _buildRow('Gramme of citrus fruits eaten in a day', 'NU', 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, double maxLines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: _customTextStyle(
                  fontWeight: FontWeight.w400, color: Colors.black),
            ),
            SizedBox(width: toSize(maxLines)),
            Text(
              value,
              style: _customTextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
        SizedBox(height: toSize(10.0)),
      ],
    );
  }
}
