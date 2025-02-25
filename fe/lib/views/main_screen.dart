import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _resumeFile;
  String? _fileName;
  bool _isProcessing = false;
  final TextEditingController _jobDescriptionController = TextEditingController();

  Future<void> _pickResume() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _resumeFile = File(result.files.single.path!);
          _fileName = result.files.single.name;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void _processApplication() {
    if (_resumeFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your resume first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate processing
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Application submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Application'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Job Description Container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                 TextField(
                   controller: _jobDescriptionController,
                   minLines: 4,
                   maxLines: 6,

                 )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Resume Upload Container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upload Resume',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Upload Button or File Info
                  _resumeFile == null
                      ? Center(
                          child: ElevatedButton.icon(
                            onPressed: _pickResume,
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Select File'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.description, color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _fileName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _resumeFile = null;
                                    _fileName = null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                  const SizedBox(height: 12),
                  const Text(
                    'Accepted formats: PDF, DOC, DOCX',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Process Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processApplication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isProcessing
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Processing...'),
                        ],
                      )
                    : const Text(
                        'Submit Application',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
