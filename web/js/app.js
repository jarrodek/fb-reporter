window.fbAsyncInit = function() {

	function getAppid(){
	    if(window.location.hostname.indexOf('127.') != -1){
	      return '435157456498322';
	    }
	    return '201022293343552';
	  }

    // init the FB JS SDK
    FB.init({
      appId      : getAppid(),
      status     : false,
      xfbml      : false
    });
    if(typeof window.onFacebookReady == 'function'){
    	window.onFacebookReady();
    }
};

