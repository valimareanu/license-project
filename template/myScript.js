$(document).ready(function(){

	$(".chosen3").chosen({
		max_selected_options: 1,
		display_selected_options:true, 
		no_results_text:"Results not found", 
		enable_split_word_search:true, 
		search_contains:false, 
		display_disabled_options:true, 
		single_backstroke_delete:false,
		width:"180px", 
		inherit_select_classes:true 
	});

	$(".chosen2").chosen({
		max_selected_options: 3,
		display_selected_options:true, 
		placeholder_text_multiple:"Select some options", 
		no_results_text:"Results not found", 
		enable_split_word_search:true, 
		search_contains:false, 
		display_disabled_options:true, 
		single_backstroke_delete:false,
		width:"180px", 
		inherit_select_classes:true 
	});

	$(".chosen").chosen({
		display_selected_options:true, 
		no_results_text:"Results not found", 
		enable_split_word_search:true, 
		search_contains:false, 
		display_disabled_options:true, 
		single_backstroke_delete:false,
		width:"180px", 
		inherit_select_classes:true 
	});

	$(".search_filter").change(function(evt){
		var obj = $(evt.currentTarget);
		var filter_name = obj.data("filter");
		var filter_value = obj.val();
		$.ajax({
			url: "./suggest_movies.php?set_filter=true",
			type: "POST",
			data: {
				"filter_name": filter_name,
				"filter_value": filter_value
			}
		});
	});

});
