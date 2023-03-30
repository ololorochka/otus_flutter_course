import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otus_food/controllers/camera_controller.dart';
import 'package:otus_food/models/comment.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/screens/camera_screen.dart';
import 'package:otus_food/theme_data.dart';
import 'package:otus_food/settings.dart';
import 'package:otus_food/common.dart' as com;

// Виджет комментариев
class CommentWidget extends StatefulWidget {
  const CommentWidget(this.obj, {super.key});
  final Recipe obj;

  @override
  State<CommentWidget> createState() => _CommentWidget();
}

class _CommentWidget extends State<CommentWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  late CommentList commentList;
  String? tmpPhoto;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
      );
    });
    commentList = CommentList(widget.obj);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[] +
            widget.obj.comments
                .map((comment) => Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          comment.userPic == null
                              ? Icon(
                                  Icons.face,
                                  size: 63,
                                  color: Theme.of(context).colorScheme.neutralColor2,
                                )
                              : CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(Settings.apiUrl + comment.userPic!),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  radius: 27,
                                ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      comment.userName,
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                    Text(
                                      comment.date!,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Theme.of(context).colorScheme.neutralColor3,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  comment.text,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                if (comment.photo != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: comment.isLocal
                                        ? Image(
                                            image: FileImage(
                                              File(comment.photo),
                                            ),
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: Settings.apiUrl + comment.photo,
                                            errorWidget: (context, url, error) => const SizedBox(),
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList() +
            [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        textAlignVertical: TextAlignVertical.top,
                        style: Theme.of(context).textTheme.headline1,
                        decoration: InputDecoration(
                          enabledBorder: getOutlineInputBorder(),
                          focusedBorder: getOutlineInputBorder(),
                          errorBorder: getOutlineInputBorder(),
                          focusedErrorBorder: getOutlineInputBorder(),
                          labelText: 'оставить комментарий',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите текст комментария';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _addComment();
                        },
                      ),
                    ),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          alignment: Alignment.topRight,
                          onPressed: () async {
                            final action = _actionSheet();
                            showCupertinoModalPopup(context: context, builder: (context) => action);
                          },
                        )),
                  ],
                ),
              ),
              if (tmpPhoto != null)
                Image(
                  image: FileImage(
                    File(tmpPhoto!),
                  ),
                  fit: BoxFit.cover,
                ),
            ],
      ),
    );
  }

  // Оформление границ поля ввода комментария
  InputBorder getOutlineInputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          width: 2.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      );

  // Добавление комментария
  _addComment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        Comment comment =
            Comment(recipeId: widget.obj.recipeId, text: _controller.value.text, photo: tmpPhoto, isLocal: true);
        comment.save();
        commentList.add(comment);
        _controller.clear();
        tmpPhoto = null;
      });
      FocusScope.of(context).unfocus();
    }
  }

  // Добавление фото
  _actionSheet() {
    return CupertinoTheme(
      data: CupertinoThemeData(
        primaryColor: Theme.of(context).colorScheme.textColor,
      ),
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Сфотографировать'),
            onPressed: () async {
              Navigator.pop(context, 'Сфотографировать');
              final firstCamera = await AppCameraController().getFirstCamera();

              if (!mounted) return;

              if (firstCamera == null) {
                com.showMessage(context, 'Камера не найдена', isError: true);
              } else {
                final String? result = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CameraScreen(camera: firstCamera)));

                if (result != null && result.isNotEmpty) {
                  setState(() {
                    tmpPhoto = result;
                  });
                }
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Выбрать из галереи'),
            onPressed: () {
              // Пока не реализовываем
              Navigator.pop(context, 'Выбрать из галереи');
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Отмена'),
          onPressed: () {
            Navigator.pop(context, 'Отмена');
          },
        ),
      ),
    );
  }
}
