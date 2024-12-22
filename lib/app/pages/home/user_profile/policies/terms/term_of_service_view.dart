import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/user_profile/policies/terms/term_of_service_controller.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;

import '../../../../../utils/module_utils.dart';

class TermsAndConditionsView extends clean.View {
  TermsAndConditionsView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TermsAndConditionsView();
  }
}

class _TermsAndConditionsView extends BaseStateView<TermsAndConditionsView,
    TermsAndConditionsController> {
  _TermsAndConditionsView() : super(TermsAndConditionsController());
  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "Terms and Conditions";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    TermsAndConditionsController _controller =
        controller as TermsAndConditionsController;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            toText("termOfServiceWelcome"),
            textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
          ),
          const SizedBox(height: 20.0),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _controller.isExpanded[index] = isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      toText("termOfServiceCookie"),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[0],
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toText("termOfServiceCookieDescription"),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceCookieNote"),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding:  const EdgeInsets.all(16.0),
                    child: Text(
                      toText("termOfServiceLicense"),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[1],
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toText("termOfServiceLicenseDescription"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceBeginDate"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceGranting"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      toText("termOfServiceHyperlinksTitle"),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[2],
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toText("termOfServiceHyperlinksListOne"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceHyperlinksListTwo"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceHyperlinksListThree"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceHyperlinksListFour"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceHyperlinksListFive"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceHyperlinksListSix"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        toText("termOfServiceHyperlinksListSeven"),
                        textAlign: TextAlign.justify, style: const TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
