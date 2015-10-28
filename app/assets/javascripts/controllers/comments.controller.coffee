angular.module('spaTodo.controllers').controller 'CommentsCtlr', ($scope, CommentFactory) ->
  self = this

  self.addComment = (comment, task) ->
    CommentFactory.addComment(comment, task).then (newComment) ->
      task.comments.push newComment
      $scope.newComment.body = ''
      return
    return

  self.removeComment = (comment, task) ->
    CommentFactory.removeComment(comment).then ->
      _.remove task.comments, comment
      return
    return

  self.attachFile = (file, comment) ->
    file.upload = CommentFactory.attachFile(file, comment)
    file.upload.then (resp) ->
      comment.attachment_filename = resp.data.attachment_filename
      comment.attachment_url = resp.data.attachment_url
      return
    file.upload.progress (evt) ->
      file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total))
      return
    return

  return
