angular.module('spaTodo.controllers')
  .controller('ProjectsCtlr', function($scope, ProjectFactory){
    var self = this;
    self.addProject = function(project){
      ProjectFactory.addProject(project).then(function(newProject){
        self.projects.push(newProject);
      });
    }
    self.projects = ProjectFactory.projects.$object;

    self.removeProject = function(project){
      project.remove();
      self.projects = _.without(self.projects, project);
    }
});
