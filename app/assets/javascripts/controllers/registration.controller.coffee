angular.module('spaTodo.controllers').controller 'registrationCtrl', [
  '$scope'
  '$auth'
  '$location'
  ($scope, $auth, $location) ->
    $scope.$on 'auth:registration-email-error', (ev, reason) ->
      $scope.error = reason.errors.full_messages[0]
      return

    $scope.handleRegBtnClick = ->
      $auth.submitRegistration($scope.registrationForm).then (resp) ->
        $auth.submitLogin(
          email: $scope.registrationForm.email
          password: $scope.registrationForm.password).then (resp) ->
        return
      return

    return
]
