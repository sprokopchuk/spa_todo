angular.module('spaTodo', ['templates', 'ui.router', 'restangular'])
  .config(function ($stateProvider, $urlRouterProvider, RestangularProvider) {
    RestangularProvider.setBaseUrl("/");
    $urlRouterProvider.otherwise('/');

    $stateProvider
      .state('index', {
        url: "/index",
        templateUrl: "templates/index.html"
      });
  });




