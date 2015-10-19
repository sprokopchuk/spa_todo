ctrls = angular.module('spaTodo.controllers');
ctrls.controller('registrationCtrl', ['$scope', '$auth', '$location',
    function($scope, $auth, $location) {

      $scope.$on('auth:registration-email-error', function(ev, reason) {
        $scope.error = reason.errors.full_messages[0];
      });
      $scope.handleRegBtnClick = function() {
        $auth.submitRegistration($scope.registrationForm)
          .then(function(resp) {
              console.log(resp);
            $auth.submitLogin({
              email: $scope.registrationForm.email,
              password: $scope.registrationForm.password
            }).then(function(resp){
              console.log(resp);
            });
          });
      };
    }
  ]);
