angular.module('spaTodo.controllers').controller 'ProjectsCtlr', ($scope, ProjectFactory) ->
  self = this

  self.addProject = (project) ->
    ProjectFactory.addProject(project).then (newProject) ->
      self.projects.push newProject
      return
    return

  self.projects = ProjectFactory.projects.$object

  self.removeProject = (project) ->
    project.remove().then ->
      _.remove self.projects, project
      return
    return

  return
