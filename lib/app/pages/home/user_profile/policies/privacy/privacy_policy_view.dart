import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/home/user_profile/policies/privacy/privacy_policy_controller.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

class PrivacyPolicyView extends clean.View {
  PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrivacyPolicyView();
  }
}

class _PrivacyPolicyView
    extends BaseStateView<PrivacyPolicyView, PrivacyPolicyController> {
  _PrivacyPolicyView() : super(PrivacyPolicyController());

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "Privacy Policy";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    PrivacyPolicyController _controller = controller as PrivacyPolicyController;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
            textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Rubik'),
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
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Interpretation and Definitions',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[0],
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.\n\n'
                    'For the purposes of this Privacy Policy:\n'
                    '• Account means a unique account created for You to access our Service or parts of our Service.\n'
                    '• Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\n'
                    '• Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Greenify.\n'
                    '• Cookies are small files that are placed on Your computer, mobile device or any other device by a website, containing the details of Your browsing history on that website among its many uses.\n'
                    '• Country refers to: Vietnam\n'
                    '• Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.\n'
                    '• Personal Data is any information that relates to an identified or identifiable individual.\n'
                    '• Service refers to the Website.\n'
                    '• Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.\n'
                    '• Third-party Social Media Service refers to any website or any social network website through which a User can log in or create an account to use the Service.\n'
                    '• Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).\n'
                    '• Website refers to Greenify, accessible from http://www.green-ify.life\n'
                    '• You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                    textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Rubik')
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Collecting and Using Your Personal Data',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[1],
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Types of Data Collected\n\n'
                    'Personal Data\n'
                    'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:\n'
                    '• Email address\n'
                    '• First name and last name\n'
                    '• Phone number\n'
                    '• Address, State, Province, ZIP/Postal code, City\n'
                    '• Usage Data\n\n'
                    'Usage Data\n'
                    'Usage Data is collected automatically when using the Service.\n\n'
                    'Usage Data may include information such as Your Device\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n\n'
                    'When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n\n'
                    'We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.',
                    textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Rubik'),
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Security of Your Personal Data',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[2],
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.',
                    textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Rubik'),
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Links to Other Websites',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[3],
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party\'s site. We strongly advise You to review the Privacy Policy of every site You visit. We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
                    textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Rubik'),
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Changes to this Privacy Policy',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[4],
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page. We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
                    textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Rubik'),
                  ),
                ),
              ),
              ExpansionPanel(
                backgroundColor: Theme.of(context).colorScheme.background,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'
                      ),
                    ),
                  );
                },
                isExpanded: _controller.isExpanded[5],
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'If you have any questions about this Privacy Policy, You can contact us:\n\n'
                    '• By email: support@medvoice.com\n'
                    '• By visiting this page on our website: www.medvoice.com/contact',
                    textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Rubik'),
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
