app.factory('ContactService', function($http) {
	var factory = {};
	
	factory.getContact = function(id) {
		return $http.get('http://localhost/contact-app/contacts.cfc?method=getContacts&contactid=' + id);
	};
	
	factory.delContact = function(id) {
		return $http.get('http://localhost/contact-app/contacts.cfc?method=delContact&contactid=' + id);
	};
	
	factory.addContact = function(objContact){
		return $http.get('http://localhost/contact-app/contacts.cfc?method=newContact&jsStruct=' + JSON.stringify(objContact));
	};
	
	factory.editContact = function(objContact, id){
		return $http.get('http://localhost/contact-app/contacts.cfc?method=editContact&contactid=' + id + '&jsStruct=' + JSON.stringify(objContact));
	};
	return factory;
});
