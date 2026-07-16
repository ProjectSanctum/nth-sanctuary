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
  nextlayerid = 13,
  nextobjectid = 30,
  properties = {
    ["border"] = "church_b",
    ["music"] = "second_church"
  },
  tilesets = {
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 1,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 199,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    },
    {
      name = "tiles_moss",
      firstgid = 781,
      filename = "../../../tilesets/tiles_moss.tsx"
    },
    {
      name = "church_objects",
      firstgid = 783,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 10,
      name = "objects_arch",
      class = "",
      visible = true,
      opacity = 0.6,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 179, 179, 179 },
      properties = {},
      objects = {
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 760,
          width = 397.232,
          height = 574,
          rotation = 0,
          gid = 783,
          visible = true,
          properties = {
            ["color"] = "#ffadadad"
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 760,
          width = 397.232,
          height = 574,
          rotation = 0,
          gid = 783,
          visible = true,
          properties = {
            ["color"] = "#ffadadad"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "objects_towers",
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
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = -720,
          y = 960,
          width = 640,
          height = 1600,
          rotation = 45,
          gid = 787,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_osc",
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
          name = "texturescroller",
          type = "",
          shape = "point",
          x = 0,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "hsv"
          }
        },
        {
          id = 10,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 80,
          width = 320,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "collision",
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
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 200,
          width = 240,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 0,
          width = 120,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 0,
          width = 120,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 200,
          width = 240,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 640,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "objects_under_party",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 8,
          name = "entry",
          type = "",
          shape = "point",
          x = 40,
          y = 360,
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
        0, 481, 482, 483, 470, 470, 470, 470, 470, 470, 470, 470, 481, 482, 483, 0,
        0, 487, 488, 489, 476, 476, 476, 476, 476, 476, 476, 476, 487, 488, 489, 0,
        0, 493, 494, 495, 7, 8, 9, 14, 14, 7, 8, 9, 493, 494, 495, 0,
        0, 499, 500, 501, 16, 17, 18, 14, 14, 16, 17, 18, 499, 500, 501, 0,
        0, 505, 506, 507, 25, 26, 27, 2, 3, 25, 26, 27, 505, 506, 507, 0,
        0, 28, 28, 28, 28, 28, 14, 11, 12, 14, 28, 28, 28, 28, 28, 0,
        0, 0, 0, 0, 0, 0, 28, 28, 28, 28, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "objects_under_party",
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
          id = 25,
          name = "churchmagicglass",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 240,
          width = 160,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["idlealpha"] = 0
          }
        },
        {
          id = 26,
          name = "churchmagicglass",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["idlealpha"] = 0
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 5,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 2147484429,
          visible = true,
          properties = {
            ["cutscene"] = "events.moss3",
            ["usetile"] = "true"
          }
        },
        {
          id = 27,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 280,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "2_2nd_sanctuary/second_sanctum_11_exit",
            ["marker"] = "entry2"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
      name = "objects_top",
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
          id = 28,
          name = "churchfog",
          type = "",
          shape = "point",
          x = 49,
          y = -5.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "filter",
          type = "",
          shape = "point",
          x = 9,
          y = -5.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "hsv"
          }
        }
      }
    }
  }
}
