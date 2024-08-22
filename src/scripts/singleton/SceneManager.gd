extends Node





@onready var loading_screen_scene = preload("res://src/scenes/loading-scenes/loading.tscn")





var scene_to_load_path
var loading_screen_scene_instance
var loading = false



var singleton_count = 3





func go_to_scene(path):
	var current_scene = get_tree().current_scene
	
	loading_screen_scene_instance = loading_screen_scene.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_scene_instance)
	
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)
		
	current_scene.queue_free()
	
	loading = true
	scene_to_load_path = path








func _process(_delta):
	if not loading:
		return
		
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_to_load_path, progress)


	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var progressbar = loading_screen_scene_instance.get_node("ProgressBar")
		progressbar.value =  progress[0] * 100
	
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get((scene_to_load_path)))
		loading_screen_scene_instance.queue_free()
		loading = false


	else:
		push_error("Ошибка загрузки!")  
		error_dialogue("Loading error!   " + str(get_tree().get_root().get_child(singleton_count)) + "      ERROR CODE: BAD BACK PARAMETER ")                             









func _notification(what):
	
	if what == NOTIFICATION_WM_GO_BACK_REQUEST and OS.get_name() == "Android" or OS.get_name() == "iOS":


		if get_tree().get_root().get_child(singleton_count).has_method("_on_back_button_pressed"):
			print("Переход на предыдущую с  " + str(get_tree().get_root().get_child(singleton_count)))
			await get_tree().create_timer(0.3).timeout
			get_tree().get_root().get_child(singleton_count).call("_on_back_button_pressed")


		elif !get_tree().get_root().get_child(singleton_count).has_method("_on_back_button_pressed"):
			print("[SECOND TRY] Переход на предыдущую с  " + str(get_tree().get_root().get_child(singleton_count)))
			await get_tree().create_timer(0.3).timeout
			get_tree().get_root().get_child(singleton_count + 1).call("_on_back_button_pressed")


		else:
			error_dialogue(str(get_tree().get_root().get_child(singleton_count)) + " ERROR CODE: BAD BACK PARAMETER [in notif SMgr]")
			print(str(get_tree().get_root().get_child(singleton_count)) + " Не имеет метода _on_back_button_pressed ")
	
	
	

func exit_app(reason: String):
	error_dialogue("Closing app! Fatal error! Closing after 10 second                                     Reason: " + reason)
	await get_tree().create_timer(10.0).timeout
	OS.kill(OS.get_process_id())
	

	

	
	
	
func error_dialogue(reason: String):
	var error_dialogue_instantiate = preload("res://src/scenes/dialogue-scenes/error-dialogue.tscn").instantiate()
	get_tree().get_root().add_child.call_deferred(error_dialogue_instantiate)
	
	await get_tree().create_timer(0.3).timeout
	get_tree().get_root().get_node("Error-dialogue").call("error_dialogue_starter", reason)
	get_tree().paused = true
	
	
	
	
	
	
	
	
	
	
