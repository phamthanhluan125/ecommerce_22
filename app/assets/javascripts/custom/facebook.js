(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.8&appId=417319065315237";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

$(document).ready(function() {
  var url = $(location).attr('href');
  var segments = url.split( '/' );
  if(segments[4] != 'admin'){
    window._sbzq||function(e){e._sbzq=[];var t=e._sbzq;
    t.push(["_setAccount",62070]);
    var n=e.location.protocol=="https:"?"https:":"http:";
    var r=document.createElement("script");
    r.type="text/javascript";r.async=true;
    r.src=n+"//static.subiz.com/public/js/loader.js";
    var i=document.getElementsByTagName("script")[0];
    i.parentNode.insertBefore(r,i)}(window);
  }
});
