var app = angular.module('ContactsApp',['ngRoute']);

app.config(function($routeProvider) {
	$routeProvider.when('/all-contacts',
		{
			controller: 'ctrlContacts',
			templateUrl: 'templates/allContacts.html'
		})
		.when('/view-contacts/:contactId',
		{
			controller: 'ctrlViewContacts',
			templateUrl: 'templates/viewContact.html'
		})
		.when('/add-contacts/',
		{
			controller: 'ctrlAddContacts',
			templateUrl: 'templates/manageContact.html'
		})
		.when('/edit-contacts/:contactId',
		{
			controller: 'ctrlEditContacts',
			templateUrl: 'templates/manageContact.html'
		})
		.otherwise({ redirectTo: '/all-contacts' });
});

app.controller('ctrlContacts', function($scope, ContactService){
	ContactService.getContact().success(function(contacts) {
        $scope.contacts = contacts;                 
    });
	
	$scope.confirmDel = function(id){
		if(confirm('Do you really want to delete this contact?')){
			ContactService.delContact(id).success(function() {
				ContactService.getContact().success(function(contacts) {
					$scope.contacts = contacts;                 
				});             
			});
		}
	};
	
	$scope.setOrder = function (orderby) {
        if (orderby === $scope.orderby)
        {
            $scope.reverse = !$scope.reverse;
        }
        $scope.orderby = orderby;
    };
});

app.controller('NavbarController', function ($scope, $location) {
    $scope.getClass = function (path) {
        if ($location.path().substr(0, path.length) == path) {
            return true
        } else {
            return false;
        }
    }
});

app.controller('ctrlViewContacts', function($scope, $routeParams, ContactService) {
	ContactService.getContact($routeParams.contactId).success(function(contact) {
        $scope.contact = contact;
    });
});

app.controller('ctrlAddContacts', function($scope, ContactService) {
	$scope.submitForm = function(contact) {
		if ($scope.ContactForm.$valid) {
			ContactService.addContact(contact).success(function() {
				$scope.ContactForm.$setPristine();
				$scope.contact = null;
				alert('Contact added succesfully.');
			});
		}
	};
});

app.controller('ctrlEditContacts', function($scope, $routeParams, ContactService) {
	$scope.contact ={};
	ContactService.getContact($routeParams.contactId).success(function(contacts) {
		$scope.contact.name = contacts[0].name;
		$scope.contact.email = contacts[0].email;
		$scope.contact.phone = contacts[0].phone;
		$scope.contact.add1 = contacts[0].add1;
		$scope.contact.add2 = contacts[0].add2;
		$scope.contact.city = contacts[0].city;
		$scope.contact.state = contacts[0].state;
		$scope.contact.country = contacts[0].country;
		$scope.contact.zip = contacts[0].zip;              
    });
	
	$scope.submitForm = function(contact) {
		if ($scope.ContactForm.$valid) {
			ContactService.editContact(contact, $routeParams.contactId).success(function() {
				$scope.ContactForm.$setPristine();
				$scope.contact = null;
				alert('Contact updated succesfully.');
				window.location = "#/all-contacts";
			});
		}
	};
});


