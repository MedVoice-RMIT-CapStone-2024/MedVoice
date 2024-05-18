import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/patient_doc/note/note_view.dart';
import 'package:med_voice/app/pages/home/patient_doc/nurse_note/nurse_note_controller.dart';
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
  List<Map<String, dynamic>> _items = [];

  Future<void> loadNurseNote() async {
    String jsonString =
        await rootBundle.loadString('assets/json/nurse_note.json');
    List<dynamic> data = jsonDecode(jsonString);

    setState(() {
      _items = data.cast<Map<String, dynamic>>();
      print('..items: $_items');
    });
  }

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
    return "Note List";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    NurseNoteController _controller = controller as NurseNoteController;

    return Padding(
      padding: EdgeInsets.all(toSize(16.0)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _items.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : ListView.builder(
                    itemExtent: 60.0,
                    reverse: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = _items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                          title: Text(
                            int.parse(item['id']) > 9
                                ? "voice 0${item['id']}"
                                : "voice 00${item['id']}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.w300,
                              fontSize: toSize(16),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          onTap: () {
                            // Handle item click here
                            Map<String, dynamic> selectedData =
                                _items.firstWhere(
                                    (element) => element['id'] == item['id']);
                            // Display the details of the selected item
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NoteView(items: selectedData),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
            ElevatedButton(onPressed: loadNurseNote, child: Text('Load Data')),
          ],
        ),
      ),
    );
  }
}
