$('document').ready(function(){


if ($('#select_my_task').val() != null)
{


var project_type_id = $('#select_my_task').val();

var iss = $('#iss').val();

$('#project_task').html.empty;

  $('#related_category').html.empty;
  
  $.ajax({ url: '/show_tasks_edit/' ,
    
    data: {id: project_type_id ,i: iss},
    success: function(data) {
	 
      $('#related_category').html(data);
      
	  $("#spinner_ten").hide();
	  $('#related_task').html(data);
    }
  });
  



}
});
 

function getTasks() {
 //alert("select_id ");
$('#select_my_task').live('click', function() {

var project_type_id = $('#select_my_task').val();


$("#spinner_ten").show();
$('#project_task').html.empty;

  $('#related_category').html.empty;
  
  $.ajax({ url: '/show_tasks/' ,
    
    data: {id: project_type_id},
    success: function(data) {
	 
      $('#related_category').html(data);
      
	  $("#spinner_ten").hide();
	  $('#related_task').html(data);
    }
  });
  
  

});
}

//jjjk
function getTasks_edit() {
 //alert("select_id ");
$('#select_my_task_edit').live('', function() {

var project_type_id = $('#select_my_task_edit').val();
alert("edit");

$("#spinner_ten").show();
$('#project_task').html.empty;

  $('#related_category').html.empty;
  
  $.ajax({ url: '/show_tasks/' ,
    
    data: {id: project_type_id},
    success: function(data) {
	 
      $('#related_category').html(data);
      
	  $("#spinner_ten").hide();
	  $('#related_task').html(data);
    }
  });
  
  

});
}

