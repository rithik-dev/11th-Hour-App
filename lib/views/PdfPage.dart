import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PdfPage extends StatefulWidget {
  static const id = '/pdfPage';
  final String resourceUrl;
  PdfPage({this.resourceUrl});
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PDFDocument doc;
  void getPdf() async {
    doc = await PDFDocument.fromURL(widget.resourceUrl);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("Resources"),
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeBoilerPlate.id);
            },
            child: Icon(UiIcons.home),
          )
        ],
        centerTitle: true,
      ),
      body: Center(
          child: doc == null
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: doc)),
    );
  }
}
