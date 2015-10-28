angular.module('spaTodo.services').factory 'ProjectFactory', [
  'Restangular'
  (Restangular) ->
    {
      projects: Restangular.all('api/projects').getList()
      addProject: (project) ->
        Restangular.all('api/projects').post project

    }
]
