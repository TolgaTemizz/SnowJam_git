extends Node3D


func _ready() -> void:
	# Ensure music loops regardless of which file is loaded
	_setup_music_loop($Camera3D/GameScene_Music)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			_open_settings()


func _open_settings() -> void:
	# Record previous scene and open settings
	get_node("/root/SceneState").previous_scene_path = "res://Scenes/game_scene.tscn"
	get_tree().change_scene_to_file("res://Scenes/uı.tscn")


func _setup_music_loop(player: AudioStreamPlayer2D) -> void:
	if player.stream == null:
		return
	
	# Simply connect finished signal to loop the music
	# Don't modify the stream at all to avoid corruption
	player.finished.connect(_on_music_finished.bind(player))


func _on_music_finished(player: AudioStreamPlayer2D) -> void:
	# Restart the music when it finishes
	player.play()
