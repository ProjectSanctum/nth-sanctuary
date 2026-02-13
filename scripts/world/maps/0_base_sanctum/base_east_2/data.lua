return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 79,
  properties = {
    ["border"] = "base_sanctum",
    ["music"] = "homebase"
  },
  tilesets = {
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 1,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    },
    {
      name = "church_objects",
      firstgid = 583,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "light_areas",
      firstgid = 673,
      filename = "../../../tilesets/light_areas.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 32,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        74, 359, 360, 74, 74, 74, 74, 74, 74, 377, 74, 74, 477, 74, 74, 74, 74, 74, 477, 74, 74, 74, 478, 377, 74, 74, 378, 74, 74, 353, 354, 74,
        0, 0, 0, 0, 0, 0, 377, 74, 378, 476, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 478, 74, 377, 475, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
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
          id = 69,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 440,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 72,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 400,
          width = 480,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 73,
          name = "",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 440,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1040,
          y = 400,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 1280,
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
          id = 54,
          name = "spawn",
          type = "",
          shape = "point",
          x = 80,
          y = 390,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "entry",
          type = "",
          shape = "point",
          x = 40,
          y = 390,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "entry2",
          type = "",
          shape = "point",
          x = 1240,
          y = 390,
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
      id = 8,
      name = "objects_windows",
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
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 168,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 248,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 328,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          type = "",
          shape = "rectangle",
          x = 408,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 488,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "",
          type = "",
          shape = "rectangle",
          x = 568,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "",
          type = "",
          shape = "rectangle",
          x = 648,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "",
          type = "",
          shape = "rectangle",
          x = 728,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "",
          type = "",
          shape = "rectangle",
          x = 808,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 65,
          name = "",
          type = "",
          shape = "rectangle",
          x = 888,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 968,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1048,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1128,
          y = 320,
          width = 62,
          height = 224,
          rotation = 0,
          gid = 608,
          visible = true,
          properties = {}
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
          id = 77,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "0_base_sanctum/base_east_3",
            ["marker"] = "entry"
          }
        },
        {
          id = 78,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "0_base_sanctum/base_east_1",
            ["marker"] = "entry2"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects_lightareas",
      class = "",
      visible = false,
      opacity = 0.5,
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
          x = 88,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 150,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 168,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 230,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 248,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 310,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 328,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 390,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 408,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 470,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 488,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 550,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 568,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 790,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 808,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 870,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 888,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 648,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 710,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 728,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 44,
          name = "",
          type = "",
          shape = "rectangle",
          x = 950,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 968,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1030,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 47,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1048,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1110,
          y = 480,
          width = 18,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1128,
          y = 480,
          width = 62,
          height = 480,
          rotation = 0,
          gid = 677,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 51,
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
            ["highlight"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects_fog",
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
          id = 53,
          name = "churchfog",
          type = "",
          shape = "point",
          x = -10,
          y = -70,
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
      id = 2,
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
          id = 52,
          name = "filter",
          type = "",
          shape = "point",
          x = -30,
          y = -70,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "hsv2"
          }
        }
      }
    }
  }
}
