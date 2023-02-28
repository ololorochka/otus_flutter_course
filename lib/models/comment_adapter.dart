import 'package:hive/hive.dart';
import 'package:otus_food/models/comment.dart';

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  int get typeId => 129;

  @override
  Comment read(BinaryReader reader) {
    return Comment(
      commentId: reader.read(),
      recipeId: reader.readInt(),
      date: reader.read(),
      text: reader.readString(),
      userId: reader.read(),
      userName: reader.read(),
      userPic: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer.write(obj.commentId);
    writer.writeInt(obj.recipeId);
    writer.write(obj.date);
    writer.writeString(obj.text);
    writer.write(obj.userId);
    writer.write(obj.userName);
    writer.write(obj.userPic);
  }
}
