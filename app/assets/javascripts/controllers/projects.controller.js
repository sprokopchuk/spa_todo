angular.module('spaTodo')
  .controller('ProjectsCtlr', function($scope, ProjectFactory){
    this.newProject = {name: null},
    this.addProject = function(){
      ProjectFactory.addProject(this.newProject);
    },

    this.allProjects = function(){}
});