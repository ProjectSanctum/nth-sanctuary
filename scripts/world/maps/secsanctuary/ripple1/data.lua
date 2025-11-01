return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 26,
  height = 18,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 18,
  nextobjectid = 91,
  properties = {
    ["border"] = "church_b",
    ["music"] = "none"
  },
  tilesets = {
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 1,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx"
    },
    {
      name = "libraryexcerpt",
      firstgid = 583,
      filename = "../../../tilesets/libraryexcerpt.tsx",
      exportfilename = "../../../tilesets/libraryexcerpt.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 631,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "church_objects",
      firstgid = 829,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 18,
      id = 11,
      name = "mask",
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
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 613, 613,
        613, 613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 613, 613,
        613, 613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 613, 613, 613,
        613, 613, 613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613,
        613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 0, 0, 0, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613, 613
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 15,
      name = "objects_parallax3",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.3,
      parallaxy = 0.82,
      properties = {},
      objects = {
        {
          id = 75,
          name = "",
          type = "",
          shape = "rectangle",
          x = -80,
          y = 210,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 210,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 77,
          name = "",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 210,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 78,
          name = "",
          type = "",
          shape = "rectangle",
          x = -80,
          y = 410,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 79,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 410,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 80,
          name = "",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 410,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 81,
          name = "",
          type = "",
          shape = "rectangle",
          x = -80,
          y = 610,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 82,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 610,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 83,
          name = "",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 610,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 14,
      name = "objects_parallax2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.4,
      parallaxy = 0.85,
      properties = {},
      objects = {
        {
          id = 53,
          name = "",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 160,
          width = 360,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          type = "",
          shape = "rectangle",
          x = 270,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 270,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 61,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 62,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 63,
          name = "",
          type = "",
          shape = "rectangle",
          x = 850,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 64,
          name = "",
          type = "",
          shape = "rectangle",
          x = 850,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 65,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1190,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1190,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 841,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 13,
      name = "objects_parallax",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.5,
      parallaxy = 0.9,
      properties = {},
      objects = {
        {
          id = 57,
          name = "",
          type = "",
          shape = "rectangle",
          x = -720,
          y = 760,
          width = 640,
          height = 1600,
          rotation = -315,
          gid = 833,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 730,
          width = 640,
          height = 1600,
          rotation = -315,
          gid = 1073742657,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 16,
      name = "objects_tile_oscillate",
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
          id = 84,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 80,
          width = 880,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 85,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 320,
          width = 800,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 400,
          width = 120,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 87,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 200,
          width = 120,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 88,
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
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 18,
      id = 12,
      name = "tiles",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 804, 0, 0,
        0, 0, 649, 656, 641, 642, 664, 665, 666, 650, 651, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 0, 0,
        0, 0, 655, 655, 655, 655, 673, 674, 675, 659, 660, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 0, 0,
        0, 0, 649, 653, 655, 649, 682, 683, 684, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 0, 0,
        0, 0, 658, 658, 658, 658, 658, 658, 658, 658, 658, 658, 649, 649, 649, 658, 658, 658, 658, 658, 658, 658, 658, 658, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 0, 0, 0,
        0, 0, 0, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 649, 0, 0, 0,
        0, 0, 0, 658, 658, 658, 658, 658, 658, 658, 658, 658, 649, 649, 649, 658, 658, 658, 658, 658, 658, 658, 658, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 649, 649, 649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 80,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 40,
          width = 880,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 80,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 200,
          width = 440,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 200,
          width = 440,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 320,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 400,
          width = 360,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 400,
          width = 360,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          type = "",
          shape = "rectangle",
          x = 920,
          y = 320,
          width = 40,
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
          id = 1,
          name = "spawn",
          type = "",
          shape = "point",
          x = 540,
          y = 160,
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
          id = 29,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 40,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 1000,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 80,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 960,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 400,
          y = 680,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 680,
          y = 680,
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
      id = 5,
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
          id = 28,
          name = "churchfog",
          type = "",
          shape = "point",
          x = -70,
          y = 50,
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
      id = 17,
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
          id = 90,
          name = "filter",
          type = "",
          shape = "point",
          x = -60,
          y = -205,
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
