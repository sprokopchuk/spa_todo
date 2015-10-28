angular.module('spaTodo.controllers').controller 'TasksCtlr', ($scope, TaskFactory) ->
  self = this

  self.addTask = (task, project) ->
    TaskFactory.addTask(task, project).then (newTask) ->
      project.tasks.push newTask
      $scope.newTask.name = ''
      return
    return

  self.updateTask = (task) ->
    TaskFactory.updateTask task
    return

  self.removeTask = (task, project) ->
    TaskFactory.removeTask(task).then ->
      _.remove project.tasks, task
      return
    return

  return
