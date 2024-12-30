import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ReviewScreen extends StatelessWidget {
  final Map<String, String> studentDetails;
  final File studentPhoto;
  final File birthCertificate;
  final Function(Map<String, String>, File, File) onEdit;

  ReviewScreen({
    required this.studentDetails,
    required this.studentPhoto,
    required this.birthCertificate,
    required this.onEdit,
  });

  Future<void> generatePDF(BuildContext context) async {
    final pdf = pw.Document();

    // Add Page 1: Student Photo, Details, and Table
    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Title Section
              pw.Center(
                child: pw.Row(children: [
                  pw.Text(
                    'Bright Future School',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 32,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromInt(0xFF6A1B9A),
                    ),
                  ),
                  pw.SizedBox(width: 150),
                  pw.Image(
                    pw.MemoryImage(studentPhoto.readAsBytesSync()),
                    height: 100,
                    width: 100,
                  ),
                ]),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 1, color: PdfColor.fromInt(0xFF6A1B9A)),
              pw.SizedBox(height: 20),
              pw.Text(
                "Admission Details",
                style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromInt(0xFF6A1B9A)),
              ),
              // Student Photo Section with Size Adjustments

              pw.SizedBox(height: 20),
              pw.Text(
                "Dear Sir/Madam,",
                style:
                    pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "I wish to admit my child for the academic year commencing 2025-2026",
                style:
                    pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
              ),

              pw.SizedBox(height: 4),

              // Table Section with Wrapping Text
              pw.Text(
                'Student Details:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromInt(0xFF6A1B9A),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                columnWidths: {
                  0: pw.FlexColumnWidth(2),
                  1: pw.FlexColumnWidth(3),
                },
                border: pw.TableBorder.all(
                  color: PdfColors.grey,
                  width: 0.5,
                ),
                children: [
                  for (var entry in studentDetails.entries)
                    if (entry.key != 'Student Photo' &&
                        entry.key !=
                            'Admission Number') // Exclude Admission Number
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(
                              entry.key,
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(
                              entry.value,
                              style: pw.TextStyle(fontSize: 14),
                              softWrap: true, // Allow text wrapping
                            ),
                          ),
                        ],
                      ),
                ],
              ),

              pw.SizedBox(height: 20),
              pw.Divider(thickness: 1, color: PdfColors.grey),
            ],
          );
        },
      ),
    );
    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Table Section with Wrapping Text

              pw.SizedBox(height: 25),
              pw.Text(
                "I solemnly declare that the above particulars are true and correct. I have read the prospectus, and if my child is admitted, I shall abide by the regulations of the school.",
                style: pw.TextStyle(fontSize: 15),
              ),
              pw.SizedBox(height: 65),
              pw.Row(
                children: [
                  pw.Text(
                    "Father's Signature................",
                    style: pw.TextStyle(fontSize: 15),
                  ),
                  pw.SizedBox(height: 5),
                  pw.SizedBox(width: 130),
                  pw.Text(
                    "Mother's Signature................",
                    style: pw.TextStyle(fontSize: 15),
                  ),
                  pw.SizedBox(height: 5),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Date :",
                style: pw.TextStyle(fontSize: 15),
              ),
              pw.SizedBox(height: 100),
              pw.Center(
                child: pw.Text(
                  "FOR OFFICE USE ONLY",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 40),
              pw.Text(
                "Admitted to ......................on.................................Admission No...................................",
                style: pw.TextStyle(fontSize: 15),
              ),
              pw.SizedBox(height: 80),
              pw.Text(
                "PRINCIPAL",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 60),
              pw.Divider(thickness: 1, color: PdfColors.grey),
            ],
          );
        },
      ),
    );
    // Add Page 2: Full-Page Birth Certificate
    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              pw.MemoryImage(birthCertificate.readAsBytesSync()),
              fit: pw.BoxFit.contain,
            ),
          );
        },
      ),
    );

    // Save PDF to Temporary Directory
    final output = await getTemporaryDirectory();
    final filePath = "${output.path}/admission_details.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    await openPDF(filePath, context);
  }

  Future<void> openPDF(String filePath, BuildContext context) async {
    final result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to open PDF: ${result.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 200, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 199, 82, 238),
        title: Text(
          'Admission Review',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.orange, Colors.pink, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'Bright Future School',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Column(
                  children: [
                    Image.file(
                      studentPhoto,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Class: ${studentDetails['Class for Admission']}',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(width: 150),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.file(
                      birthCertificate,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Certificate',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Admission Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: studentDetails.entries.map((entry) {
                  if (entry.key == 'Student Photo' ||
                      entry.key == 'Admission Number') {
                    return Container(); // Skip Admission Number and Photo
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key}: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Edit Details'),
                ),
                ElevatedButton(
                  onPressed: () => generatePDF(context),
                  child: Text('Generate PDF'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
