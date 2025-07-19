extends TileMapLayer

@export var height: int
@export var width: int

@export var wallPlaceholderAtlasCoord: Vector2i
@export var doorPlaceholderAtlasCoord: Vector2i 
@export var floorPlaceholderAtlasCoord: Vector2i 
@export var rockPlaceholderAtlasCoord: Vector2i

const tiles := {
	TileType.Wall: Vector2i(0,0),
	TileType.Door: Vector2i(1,0),
	TileType.Floor: Vector2i(2,0),
	TileType.Rock: Vector2i(3,0)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_tile()
	set_display_tile()

func set_random_tile():
	for i in range(width):
		for j in range(height):
			if j == 0 or i == 0 or i == width-1 or j == height -1:
				set_cell(Vector2i(i,j),0,Vector2i(0,0))
				if j == height/2 or j == height/2 - 1:
					set_cell(Vector2i(i,j),0,Vector2i(1,0))
				if i == width/2 or i == width/2 - 1:
					set_cell(Vector2i(i,j),0,Vector2i(1,0))
				continue
			
			fill_center_with_terrein()

func is_near_wall(x:int, y:int):
	var flag = 0
	for offset in [Vector2i(0,-1),Vector2i(0,1), Vector2i(-1,0), Vector2i(1,0)]:
		var neightbor = Vector2i(x,y) + offset
		if get_cell_source_id(neightbor) == 0:
			return false
	return true

func fill_center_with_terrein():
	var rock_chance := 0.3
	for i in range(1, width - 1):
		for j in range(1, height - 1):
			if get_cell_atlas_coords(Vector2i(i,j)) == Vector2i(1,0):
				continue
			
			if is_near_wall(i,j):
				print("floor")
				set_cell(Vector2i(i,j), 0, Vector2i(3,0))
				continue
			
			if randf() < rock_chance:
				set_cell(Vector2i(i,j), 0, Vector2i(2,0))
			else:
				set_cell(Vector2i(i,j), 0, Vector2i(3,0))

func set_display_tile():
	for i in get_used_cells():
		self.set_cell(i, 2, calculate_display_tile(i))

func calculate_display_tile(coords: Vector2i) -> Vector2i:
	var tile = get_world_tile(coords)
	
	return tiles[tile]

func get_world_tile(coords: Vector2i):
	var atlasCoords = get_cell_atlas_coords(coords)
	match atlasCoords:
		wallPlaceholderAtlasCoord:
			return TileType.Wall
		doorPlaceholderAtlasCoord:
			return TileType.Door
		floorPlaceholderAtlasCoord:
			return TileType.Floor
		rockPlaceholderAtlasCoord:
			return TileType.Rock
		

enum TileType {
	Wall,
	Door,
	Floor,
	Rock
}


func _on_button_pressed() -> void:
	set_random_tile()
	set_display_tile()
