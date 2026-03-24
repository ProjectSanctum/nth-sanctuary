return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 26,
  height = 18,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 18,
  nextobjectid = 107,
  properties = {
    ["border"] = "church_b",
    ["music"] = "second_church",
    ["name"] = "Second Sanctuary - Main"
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
      name = "bg_dw_church_2_tileset",
      firstgid = 686,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 13,
      name = "objects_parallax3",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.3,
      parallaxy = 0.82,
      properties = {},
      objects = {
        {
          id = 47,
          name = "",
          type = "",
          shape = "rectangle",
          x = -80,
          y = 210,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 210,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 210,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 50,
          name = "",
          type = "",
          shape = "rectangle",
          x = -80,
          y = 410,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 410,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 52,
          name = "",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 410,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 53,
          name = "",
          type = "",
          shape = "rectangle",
          x = -80,
          y = 610,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 54,
          name = "",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 610,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 55,
          name = "",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 610,
          width = 416,
          height = 130,
          rotation = 0,
          gid = 595,
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
      id = 11,
      name = "objects_parallax2",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.4,
      parallaxy = 0.85,
      properties = {},
      objects = {
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 270,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 270,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 41,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = 850,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 850,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 44,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1190,
          y = 720,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1190,
          y = 240,
          width = 480,
          height = 150,
          rotation = -90,
          gid = 595,
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
      id = 10,
      name = "objects_parallax",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.5,
      parallaxy = 0.9,
      properties = {},
      objects = {
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = -720,
          y = 760,
          width = 640,
          height = 1600,
          rotation = -315,
          gid = 587,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 730,
          width = 640,
          height = 1600,
          rotation = -315,
          gid = 1073742411,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 18,
      id = 14,
      name = "tiles_osc_optimize",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 0, 0, 0,
        0, 0, 0, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 879, 0, 0, 0,
        0, 0, 0, 879, 879, 879, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 879, 879, 0, 0, 0,
        0, 0, 0, 879, 879, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 879, 879, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
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
          id = 35,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 560,
          width = 800,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 640,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 81,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 640,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "texturescroller",
          type = "",
          shape = "point",
          x = 80,
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
      type = "objectgroup",
      draworder = "topdown",
      id = 16,
      name = "objects_belower",
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
          id = 101,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 840,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 102,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 840,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 103,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 200,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 104,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 200,
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
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 18,
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
        0, 0, 0, 3221225833, 3221225880, 3221225878, 3221225833, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225833, 3221225880, 3221225878, 3221225833, 0, 0, 0,
        0, 0, 0, 3221225833, 3221225874, 3221225872, 3221225833, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225833, 3221225874, 3221225872, 3221225833, 0, 0, 0,
        0, 0, 0, 3221225827, 3221225868, 3221225866, 3221225827, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225827, 3221225868, 3221225866, 3221225827, 0, 0, 0,
        0, 0, 0, 3221225821, 3221225862, 3221225860, 3221225821, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225821, 3221225862, 3221225860, 3221225821, 0, 0, 0,
        0, 0, 0, 3221225821, 3221225856, 3221225854, 3221225827, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225821, 3221225856, 3221225854, 3221225827, 0, 0, 0,
        0, 0, 0, 355, 419, 419, 349, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 355, 419, 419, 349, 0, 0, 0,
        0, 0, 0, 349, 419, 419, 349, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 355, 419, 419, 349, 0, 0, 0,
        0, 0, 0, 355, 419, 419, 349, 0, 722, 723, 724, 723, 724, 725, 723, 724, 725, 726, 0, 355, 419, 419, 349, 0, 0, 0,
        0, 0, 0, 355, 382, 384, 349, 0, 731, 732, 733, 732, 733, 734, 732, 733, 734, 735, 0, 355, 382, 384, 349, 0, 0, 0,
        0, 0, 0, 349, 388, 390, 349, 0, 740, 741, 742, 741, 742, 743, 741, 742, 743, 744, 0, 349, 388, 390, 349, 0, 0, 0,
        0, 0, 0, 355, 394, 396, 355, 0, 756, 755, 750, 754, 751, 752, 753, 750, 754, 757, 0, 355, 394, 396, 355, 0, 0, 0,
        0, 0, 0, 361, 400, 402, 361, 0, 765, 764, 759, 763, 760, 761, 762, 759, 763, 766, 0, 361, 400, 402, 361, 0, 0, 0,
        0, 0, 0, 361, 406, 408, 361, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 361, 406, 408, 361, 0, 0, 0,
        0, 0, 0, 367, 576, 576, 367, 859, 859, 859, 859, 859, 0, 0, 859, 859, 859, 859, 859, 367, 576, 576, 367, 0, 0, 0,
        0, 0, 0, 881, 707, 705, 706, 702, 863, 864, 872, 873, 702, 703, 817, 818, 819, 820, 702, 705, 706, 707, 881, 0, 0, 0,
        0, 0, 0, 855, 716, 714, 715, 864, 872, 873, 874, 711, 711, 712, 826, 827, 828, 829, 864, 714, 715, 716, 855, 0, 0, 0,
        0, 0, 0, 702, 872, 713, 713, 713, 713, 713, 713, 713, 713, 713, 713, 713, 713, 713, 713, 713, 713, 702, 872, 0, 0, 0,
        0, 0, 0, 702, 702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 702, 702, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 18,
      id = 17,
      name = "roomglow_dark",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,
        133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 15,
      name = "objects_below",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 77,
          name = "churchmagicglass",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 400,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["idlealpha"] = 0,
            ["starthidden"] = true
          }
        },
        {
          id = 77,
          name = "churchmagicglass",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 480,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["idlealpha"] = 0,
            ["starthidden"] = true
          }
        },
        {
          id = 105,
          name = "eye_glow",
          type = "",
          shape = "point",
          x = 520.058,
          y = 434.246,
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
      id = 15,
      name = "collision",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 84,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 120,
          height = 720,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 85,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 640,
          width = 640,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "",
          type = "",
          shape = "rectangle",
          x = 920,
          y = 0,
          width = 120,
          height = 720,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 87,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 200,
          height = 560,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 88,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 0,
          width = 400,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 89,
          name = "",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 0,
          width = 200,
          height = 560,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 90,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 400,
          width = 160,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 91,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 400,
          width = 160,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 94,
          name = "npc",
          type = "",
          shape = "point",
          x = 360,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "lobbyman",
            ["text1"] = "* Wrong way."
          }
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
          x = 880,
          y = 700,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "entry",
          type = "",
          shape = "point",
          x = 160,
          y = 700,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 100,
          name = "targ",
          type = "",
          shape = "point",
          x = 520,
          y = 120,
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
          id = 61,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 720,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "2_2nd_sanctuary/second_sanctum_1",
            ["marker"] = "entry"
          }
        },
        {
          id = 78,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 720,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "0_base_sanctum/base_south_2",
            ["marker"] = "kpoint"
          }
        },
        {
          id = 95,
          name = "cameratarget",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 280,
          width = 400,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["lockx"] = true,
            ["locky"] = true,
            ["marker"] = "targ",
            ["time"] = 0.5
          }
        },
        {
          id = 98,
          name = "roomglow",
          type = "",
          shape = "point",
          x = 120,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["prophecy"] = true
          }
        },
        {
          id = 99,
          name = "prophecy",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 302,
          width = 400,
          height = 98,
          rotation = 0,
          visible = true,
          properties = {
            ["fade_edges"] = true,
            ["no_back"] = true,
            ["offx"] = 205,
            ["offy"] = -115,
            ["panel_h"] = 90,
            ["panel_w"] = 150,
            ["spr_offx"] = 75,
            ["spr_offy"] = 90,
            ["text"] = "COLDWATER FELL FROM THE\nTOP OF THE SKY.",
            ["texture"] = "coldwater",
            ["txt_offx"] = -170,
            ["txt_offy"] = -55
          }
        },
        {
          id = 106,
          name = "npc",
          type = "",
          shape = "point",
          x = 360,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "lobbyman",
            ["text1"] = "* Wrong way."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
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
          id = 27,
          name = "churchfog",
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
          id = 6,
          name = "filter",
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
    }
  }
}
