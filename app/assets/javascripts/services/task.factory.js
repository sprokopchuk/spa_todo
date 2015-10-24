angular.module('spaTodo.services').factory('TaskFactory', ["Restangular", function(Restangular){


  return {

    updateTask: function(task){
      return Restangular.restangularizeElement(null, task, 'api/tasks').put();
    },

    removeTask: function(task, project){
      return Restangular.restangularizeElement(null, task, 'api/tasks').remove({project_id: task.project_id});
    },

    addTask: function(task, project){
      return Restangular.one('/api/projects', project.id).all('tasks').post(task);
    }
  }
}]);

