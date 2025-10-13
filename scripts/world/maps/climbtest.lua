return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 28,
  properties = {
    ["music"] = "climb"
  },
  tilesets = {
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 1,
      filename = "../tilesets/bg_dw_church_tileset_new.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 577, 577, 577, 577, 577, 577, 577, 577, 0, 0, 0, 0,
        0, 0, 0, 0, 577, 0, 0, 0, 0, 0, 0, 577, 0, 0, 0, 0,
        0, 0, 0, 0, 577, 0, 0, 0, 0, 0, 0, 577, 0, 0, 0, 0,
        0, 0, 0, 0, 577, 0, 577, 577, 577, 577, 0, 577, 0, 0, 0, 0,
        0, 0, 0, 0, 577, 0, 0, 0, 0, 0, 0, 577, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects_buckets",
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
          id = 24,
          name = "climbwaterbucket",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["activetime"] = 15,
            ["generate"] = true
          }
        },
        {
          id = 25,
          name = "climbwaterbucket",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["generate"] = false
          }
        },
        {
          id = 26,
          name = "climbwaterbucket",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["generate"] = true
          }
        },
        {
          id = 27,
          name = "climbwaterbucket",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["generate"] = false
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 6,
          name = "climbentry",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["area"] = { id = 9 }
          }
        },
        {
          id = 7,
          name = "climblanding",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 360,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "climbentry",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["area"] = { id = 11 }
          }
        },
        {
          id = 9,
          name = "climbarea",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 160,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "climbarea",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 160,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "climbarea",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 160,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "climbarea",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 280,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
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
          id = 3,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
