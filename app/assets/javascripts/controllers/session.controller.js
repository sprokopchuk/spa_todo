angular.module('spaTodo.controllers')
  .controller('sessionCtrl', ['$scope', '$state', '$auth',
    function($scope, $state, $auth) {
      $scope.$on('auth:login-error', function(ev, reason) {
        $scope.error = reason.errors[0];
      });
      $scope.handleLoginBtnClick = function() {
        $auth.submitLogin($scope.loginForm)
          .then(function(resp) {
          });
      };
  }]);

