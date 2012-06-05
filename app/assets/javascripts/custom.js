
var winWidth = 950;
var winHeigh = 550;
var left = (screen.width/2)-(winWidth/2);
var top = (screen.height/2)-(winHeigh/2);

var fb_domainlink = "https://graph.facebook.com/oauth/authorize?";
var fb_req_perms = "req_perms=email&";
var fb_clientid = "client_id=230574627021570&";
var fb_scope = "scope=email,offline_access&";
var fb_redirect = "redirect_uri=http://versioneye.com/auth/facebook/callback";
var oauth_facebook_link = fb_domainlink + fb_req_perms + fb_clientid + fb_scope + fb_redirect;
var values = [{ label: "Choice1", va: "value1" }, { label: "Choice2", va: "value2" }]

jQuery.noConflict();
jQuery(document).ready(function() {
	
	jQuery('#q').tbHinter({
		text: "json",
		styleclass: "lp_searchfield_hint"
	});	
	
	jQuery('#fullname').tbHinter({
		text: "This is visible on your posts.",
		styleclass: "inputCelHint"
	});
	
	jQuery('#email').tbHinter({
		text: "Invisible for other users.",
		styleclass: "inputCelHint"
	});

	jQuery( "#tabs" ).tabs();

	FB.init({
        appId:'230574627021570', cookie:true,
        status:true, xfbml:true
    });
	
});

function load_dialog_follow(product_name){	
	document.getElementById('product_to_follow').innerHTML = product_name;	
	jQuery('#dialog_follow').dialog(
		{
		resizable: false, 
		modal: true, 
		draggable: false, 
		minWidth: 600, 
		});	
}

function load_dialog_feedback(){	
	jQuery('#dialog_feedback').dialog(
		{
		resizable: false, 
		modal: true, 
		draggable: false, 
		minWidth: 700, 
		});	
}

function validateEmail(elementValue){  
	var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;  
	var result = emailPattern.test(elementValue);  
	if (result == false){
		alert('The E-Mail Address is not valid! Please type in a valid E-Mail Address');
	}
	return result;
}

function validateFeedbackForm(){	
	var result = true
	var fullname = document.getElementById('fb_fullname').value;	
	if (fullname == "" || fullname == null){
		alert('Please type in your Name.')
		result = false
	}
	var email = document.getElementById('fb_email').value;	
	result = validateEmail(email)
	var feedback = document.getElementById('feedback').value;	
	if (feedback == "" || feedback == null){
		alert('Please type in your Feedback.')
		result = false
	}
}

function textCounter(field, cntfield, maxlimit) {
	if (field.value.length > maxlimit) 
		field.value = field.value.substring(0, maxlimit);
	else
		cntfield.innerHTML = maxlimit - field.value.length;
}

function exchangeImage(id, image){
	image_path = "/assets/" + image
	document.getElementById(id).src=image_path;
}

function show_versioncomment_reply(id){
	var form_id = "#" + id + "_reply_form";
	var display_link = "#" + id + "_reply_link";
	var hide_link = "#" + id + "_hide_link";
	jQuery(form_id).css('display', 'block'); 
	jQuery(display_link).css('display', 'none'); 
	jQuery(hide_link).css('display', 'block'); 
	return false;
}

function hide_versioncomment_reply(id){
	var form_id = "#" + id + "_reply_form";
	var display_link = "#" + id + "_reply_link";
	var hide_link = "#" + id + "_hide_link";
	jQuery(form_id).css('display', 'none'); 
	jQuery(display_link).css('display', 'block'); 
	jQuery(hide_link).css('display', 'none'); 
	return false;
}

function shareOnFacebook(link, message){
	var picture = 'http://versioneye.com/assets/icon_114.png'
	FB.ui({ method: 'feed',
        link: link,
        picture: picture,
        description: message});
}

function update_lang(language){
	orig_param = language;
	icon_id = orig_param.toLowerCase() + "_icon"
	lang = document.getElementById("lang").value
	language_orig = language;
	language = language + ","
	var rg = new RegExp(language,'i');
	if (lang.search(rg) == -1){
		lang = lang + "," + language
		if (document.getElementById(icon_id) != null){
			document.getElementById(icon_id).src = "/assets/language/" + orig_param.toLowerCase() + ".png"	
			document.getElementById(icon_id).style.borderBottom = "2px solid #f9b323";
		}
	} else {
		lang = lang.replace(language, "")
		if (document.getElementById(icon_id) != null){
			document.getElementById(icon_id).src = "/assets/language/" + orig_param.toLowerCase() + "_bw.png"
			document.getElementById(icon_id).style.borderBottom = "0px solid #f9b323";
		}		
	}
	lang = lang.replace(",,", ",") 
	document.getElementById("lang").value = lang
}
