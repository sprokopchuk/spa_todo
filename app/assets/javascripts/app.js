angular.module('spaTodo.services', []);
angular.module('spaTodo.controllers', ['spaTodo.services']);

angular.module('spaTodo',
  ['templates',
  'ui.router',
  'restangular',
  'spaTodo.controllers',
  'ng-token-auth'])
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
        templateUrl: "login.html"
      })
      .state('register', {
        url: "/register",
        controller: "registrationCtrl",
        templateUrl: "register.html"
      })
      .state('projects', {
        url: "/projects",
        templateUrl: "projects.html",
        resolve: {
          auth: function($auth) {
            return $auth.validateUser();
          }
        }
      });
  })
  .run(['$rootScope', '$location', '$auth', '$state', function($rootScope, $location, $auth, $state) {
    $rootScope.$on('auth:login-success', function() {
      $location.path('/projects');
    });
    $rootScope.$on('auth:logout-success', function(ev) {
      $location.path('/login');
    })
    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
      $auth.validateUser()
      .then(function(resp){
        if(toState.name == "login" || toState.name == "register"){
          $state.go('projects');
        }
      });
    });
  }]);


