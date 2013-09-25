/* jQuery ->
$('#advance-search').live 'click', ->
   $('#advance-search-form').toggle()
    $('#simple-search-form').toggle()*/




$.fn.truncate = function(options) {

        var defaults = {
            length: 300,
            minTrail: 20,
            moreText: "more",
            lessText: "less",
            ellipsisText: "..."
        };

        var options = $.extend(defaults, options);

        return this.each(function() {
            obj = $(this);
            //alert(options.minTrail);
            var body = obj.html();
            if (body.length > options.length + options.minTrail) {
                var splitLocation = body.indexOf(' ', options.length);
                if (splitLocation != -1) {
                    // truncate proj_notes
                    var splitLocation = body.indexOf(' ', options.length);
                    var str1 = body.substring(0, splitLocation);
                    var str2 = body.substring(splitLocation, body.length - 1);
                    obj.html(str1 + '<span class="truncate_ellipsis">' + options.ellipsisText +
                        '</span>' + '<span  class="truncate_more">' + str2 + '</span>');
                    obj.find('.truncate_more').css("display", "none");
                    // insert more link
                    obj.append(
                        '<div class="clearboth">' +
                        '<a href="#" style="margin-top:10px;"class="truncate_more_link btn btn-mini btn-info">' + options.moreText + '</a>' +
                        '</div>'
                    );
                    var moreLink = $('.truncate_more_link', obj);
                    var moreContent = $('.truncate_more', obj);
                    var ellipsis = $('.truncate_ellipsis', obj);
                    moreLink.click(function() {
                        if (moreLink.text() == options.moreText) {
                            moreContent.show('normal');
                            moreLink.text(options.lessText);
                            ellipsis.css("display", "none");
                        } else {
                            moreContent.hide('normal');
                            moreLink.text(options.moreText);
                            ellipsis.css("display", "inline");
                        }
                        return false;
                    });
                }
            }
        });
    };

    $().ready(function() {  
        $('.expand').click(function(e){
            e.preventDefault();
            $('.proj_notes').truncate( {  
                length: 250,  
                minTrail: 10,  
                moreText: 'show more',  
                lessText: 'show less'  
            }); 
	 	 
        });
    $('#advance-search').click(function(){
        $('#advance-search-form').toggle()
        $('#simple-search-form').toggle() 
    });
     $('#simple-search').click(function(){
        $('#advance-search-form').toggle()
        $('#simple-search-form').toggle() 
    });

 $('.expand , .collapse').click(function(e){
    e.preventDefault();
    if ($(this).hasClass('expand')){$(this).toggleClass('expand ,collapse');
                                    $(this).text("Collapse");
                                     $('.proj_title').css("font-weight","bold");
                                     $('.proj_notes').css("display","block");
                                     $('.proj_notes').css("text-align","justify");}
    else{
          $(this).toggleClass('expand');  
          $(this).text("Expand");
          $('.proj_title').css("font-weight","normal");
          $('.proj_notes').css("display","none");
          $('.proj_notes').css("text-align","justify");
        }
  });
   
    }); 

