import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';

import '../../authentication/domain/document.dart';


final myDocumentsProvider =
    StateNotifierProvider<MyDocumentsProvider, List<DocumentStateModel>>((ref) {
  return MyDocumentsProvider();
});

class MyDocumentsProvider extends StateNotifier<List<DocumentStateModel>> {
  MyDocumentsProvider() : super([]);
  void deleteAllDocuments() {
    state = [];
  }

  void addDocument(DocumentStateModel document) {
    state = [...state, document];
  }

  void updateDocument(DocumentStateModel documentModel) {
    state = state.map((doc) {
      if (doc.id == documentModel.id) {
        return documentModel;
      } else {
        return doc;
      }
    }).toList();
  }

  void downloadFile(ParseFileBase? parseFileBase) async {
    try {
      BotToast.showLoading();
      final downloadDirectory = await getExternalStorageDirectory();
      if (parseFileBase?.url != null) {
        await FlutterDownloader.enqueue(
          url: parseFileBase!.url!,
          headers: {},
          savedDir: downloadDirectory!.path,
          saveInPublicStorage: true,
          showNotification: true,
          openFileFromNotification: true,
        );
        BotToast.closeAllLoading();
      }
      BotToast.closeAllLoading();
    } catch (e) {
      throw Exception(e);
    }
  }

  void removeFile(ParseFileBase? parseFileBase) async {
    parseFileBase?.delete;
    final item = state
        .where((element) => element.document?.parseFileBase == parseFileBase)
        .first;
    state = List.from(state)..remove(item);
  }

  Future<void> uploadFileFromPlatform(dynamic file, String? description,
      {Document? document}) async {
    if (document == null) {
      bool isXFile = file is XFile;
      final bytes = isXFile ? await file.readAsBytes() : file.bytes;
      final sizes = isXFile ? await file.length() : file.size;
      ParseFileBase? parseFile;
      if (kIsWeb) {
        parseFile = ParseWebFile(bytes, name: file.name);
      } else {
        parseFile = ParseFile(File(file.path!));
      }
      if (sizes > 2000000) {
        addDocument(DocumentStateModel(
            id: file.path,
            document: Document(
                parseFileBase: parseFile,
                description: description ?? '',
                size: sizes),
            error: 'The file is too large to upload.'.i18n,
            currentCount: 0));
      } else {
        addDocument(DocumentStateModel(
            id: file.path,
            document: Document(
                size: sizes, parseFileBase: parseFile, description: ''),
            currentCount: 0));
        await parseFile.upload(progressCallback: (i, j) {
          final progress = i / j.toDouble();
          updateDocument(DocumentStateModel(
              id: file.path,
              document: Document(
                  size: sizes,
                  parseFileBase: parseFile,
                  description: description ?? ''),
              currentCount: progress));
        });
      }
    } else {
      if (state.any((element) => element.id == document.objectId)) {
        BotToast.showText(text: 'This file already uploaded'.i18n);
      } else {
        addDocument(DocumentStateModel(
            id: document.objectId,
            document: Document(
                size: document.size,
                description: document.description,
                parseFileBase: document.parseFileBase),
            currentCount: 1,
            error: null));
      }
    }
  }
}

class DocumentStateModel {
  final Document? document;
  final String? id;
  String? error;
  double? currentCount;
  DocumentStateModel(
      {required this.id,
      required this.document,
      this.error,
      this.currentCount});
}
