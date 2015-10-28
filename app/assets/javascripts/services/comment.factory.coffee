angular.module('spaTodo.services').factory 'CommentFactory', [
  'Restangular'
  'Upload'
  (Restangular, Upload) ->
    {
      removeComment: (comment, task) ->
        Restangular.restangularizeElement(null, comment, 'api/comments').remove task_id: comment.task_id
      addComment: (comment, task) ->
        Restangular.one('/api/tasks', task.id).all('comments').post comment
      attachFile: (file, comment) ->
        Upload.upload
          url: '/api/comments/' + comment.id + '/attach_file'
          method: 'POST'
          fields:
            'task_id': comment.task_id
            'comment[attachment]': file

    }
]
