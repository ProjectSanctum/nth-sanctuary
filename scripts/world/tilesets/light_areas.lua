return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  name = "light_areas",
  class = "",
  tilewidth = 188,
  tileheight = 360,
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
  tilecount = 10,
  tiles = {
    {
      id = 0,
      image = "../../../assets/sprites/world/lightarea/spr_light_area_mask_gradient.png",
      width = 188,
      height = 229
    },
    {
      id = 1,
      image = "../../../assets/sprites/world/lightarea/spr_light_area_mask_window.png",
      width = 80,
      height = 360
    },
    {
      id = 2,
      image = "../../../assets/sprites/world/lightarea/spr_light_area_mask_window_textureless.png",
      width = 80,
      height = 360
    },
    {
      id = 3,
      image = "../../../assets/sprites/world/lightarea/spr_light_area_spot.png",
      width = 92,
      height = 131
    },
    {
      id = 4,
      image = "../../../assets/sprites/world/lightarea/spr_light_area_simple.png",
      width = 1,
      height = 1
    },
    {
      id = 5,
      image = "../../../assets/sprites/world/lightarea/spr_windowtest.png",
      width = 80,
      height = 180
    },
    {
      id = 6,
      image = "../../../assets/sprites/world/lightarea/torch_glow_1.png",
      width = 31,
      height = 40,
      animation = {
        {
          tileid = 6,
          duration = 100
        },
        {
          tileid = 7,
          duration = 100
        },
        {
          tileid = 8,
          duration = 100
        },
        {
          tileid = 9,
          duration = 100
        }
      }
    },
    {
      id = 7,
      image = "../../../assets/sprites/world/lightarea/torch_glow_2.png",
      width = 31,
      height = 40
    },
    {
      id = 8,
      image = "../../../assets/sprites/world/lightarea/torch_glow_3.png",
      width = 31,
      height = 40
    },
    {
      id = 9,
      image = "../../../assets/sprites/world/lightarea/torch_glow_4.png",
      width = 31,
      height = 40
    }
  }
}
