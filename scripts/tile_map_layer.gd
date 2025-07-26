extends TileMapLayer

@export var displayTileMap: TileMapLayer

@export var floorPlaceholderAtlasCoord: Vector2i = Vector2i(0,0)
@export var waterPlaceholderAtlasCoord: Vector2i = Vector2i(1,0)

var neightbours:Array = [Vector2i(0,0),Vector2i(1,0),Vector2i(0,1),Vector2i(1,1)]

var tiles :Dictionary = {
	[TileType.Floor,TileType.Floor,TileType.Water,TileType.Floor]: Vector2i(0,0),
	[TileType.Floor,TileType.Water,TileType.Floor,TileType.Water]: Vector2i(1,0),
	[TileType.Water,TileType.Floor,TileType.Water,TileType.Water]: Vector2i(2,0),
	[TileType.Floor,TileType.Floor,TileType.Water,TileType.Water]: Vector2i(3,0),
	[TileType.Water,TileType.Floor,TileType.Floor,TileType.Water]: Vector2i(0,1),
	[TileType.Floor,TileType.Water,TileType.Water,TileType.Water]: Vector2i(1,1),
	[TileType.Water,TileType.Water,TileType.Water,TileType.Water]: Vector2i(2,1),
	[TileType.Water,TileType.Water,TileType.Water,TileType.Floor]: Vector2i(3,1),
	[TileType.Floor,TileType.Water,TileType.Floor,TileType.Floor]: Vector2i(0,2),
	[TileType.Water,TileType.Water,TileType.Floor,TileType.Floor]: Vector2i(1,2),
	[TileType.Water,TileType.Water,TileType.Floor,TileType.Water]: Vector2i(2,2),
	[TileType.Water,TileType.Floor,TileType.Water,TileType.Floor]: Vector2i(3,2),
	[TileType.Floor,TileType.Floor,TileType.Floor,TileType.Floor]: Vector2i(0,3),
	[TileType.Floor,TileType.Floor,TileType.Floor,TileType.Water]: Vector2i(1,3),
	[TileType.Floor,TileType.Water,TileType.Water,TileType.Floor]: Vector2i(2,3),
	[TileType.Water,TileType.Floor,TileType.Floor,TileType.Floor]: Vector2i(3,3)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reload_display_tiles()

func _reload_display_tiles():
	for coord: Vector2i in get_used_cells():
		print(coord)
		set_display_tile(coord)

func set_tile(coords: Vector2i, atlas_coords: Vector2i):
	set_cell(coords, 0, atlas_coords)
	set_display_tile(coords)

func set_display_tile(pos: Vector2i):
	for i in neightbours.size():
		var newpos: Vector2i = pos + neightbours[i]
		displayTileMap.set_cell(newpos, 1, calculate_display_tile(newpos))

func calculate_display_tile(coords: Vector2i):
	var botRight = get_world_tile(coords - neightbours[0])
	var botLeft = get_world_tile(coords - neightbours[1])
	var topRight = get_world_tile(coords - neightbours[2])
	var topLeft = get_world_tile(coords - neightbours[3])
	
	#print([topLeft,topRight,botLeft,botRight])
	return tiles[[topLeft,topRight,botLeft,botRight]]

func get_world_tile(coords: Vector2i):
	var atlasCoords = get_cell_atlas_coords(coords)
	#print(get_cell_atlas_coords(coords))
	if atlasCoords == waterPlaceholderAtlasCoord:
		return TileType.Water
	else: 
		return TileType.Floor

enum TileType {
	None,
	Floor,
	Water
}
