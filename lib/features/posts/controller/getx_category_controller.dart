import 'package:get/get_state_manager/get_state_manager.dart';

class PostCategoryController extends GetxController {
  bool isGeneralPost = false;
  bool isNewsPost = false;
  bool isIdeasPost = false;
  bool isSignalPost = false;
  bool isMemePost = false;

  bool showReplyToCommentBox = false;
  bool showRepliesToComment = false;

  onGeneralPost() {
    isGeneralPost = true;
    isNewsPost = false;
    isIdeasPost = false;
    isSignalPost = false;
    isMemePost = false;
    update();
  }

  onNewsPost() {
    isGeneralPost = false;
    isNewsPost = true;
    isIdeasPost = false;
    isSignalPost = false;
    isMemePost = false;
    update();
  }

  onIdeasPost() {
    isGeneralPost = false;
    isNewsPost = false;
    isIdeasPost = true;
    isSignalPost = false;
    isMemePost = false;
    update();
  }

  onSignalPost() {
    isGeneralPost = false;
    isNewsPost = false;
    isIdeasPost = false;
    isSignalPost = true;
    isMemePost = false;
    update();
  }

  onMemePost() {
    isGeneralPost = false;
    isNewsPost = false;
    isIdeasPost = false;
    isSignalPost = false;
    isMemePost = true;
    update();
  }

  clearCategories() {
    isGeneralPost = false;
    isNewsPost = false;
    isIdeasPost = false;
    isSignalPost = false;
    isMemePost = false;
    update();
  }

  toggleReplyToCommentBox() {
    showReplyToCommentBox = !showReplyToCommentBox;
    update();
  }

  toggleShowRepliesToComment() {
    showRepliesToComment = !showRepliesToComment;
    update();
  }
}
