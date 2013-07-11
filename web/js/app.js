window.fbAsyncInit = function() {
    // init the FB JS SDK
    FB.init({
      appId      : '435157456498322',
      status     : false,
      xfbml      : false
    });
    if(typeof window.onFacebookReady == 'function'){
    	window.onFacebookReady();
    }
};