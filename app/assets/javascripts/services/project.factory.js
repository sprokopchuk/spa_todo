angular.module('spaTodo.services').factory('ProjectFactory', ["Restangular", function(Restangular){

  return {
    projects: Restangular.all('api/projects').getList(),
    addProject: function(project){
      return Restangular.all('api/projects').post(project);
    }
  }
}]);

