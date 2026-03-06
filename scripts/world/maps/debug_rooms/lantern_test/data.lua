return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 42,
  height = 30,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 12,
  nextobjectid = 123,
  properties = {},
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 99,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 297,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "objects_bg",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "darkroombg",
          type = "",
          shape = "point",
          x = 40,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 42,
      height = 30,
      id = 8,
      name = "Tile Layer 2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 20,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 711, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 717, 0, 0, 0, 0, 0, 711, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 723, 0, 0, 0, 0, 0, 717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 711, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 729, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 711, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 42,
      height = 30,
      id = 1,
      name = "Tile Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 711, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 729, 0, 0, 0, 0, 0, 0, 0,
        0, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 376, 370, 376, 376, 370, 370, 376, 370, 370, 376, 376, 370, 376, 370, 370, 376, 376, 376,
        0, 370, 376, 0, 370, 370, 370, 370, 376, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 711, 0, 376, 376, 370, 376, 370, 376, 370, 370, 376, 376, 376, 370, 370, 370, 376, 376, 370, 370,
        0, 370, 370, 0, 376, 370, 370, 376, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 729, 0, 376, 370, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382,
        0, 376, 370, 376, 376, 376, 382, 382, 370, 376, 0, 0, 0, 0, 0, 0, 370, 376, 376, 376, 370, 376, 376, 370, 376, 376, 376, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 376, 370, 370, 376, 376, 0, 0, 370, 376, 0, 0, 0, 0, 0, 0, 376, 370, 370, 376, 370, 370, 370, 376, 376, 376, 376, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 382, 382, 382, 376, 370, 376, 370, 370, 370, 0, 0, 0, 0, 0, 0, 376, 370, 382, 382, 382, 382, 382, 382, 382, 382, 382, 370, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 376, 370, 673, 370, 376, 370, 0, 0, 0, 0, 0, 0, 370, 376, 376, 771, 370, 376, 370, 370, 376, 370, 376, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 382, 382, 382, 382, 376, 376, 376, 370, 376, 370, 774, 376, 376, 370, 376, 376, 370, 376, 370, 370, 376, 376, 376, 376, 376, 0, 0, 711, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 370, 370, 370, 376, 370, 376, 376, 376, 376, 370, 376, 382, 382, 382, 376, 370, 382, 382, 382, 370, 376, 0, 0, 729, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 382, 382, 382, 382, 382, 382, 382, 382, 382, 376, 370, 0, 711, 0, 376, 370, 0, 0, 0, 370, 370, 376, 376, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 376, 370, 0, 729, 0, 370, 370, 0, 0, 0, 376, 376, 376, 376, 370, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 370, 376, 376, 376, 673, 376, 0, 0, 0, 382, 382, 382, 382, 382, 382, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 711, 0, 370, 376, 376, 376, 376, 370, 370, 370, 376, 376, 370, 370, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 729, 0, 370, 376, 376, 370, 370, 370, 376, 370, 382, 382, 382, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 376, 370, 370, 370, 370, 772, 673, 673, 376, 771, 382, 382, 382, 382, 376, 376, 0, 0, 0, 370, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 376, 376, 370, 376, 376, 673, 673, 673, 376, 376, 0, 0, 0, 0, 370, 376, 0, 0, 0, 376, 376, 0, 0, 0, 0, 0, 370, 370, 376, 376, 376, 376, 376, 370, 0, 0, 0, 0, 0,
        0, 0, 0, 382, 382, 382, 370, 370, 382, 382, 382, 376, 376, 0, 0, 0, 0, 370, 376, 0, 711, 0, 376, 370, 0, 0, 0, 0, 0, 376, 370, 376, 370, 376, 376, 376, 376, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 376, 370, 0, 0, 0, 376, 376, 0, 0, 0, 0, 370, 370, 0, 729, 0, 370, 376, 0, 0, 0, 0, 0, 370, 370, 382, 382, 382, 382, 370, 376, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 376, 370, 0, 0, 0, 370, 376, 0, 0, 0, 0, 376, 370, 376, 370, 376, 376, 370, 370, 376, 370, 370, 370, 370, 376, 370, 370, 370, 376, 370, 376, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 711, 0, 370, 376, 376, 370, 376, 370, 376, 0, 0, 0, 0, 376, 376, 370, 370, 376, 376, 370, 376, 376, 370, 376, 376, 674, 773, 376, 376, 376, 376, 376, 370, 0, 711, 0, 0, 0,
        0, 0, 0, 0, 729, 0, 376, 376, 370, 370, 370, 376, 376, 0, 0, 0, 0, 370, 370, 382, 382, 382, 382, 382, 382, 382, 370, 376, 382, 382, 382, 382, 382, 382, 382, 376, 370, 0, 729, 0, 0, 0,
        376, 376, 376, 376, 376, 376, 370, 376, 382, 382, 382, 370, 370, 0, 0, 0, 0, 376, 376, 0, 0, 0, 0, 0, 0, 0, 370, 370, 370, 376, 370, 370, 376, 370, 370, 673, 370, 376, 370, 370, 370, 376,
        370, 376, 376, 370, 376, 370, 376, 370, 0, 0, 0, 370, 376, 376, 376, 370, 370, 376, 370, 0, 0, 0, 0, 0, 0, 0, 370, 376, 370, 370, 376, 376, 370, 376, 376, 772, 376, 376, 376, 376, 370, 370,
        382, 382, 382, 382, 382, 382, 382, 382, 0, 0, 0, 370, 370, 376, 376, 376, 376, 370, 376, 0, 0, 0, 0, 0, 0, 0, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 382, 382, 382, 382, 382, 382, 382, 382, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects_switch",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 16,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 640,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 52,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 820,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 53,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 1060,
          y = 820,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 82,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 940,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 83,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 580,
          y = 980,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 84,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 1520,
          y = 940,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 85,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 540,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 86,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 220,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 87,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 1240,
          y = 460,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 102,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 1360,
          y = 100,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 103,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 500,
          y = 380,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 104,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 260,
          y = 300,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "objects_party",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 57,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = -240,
          y = 960,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["bigsize"] = 640,
            ["littlesize"] = 400,
            ["maxtimer"] = 120,
            ["timebuffer"] = 300
          }
        },
        {
          id = 88,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 180,
          y = 880,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 90,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 380,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 92,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 820,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 93,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 520,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 94,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 1260,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 95,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 1540,
          y = 880,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 96,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 1080,
          y = 760,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 97,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 820,
          y = 760,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 98,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 600,
          y = 920,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 99,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 280,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 100,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 900,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 101,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 1380,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 115,
          name = "npc",
          type = "",
          shape = "point",
          x = 480,
          y = 800,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "kris",
            ["path"] = "enemy_1"
          }
        },
        {
          id = 116,
          name = "npc",
          type = "",
          shape = "point",
          x = 470,
          y = 810,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "kris",
            ["path"] = "enemy_1",
            ["progress"] = 0.25
          }
        },
        {
          id = 117,
          name = "npc",
          type = "",
          shape = "point",
          x = 460,
          y = 820,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "kris",
            ["path"] = "enemy_1",
            ["progress"] = 0.5
          }
        },
        {
          id = 118,
          name = "npc",
          type = "",
          shape = "point",
          x = 450,
          y = 830,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "kris",
            ["path"] = "enemy_1",
            ["progress"] = 0.75
          }
        },
        {
          id = 122,
          name = "npc",
          type = "",
          shape = "point",
          x = 481.5,
          y = 742.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "kris",
            ["path"] = "enemy_1",
            ["progress"] = "0.823"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "paths",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 113,
          name = "enemy_1",
          type = "",
          shape = "polygon",
          x = 480,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 400 },
            { x = 240, y = 400 },
            { x = 240, y = 0 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "spawn",
          type = "",
          shape = "point",
          x = 60,
          y = 960,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects_overlay",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 9,
          name = "darkness",
          type = "",
          shape = "point",
          x = 0,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["alpha"] = 1,
            ["highlight"] = false
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "battleareas",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 119,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 560,
          width = 320,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
