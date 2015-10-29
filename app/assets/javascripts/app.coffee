angular.module 'spaTodo.services', []
angular.module 'spaTodo.controllers', [ 'spaTodo.services' ]
angular.module('spaTodo', [
  'templates'
  'ui.router'
  'restangular'
  'spaTodo.controllers'
  'ng-token-auth'
  'xeditable'
  'ngFileUpload'
  'ui.date'
]).config(($stateProvider, $urlRouterProvider, RestangularProvider, $authProvider) ->
  $authProvider.configure apiUrl: ''
  RestangularProvider.setBaseUrl '/'
  $urlRouterProvider.otherwise '/login'
  $stateProvider.state('login',
    url: '/login'
    controller: 'sessionCtrl'
    templateUrl: 'login.html'
  ).state('register',
    url: '/register'
    controller: 'registrationCtrl'
    templateUrl: 'register.html'
  ).state 'projects',
    url: '/'
    templateUrl: 'projects.html'
    resolve: auth: ($auth) ->
      $auth.validateUser()
  return
).run [
  '$rootScope'
  '$auth'
  '$state'
  'editableOptions'
  'editableThemes'
  ($rootScope, $auth, $state, editableOptions, editableThemes) ->
    $auth.validateUser().then(-> $state.go 'projects')
    editableThemes.bs3.inputClass = 'input-sm'
    editableThemes.bs3.buttonsClass = 'btn-sm'
    editableThemes.bs3.formTpl = '<form class="form-inline editable-wrap pull-left" role="form"></form>'
    editableThemes.bs3.submitTpl = '<button type="submit" class="btn btn-success"><span></span></button>'
    editableOptions.theme = 'bs3'
    $rootScope.$on 'auth:login-success', ->
      $state.go 'projects'
      return
    $rootScope.$on 'auth:logout-success', (ev) ->
      $state.go 'login'
      return
    return
]
