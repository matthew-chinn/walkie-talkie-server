// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
    $('a#get-message').click(function(){
        var x = new XMLHttpRequest();
        var id = $('p#id').text();
        var url = "http://localhost:3000/profile/" + id + "/get-message";
        x.open("DELETE", url);
        x.responseType = 'json';
        x.onload = function() {
            // Parse and process the response from Google Image Search.
            response = x.response;
            if(!response)
                renderText("No messages found");
            else
                renderText(response.text);
            return;
        };
        x.onerror = function() {
            renderHtml('<p>Network error.</p>');
            return;
        };
        x.send();

    });

});

function renderText(text) {
    $('p#message').text(text);
}

