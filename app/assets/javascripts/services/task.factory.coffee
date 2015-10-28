angular.module('spaTodo.services').factory 'TaskFactory', [
  'Restangular'
  (Restangular) ->
    {
      updateTask: (task) ->
        Restangular.restangularizeElement(null, task, 'api/tasks').put()
      removeTask: (task) ->
        Restangular.restangularizeElement(null, task, 'api/tasks').remove project_id: task.project_id
      addTask: (task, project) ->
        Restangular.one('/api/projects', project.id).all('tasks').post task

    }
]
