angular.module('spaTodo').factory('ProjectFactory', function(Restangular){
  allProjects = function(){
    return Restangular.all('projects').getList();
  },

  addProject = function(project){
    return Restangular.all('projects').post(project);
  }


});
