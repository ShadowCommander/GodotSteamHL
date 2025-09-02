extends Node

var app_id
var steam_id
var is_online: bool
var is_game_owned: bool

func is_steam_enabled():
	return OS.has_feature("steam") or OS.is_debug_build()

func _init():
	OS.set_environment("SteamAppID", str(app_id))
	OS.set_environment("SteamGameID", str(app_id))

func _ready():
	if not is_steam_enabled():
		return
	
	var initialize_response: Dictionary = Steam.steamInitEx()
	print("Did Steam initialize?: %s" % initialize_response)

	if initialize_response['status'] > Steam.STEAM_API_INIT_RESULT_OK:
		print("Failed to initialize Steam, shutting down: %s" % initialize_response['verbal'])
		get_tree().quit()
	
	steam_id = Steam.getSteamID()
	is_online = Steam.loggedOn()
	is_game_owned = Steam.isSubscribed()
	
	if is_game_owned == false:
		print("User does not own this game")
		get_tree().quit()

func _process(delta):
	Steam.run_callbacks()

func get_profile_name():
	return Steam.getPersonaName()
