angular.module('spaTodo.services', []);
angular.module('spaTodo.controllers', ['spaTodo.services']);

angular.module('spaTodo',
  ['templates',
  'ui.router',
  'restangular',
  'spaTodo.controllers',
  'ng-token-auth',
  'xeditable'])
  .config(function($stateProvider, $urlRouterProvider, RestangularProvider, $authProvider){
    $authProvider.configure({
      apiUrl: ''
    });
    RestangularProvider.setBaseUrl("/");
    $urlRouterProvider.otherwise('/login');
    $stateProvider
      .state('index', {
        url: "/index",
        templateUrl: "index.html"
      })
      .state('login', {
        url: "/login",
        controller: "sessionCtrl",
        templateUrl: "login.html",
        resolve: {
          auth: function($auth, $state) {
            $auth.validateUser()
              .then(function(){
                $state.go('projects');
            });
          }
        }
      })
      .state('register', {
        url: "/register",
        controller: "registrationCtrl",
        templateUrl: "register.html",
        resolve: {
          auth: function($auth, $state) {
            $auth.validateUser()
              .then(function(){
                $state.go('projects');
            });
          }
        }
      })
      .state('projects', {
        url: "/projects",
        templateUrl: "projects.html",
        resolve: {
          auth: function($auth) {
            return $auth.validateUser();
          }
        }
      })
      .state('projects.new_project', {
        views: {
          'new_project': {
            templateUrl: "_new_project.html",
            controller: "ProjectsCtlr"
          }
        }
      })
      .state('projects.add_project', {
        views: {
          'new_project': {
            templateUrl: "_add_project.html"
          }
        }
      });
  })
  .run(['$rootScope', '$auth', '$state','editableOptions','editableThemes', function($rootScope, $auth, $state, editableOptions, editableThemes) {
    editableThemes.bs3.inputClass = 'input-sm';
    editableThemes.bs3.buttonsClass = 'btn-sm';
    editableThemes.bs3.formTpl = '<form class="form-inline editable-wrap pull-left col-md-10" role="form"></form>';
    editableThemes.bs3.submitTpl = '<button type="submit" class="btn btn-success"><span></span></button>',
    editableOptions.theme = 'bs3';
    $rootScope.$on('auth:login-success', function() {
      $state.go('projects');
    });
    $rootScope.$on('auth:logout-success', function(ev) {
      $state.go('login');
    })
  }]);


