// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery.min
//= require toastr_rails

// require turbolinks
//= require_tree .

 var firebaseConfig = {
    apiKey: "AIzaSyDDyoQ7sAGdYN-mS0KSzN-za_xWapdGGQY",
    authDomain: "easyiofyp-db877.firebaseapp.com",
    projectId: "easyiofyp-db877",
    storageBucket: "easyiofyp-db877.appspot.com",
    messagingSenderId: "530550778812",
    appId: "1:530550778812:web:574e70409267efe15459b9",
    measurementId: "G-YG4PWF88KS"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  //firebase.analytics();

function login(email,password,e)
{ 
	firebase.auth().signInWithEmailAndPassword(email.toString(), password.toString()).then((user) => {
    console.log('s');
    console.log(firebase.auth().currentUser);
    console.log(user);
    return "Successfully";
  })
  .catch((error) => {
    e.preventDefault();
  	console.log('e');
  	console.log(error.message);
    var errorCode = error.code;
    var errorMessage = error.message;
    return "error";
  });
}

$("form.user_login").submit(function(e){
  alert("Submitted");
  console.log("asd");
  var email = $(this).find("input[name='user[email]']").val()
  var password = $(this).find("input[name='user[password]']").val()
  console.log("Email : "+email);
  console.log(login(email,password,e))
  
});
