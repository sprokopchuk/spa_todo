angular.module('spaTodo.controllers')
  .controller('TasksCtlr', function($scope, TaskFactory){
    var self = this;
    self.addTask = function(task, project){
      TaskFactory.addTask(task, project).then(function(newTask){
        project.tasks.push(newTask);
        $scope.newTask.name = "";
      });
    }

    self.updateTask = function(task){
      TaskFactory.updateTask(task);
    }
    self.removeTask = function(task, project){
      TaskFactory.removeTask(task).then(function(){
        _.remove(project.tasks, task);
      });
    }

});
