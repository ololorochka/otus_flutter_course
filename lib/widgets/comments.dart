import 'package:flutter/material.dart';
import 'package:otus_food/models/comment.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/theme_data.dart';

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
            widget.obj.comments // пока так
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
                                  backgroundImage: AssetImage(comment.userPic!),
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
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    minLines: 2,
                    maxLines: 10,
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
                  ),
                ),
              ),
              TextButton(
                onPressed: _addComment,
                child: const Text('Отправить'),
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

  // Пока так / можно выделить в отдельный контроллер
  _addComment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        Comment comment = Comment(recipeId: widget.obj.recipeId!, text: _controller.value.text);
        comment.save();
        commentList.add(comment);
        _controller.clear();
      });
    }
  }
}
