return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  name = "fast_travel_doors",
  class = "",
  tilewidth = 80,
  tileheight = 80,
  spacing = 0,
  margin = 0,
  columns = 0,
  objectalignment = "unspecified",
  tilerendersize = "tile",
  fillmode = "stretch",
  tileoffset = {
    x = 0,
    y = 0
  },
  grid = {
    orientation = "orthogonal",
    width = 1,
    height = 1
  },
  properties = {},
  wangsets = {},
  tilecount = 7,
  tiles = {
    {
      id = 0,
      image = "../../../assets/sprites/world/objects/fast_travel_doors/shard_door.png",
      width = 80,
      height = 80
    },
    {
      id = 1,
      image = "../../../assets/sprites/world/objects/fast_travel_doors/shard_door_vapor.png",
      width = 80,
      height = 80
    },
    {
      id = 2,
      image = "../../../assets/sprites/world/objects/fast_travel_doors/shard_door_flooded_frame1.png",
      width = 80,
      height = 80,
      animation = {
        {
          tileid = 2,
          duration = 200
        },
        {
          tileid = 3,
          duration = 200
        },
        {
          tileid = 4,
          duration = 200
        },
        {
          tileid = 5,
          duration = 200
        },
        {
          tileid = 6,
          duration = 200
        }
      }
    },
    {
      id = 3,
      image = "../../../assets/sprites/world/objects/fast_travel_doors/shard_door_flooded_frame2.png",
      width = 80,
      height = 80
    },
    {
      id = 4,
      image = "../../../assets/sprites/world/objects/fast_travel_doors/shard_door_flooded_frame3.png",
      width = 80,
      height = 80
    },
    {
      id = 5,
      image = "../../../assets/sprites/world/objects/fast_travel_doors/shard_door_flooded_frame4.png",
      width = 80,
      height = 80
    },
    {
      id = 6,
      image = "../../../assets/sprites/world/objects/fast_travel_doors/shard_door_flooded_frame5.png",
      width = 80,
      height = 80
    }
  }
}
