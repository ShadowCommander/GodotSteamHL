extends Node

signal lobby_match_list_returned


#region Public

func request_open_lobby_list() -> void:
	#TODO Make this a list of fliter checkboxes in a UI
	Steam.addRequestLobbyListDistanceFilter(Steam.LOBBY_DISTANCE_FILTER_WORLDWIDE)
	Steam.addRequestLobbyListStringFilter("game", "A3F51S", Steam.LobbyComparison.LOBBY_COMPARISON_EQUAL)

	print("Requesting a lobby list")
	Steam.requestLobbyList()

#endregion

func _ready() -> void:
	Steam.lobby_match_list.connect(_on_lobby_match_list)

func _on_lobby_match_list(these_lobbies: Array) -> void:
	lobby_match_list_returned.emit(these_lobbies)
