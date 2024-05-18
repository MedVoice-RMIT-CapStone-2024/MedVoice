import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/user_profile/policies/terms/term_of_service_controller.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;

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
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to MedVoice Terms and Conditions! These terms and conditions list the rules and regulations for using the MedVoice application. By accessing this application, we understand that you accept these terms and conditions. Do not continue to use MedVoice if you do not agree to all of the terms and conditions stated on this page.',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20.0),
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
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Cookie',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[0],
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The application uses cookies to help personalize your online experience. By accessing MedVoice, you have agreed to use the required cookies. A cookie is a text file that the application server places on your hard disk. Cookies are not used to run programs or transmit viruses to your computer. The cookie is uniquely assigned to you and can only be read by the application server in the domain that issued the cookie to you. We may use cookies to collect, store, and track information for statistical or marketing purposes to operate our application. You can accept or decline Cookies. Some cookies are essential for the operation of our application. These cookies do not require your consent as they are always active.',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Please note that by accepting the required Cookies, you also accept third-party Cookies, which may be used through services provided by third parties if you use those services on our application, such as third-party-provided video display windows integrated into our application.',
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'License',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[1],
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unless otherwise specified, MedVoice and/or its licensors own the intellectual property rights for all materials on MedVoice. All intellectual property rights are reserved. You may access this section from MedVoice for your own personal use, subject to the restrictions set out in these terms and conditions.',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'This agreement will begin on the date of this contract. Portions of this application provide users with the opportunity to post and exchange opinions and information in certain areas of the application. MedVoice does not filter, edit, publish, or review comments before they appear on the application. Comments do not reflect the views and opinions of MedVoice, its agents, and/or affiliates. Comments reflect the views and opinions of the person who posts the comments and their opinions. To the extent permitted by applicable law, MedVoice shall not be liable for comments or any legal liability, damage, or costs arising from and/or attributable to any use and/or posting and/or appearance of comments on this application. MedVoice has the right to monitor all comments and remove any comments that may be deemed inappropriate, offensive, or in violation of these terms and conditions.',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Hereby, you grant MedVoice a non-exclusive license to use, reproduce, edit, and authorize others to use, reproduce, and edit any and all of your comments in any and all forms, formats, or media.',
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Hyperlinks to Our Content',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[2],
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The following organizations may link to our application without prior written approval:',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'These organizations may link to our home page, to publications, or to other application information so long as the link:',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'We may consider and approve other link requests from the following types of organizations:',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'We will approve link requests from these organizations if we decide that:',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'These organizations may link to our home page so long as the link:',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'If you are one of the organizations listed in paragraph 2 above and are interested in linking to our application, you must inform us by sending an e-mail to MedVoice. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response. Approved organizations may hyperlink to our application as follows:',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "No use of MedVoice's logo or other artwork will be allowed for linking absent a trademark license agreement.",
                        textAlign: TextAlign.justify,
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
