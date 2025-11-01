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
  nextlayerid = 14,
  nextobjectid = 61,
  properties = {
    ["border"] = "church_b",
    ["music"] = "second_church",
    ["name"] = "Second Sanctuary - Main"
  },
  tilesets = {
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 1,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx"
    },
    {
      name = "church_objects",
      firstgid = 583,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 602,
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
      visible = true,
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
      visible = true,
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
      visible = true,
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
          id = 32,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 40,
          width = 480,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 160,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 240,
          width = 80,
          height = 440,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 600,
          width = 720,
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
          x = 160,
          y = 680,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "texturescroller",
          type = "",
          shape = "point",
          x = -43.9394,
          y = -193.636,
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
        0, 0, 0, 0, 0, 0, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 737, 0, 0, 0, 0, 737, 0, 0,
        0, 0, 0, 0, 0, 0, 603, 604, 74, 74, 74, 74, 74, 74, 74, 74, 74, 614, 746, 0, 0, 0, 0, 746, 0, 0,
        0, 0, 0, 0, 0, 0, 612, 613, 74, 771, 770, 609, 770, 789, 788, 771, 610, 74, 755, 0, 0, 0, 0, 755, 0, 0,
        0, 0, 0, 0, 0, 0, 74, 617, 789, 618, 618, 618, 618, 618, 618, 618, 619, 74, 764, 775, 775, 775, 775, 764, 0, 0,
        0, 0, 0, 0, 0, 0, 608, 789, 618, 618, 618, 779, 780, 618, 618, 779, 605, 74, 623, 632, 780, 618, 618, 618, 0, 0,
        0, 0, 0, 0, 0, 0, 778, 618, 618, 618, 618, 788, 789, 618, 618, 788, 772, 74, 632, 624, 80, 780, 618, 618, 0, 0,
        0, 0, 0, 0, 0, 0, 80, 780, 618, 618, 618, 779, 798, 797, 798, 618, 618, 619, 629, 629, 629, 629, 797, 780, 0, 0,
        0, 0, 0, 0, 0, 0, 80, 80, 627, 627, 627, 799, 80, 80, 80, 627, 627, 80, 0, 0, 0, 0, 615, 778, 0, 0,
        0, 0, 0, 0, 0, 0, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 0, 0, 0, 0, 80, 787, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 788, 614, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 618, 781, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 618, 788, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 618, 618, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 780, 618, 0, 0,
        0, 0, 0, 0, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 778, 618, 0, 0,
        0, 0, 0, 0, 797, 623, 621, 622, 787, 779, 780, 779, 614, 80, 771, 770, 789, 618, 618, 788, 612, 613, 80, 780, 0, 0,
        0, 0, 0, 0, 771, 632, 630, 631, 789, 788, 789, 790, 80, 789, 618, 618, 779, 797, 780, 618, 788, 80, 770, 771, 0, 0,
        0, 0, 0, 0, 618, 788, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 629, 0, 0
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
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 320,
          width = 720,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 240,
          width = 160,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 0,
          width = 80,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 0,
          width = 480,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 0,
          width = 320,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 160,
          width = 80,
          height = 560,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 680,
          width = 720,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 600,
          width = 40,
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
          x = 480,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "spoint",
          type = "",
          shape = "point",
          x = 280,
          y = 640,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "npoint",
          type = "",
          shape = "point",
          x = 80,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "spoint2",
          type = "",
          shape = "point",
          x = 200,
          y = 640,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "rpoint",
          type = "",
          shape = "point",
          x = 260,
          y = 610,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "kpoint",
          type = "",
          shape = "point",
          x = 260,
          y = 670,
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
          id = 8,
          name = "npc",
          type = "",
          shape = "point",
          x = 200,
          y = 640,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "noelle",
            ["flagcheck"] = "!noellefall"
          }
        },
        {
          id = 9,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 600,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "primary.fall",
            ["flagcheck"] = "!noellefall",
            ["once"] = true
          }
        },
        {
          id = 57,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 840,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 760,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 400,
          y = 520,
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
          x = -80,
          y = 60,
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
          x = -133.939,
          y = -43.6364,
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
