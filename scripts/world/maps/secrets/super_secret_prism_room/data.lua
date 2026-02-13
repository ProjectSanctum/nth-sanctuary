return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 32,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 39,
  properties = {
    ["music"] = "darkchurch_intro",
    ["name"] = "1 of 5."
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
      width = 16,
      height = 32,
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
        0, 0, 0, 434, 435, 435, 435, 435, 437, 437, 437, 437, 438, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 101, 101, 101, 101, 101, 101, 101, 101, 444, 0, 0, 0,
        0, 0, 0, 440, 441, 101, 101, 101, 101, 101, 101, 441, 444, 0, 0, 0,
        0, 0, 0, 446, 447, 447, 131, 101, 101, 132, 447, 447, 450, 0, 0, 0,
        0, 0, 0, 456, 452, 453, 440, 132, 131, 444, 456, 452, 453, 0, 0, 0,
        0, 0, 0, 462, 458, 459, 440, 126, 125, 444, 462, 458, 459, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 440, 132, 131, 444, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 440, 126, 125, 444, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 440, 132, 131, 444, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 440, 126, 125, 444, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 440, 132, 131, 444, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 440, 126, 125, 444, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 446, 447, 449, 450, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 453, 454, 455, 456, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 459, 460, 461, 462, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 480,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 40,
          width = 40,
          height = 840,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 40,
          width = 40,
          height = 840,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 840,
          width = 120,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 1200,
          width = 400,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 840,
          width = 120,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 1080,
          width = 120,
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
      name = "objects_glass",
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
          name = "churchmagicglass",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 1120,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 60,
          y = 800,
          width = 36,
          height = 120,
          rotation = 0,
          gid = 3221226070,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 540,
          y = 800,
          width = 36,
          height = 120,
          rotation = 0,
          gid = 1073742422,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 60,
          y = 560,
          width = 36,
          height = 120,
          rotation = 0,
          gid = 3221226070,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 540,
          y = 560,
          width = 36,
          height = 120,
          rotation = 0,
          gid = 1073742422,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 60,
          y = 320,
          width = 36,
          height = 120,
          rotation = 0,
          gid = 3221226070,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 540,
          y = 320,
          width = 36,
          height = 120,
          rotation = 0,
          gid = 1073742422,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
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
          id = 1,
          name = "npc",
          type = "",
          shape = "point",
          x = 320,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ddelta",
            ["cutscene"] = "events.prism"
          }
        },
        {
          id = 38,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 1120,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "4_4th_sanctuary/fourth_sanctum_2",
            ["marker"] = "entry_prism"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 14,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 1120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "entry",
          type = "",
          shape = "point",
          x = 40,
          y = 1160,
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
      id = 7,
      name = "objects_lightarea",
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
          id = 27,
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
            ["alpha"] = 0.5,
            ["highlight"] = true
          }
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 230,
          y = 230,
          width = 184,
          height = 262,
          rotation = 0,
          gid = 676,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 260,
          y = 210,
          width = 120,
          height = 262,
          rotation = 0,
          gid = 676,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.2,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 320,
          width = 62,
          height = 80,
          rotation = 0,
          gid = 679,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 460,
          y = 320,
          width = 62,
          height = 80,
          rotation = 0,
          gid = 2147484327,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 560,
          width = 62,
          height = 80,
          rotation = 0,
          gid = 679,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 460,
          y = 560,
          width = 62,
          height = 80,
          rotation = 0,
          gid = 2147484327,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 800,
          width = 62,
          height = 80,
          rotation = 0,
          gid = 679,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 460,
          y = 800,
          width = 62,
          height = 80,
          rotation = 0,
          gid = 2147484327,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 15,
          name = "filter",
          type = "",
          shape = "point",
          x = -40,
          y = -40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["hue_start"] = "0",
            ["hue_target"] = "-100",
            ["sat_start"] = "0.5",
            ["sat_target"] = "0",
            ["speed"] = 5,
            ["type"] = "custom",
            ["val_start"] = "0.5",
            ["val_target"] = "0.75"
          }
        }
      }
    }
  }
}
