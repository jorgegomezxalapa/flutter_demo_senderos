import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

class CargarDocumentoWidget extends StatefulWidget{
  final String? titleText;
  const CargarDocumentoWidget({super.key, this.titleText});

  @override
  State<CargarDocumentoWidget> createState() => _CargarDocumentoWidgetState();
}

class _CargarDocumentoWidgetState extends State<CargarDocumentoWidget> {

  String? _fileName;
  String? _fileRoute;
  String? _fileExtension;
  IconData? iconData;
  FilePickerResult? documento;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    documento = result;
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _fileExtension = result.files.single.extension;
        _fileRoute = result.files.single.path;
        switch (_fileExtension) {
          case null:
            iconData = Icons.upload_file;
            break;
          case 'pdf':
            iconData = Icons.picture_as_pdf;
            break;
          case 'jpg':
          case 'jpeg':
          case 'png':
            iconData = Icons.image;
            break;
          default:
            iconData = Icons.file_present_rounded;
        }
      });
    }
  }

  void _openFile() async {
    await OpenFile.open(_fileRoute);
  }

  void _resetFile() {
    setState(() {
      _fileName = null;
      _fileExtension = null;
      _fileRoute = null;
      iconData = Icons.upload_file;
      documento = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleText ?? 'Documento',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            fontSize: 12,
          ),
        ),
        _fileName != null
            ? Row(
          children: [
            Padding(
              padding:
              const EdgeInsets.fromLTRB(
                  0, 8, 8, 8),
              child: GestureDetector(
                  onTap: _openFile,
                  child: Icon(iconData),
              ),
            ),
            GestureDetector(
              onTap: _openFile,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Text(_fileName!),
              ),
            ),
            GestureDetector(
              onTap: _resetFile,
                child: const Icon(Icons.highlight_remove),
            ),
          ],
        )
            : GestureDetector(
              onTap: _pickFile,
              child: Row(
          children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 8, 8, 8),
                child: Icon(Icons.upload_file),
              ),
              Text("Cargar documento firmado")
          ],
        ),
            ),
        if( _fileName == null ) const Text('Documento sin firmar'),
      ],
    );
  }
}