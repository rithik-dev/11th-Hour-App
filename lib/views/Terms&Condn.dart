import 'package:eleventh_hour/components/CollapsingTile.dart';
import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TermsAndCondition extends StatelessWidget {
  static const id = '/terms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("Terms And Conditions"),
        centerTitle: true,
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeBoilerPlate.id, (route) => false);
            },
            child: Icon(UiIcons.home),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          CollapsingTile(
            question: "Copyright",
            answer:
                "All rights, title, and interest in the copyright of all works (logo, platform design, app, and HTML template) are assigned to our organization. Any infringement of the aforementioned rights is a punishable offense under Copyright Laws.",
          ),
          CollapsingTile(
            question: "Collection of Private Information",
            answer:
                "There are specific laws that govern the collection of Private Identifiable Information (PII), such as IP addresses, surfing history, user-data, etc. We do not monitor/collect data and use analytics to manipulate consumer behavior in any manner",
          ),
          CollapsingTile(
            question: "Content Liability",
            answer:
                "We’d like to state that our team isn’t responsible for the content that is being put on the platform and the app. No link(s) that is obscene, or criminal, or infringes any third party rights should appear on the platform.",
          ),
          CollapsingTile(
            question: "Reservation of Rights",
            answer:
                "We hold every authority to demand that all references or some relevant access to our website be withheld from you. You accept that all ties to our platform should be disabled immediately upon request. These terms and conditions may be changed at any time, along with its linking policy. You consent to be bound to and obey these linking terms and conditions by continuously linking to our website.",
          ),
          CollapsingTile(
            question: "Blacklisting of courses from our platform",
            answer:
                "We will consider all requests to blacklist any course that you find irrelevant or indecent for any reason, but we are not liable to or so or to connect with you directly. Neither are we responsible for the incorrect courses on the platform nor do we vouch for its completeness or accuracy.",
          ),
          CollapsingTile(
            question: "Ownership",
            answer:
                "All information on or made accessible via the Platform, including, without limitation, all headers of pages, photographs, graphics, audio, video and multimedia clips, interfaces, and text collectively “resources”, is the property of its content creators. The content is licensed under the copyright, trademark, and other laws of India and other countries, and all copyright in the collection, organization, agreement, and improvement of the material is owned by 11th Hour. Everything found on the webpage shall be deemed as granting any authorization or right to use, by implication or otherwise, any trademark, including registered trademarks of the 11th Hour, except with the express written consent of the 11th Hour or any other party which may hold ownership thereto.",
          ),
          CollapsingTile(
            question: "Confidentiality",
            answer:
                "As a result of the provision of platform services to customers, and whether due to any deliberate or negligent act or omission, we can reveal our non-public records, business strategies,  source code, management styles, day-to-day business operations, capabilities, systems, branding, management styles, capabilities, systems, current and future strategies, Users hereby acknowledge and accept that such information shall be our sole and exclusive intellectual property and proprietary information and shall be confidential. Users consent to use our Confidential Information only for the limited purposes allowed by these terms of use. Any disclosure of our Confidential Information to a third party specifically including a direct competitor is strictly prohibited and will be vigorously challenged in a court of law. The termination of these Terms shall withstand all obligations found herein. In addition, users agree that our data is proprietary, confidential, and highly important to us and that any disclosure of our confidential information will materially harm us. Users accept and agree that monetary damages are an inadequate redress for the violation of this duty of confidentiality and that we are entitled to injunctive relief.",
          ),
          CollapsingTile(
            question: "Privacy",
            answer:
                "This states that organizations are forbidden from transmitting or revealing individual information without the individual's consent to reveal that information. However, it is up to the individual to claim that wrongful disclosure has happened because this social network demands permission when a third-party application demands information from the user. Since there is so much information that can be deducted from other items, such as social security numbers, which can be used for identity theft. The details allegedly included access via a digital interface to full name, email address, and links, which was used to steal user 'identities'. Many social networking platforms are dedicated to ensuring that their services are used as safely as possible. However, due to the high content of personal information put on social networking sites as well as the opportunity to hide behind social predators.",
          ),
          CollapsingTile(
            question: "Changes and Adjustments to our terms and conditions",
            answer:
                "We can often adjust the terms of this Agreement (including those documents incorporated herein by reference) without notice to you. After any such update, your use of the platform constitutes your willingness to obey and be bound by such modifications. For this reason, we invite you, whenever you visit the Site, to review this Agreement (and all documents incorporated by reference, as set out below). In this Agreement, we will include a \"last updated\" date as seen on the Website.",
          ),
        ],
      ),
    );
  }
}
