extends Node





@onready var loading_screen_scene = preload("res://src/scenes/loading-scenes/loading.tscn")





var scene_to_load_path
var loading_screen_scene_instance
var loading = false








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
		print("Ошибка загрузки!")







func _notification(what):
	var singleton_count = 3
	
	if what == NOTIFICATION_WM_GO_BACK_REQUEST and OS.get_name() == "Android" or OS.get_name() == "iOS":
		
		if get_tree().get_root().get_child(singleton_count).has_method("_on_back_button_pressed"):
			print("Переход на предыдущую с  " + str(get_tree().get_root().get_child(3)))
			get_tree().get_root().get_child(singleton_count).call("_on_back_button_pressed")
		
		else:
			print(str(get_tree().get_root().get_child(singleton_count)) + " Не имеет метода _on_back_button_pressed ")
	























