return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 26,
  height = 14,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 13,
  nextobjectid = 33,
  properties = {
    ["border"] = "church_d",
    ["music"] = "fourth_church"
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
      name = "church_objects",
      firstgid = 781,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "light_areas",
      firstgid = 883,
      filename = "../../../tilesets/light_areas.tsx"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "objects_bg2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.55,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 920,
          width = 400,
          height = 1600,
          rotation = 0,
          gid = 1073742608,
          visible = true,
          properties = {
            ["color"] = "#ff4646c6"
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1040,
          y = 80,
          width = 400,
          height = 578,
          rotation = 180,
          gid = 1073742697,
          visible = true,
          properties = {
            ["color"] = "#ff4646c6"
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 80,
          width = 400,
          height = 578,
          rotation = 180,
          gid = 1073742697,
          visible = true,
          properties = {
            ["color"] = "#ff4646c6"
          }
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 80,
          width = 400,
          height = 578,
          rotation = 180,
          gid = 1073742697,
          visible = true,
          properties = {
            ["color"] = "#ff4646c6"
          }
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = -160,
          y = 80,
          width = 400,
          height = 578,
          rotation = 180,
          gid = 1073742697,
          visible = true,
          properties = {
            ["color"] = "#ff4646c6"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 10,
      name = "objects_bg1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.6,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = -160,
          y = 1320,
          width = 640,
          height = 1600,
          rotation = 0,
          gid = 1073742609,
          visible = true,
          properties = {}
        }
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
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 40,
          width = 480,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "polygon",
          x = 0,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 400, y = 0 },
            { x = 400, y = 40 },
            { x = 440, y = 40 },
            { x = 440, y = 120 },
            { x = 0, y = 120 }
          },
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "polygon",
          x = 160,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -40, y = 0 },
            { x = -40, y = 240 },
            { x = 880, y = 240 },
            { x = 880, y = 120 },
            { x = 440, y = 120 },
            { x = 440, y = 80 },
            { x = 400, y = 80 },
            { x = 400, y = 40 },
            { x = 320, y = 40 },
            { x = 320, y = 80 },
            { x = 80, y = 80 },
            { x = 80, y = 240 },
            { x = 0, y = 240 }
          },
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "polygon",
          x = 680,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -40 },
            { x = -40, y = -40 },
            { x = -40, y = -80 },
            { x = -80, y = -80 },
            { x = -80, y = -160 },
            { x = 280, y = -160 },
            { x = 280, y = -240 },
            { x = -120, y = -240 },
            { x = -120, y = -200 },
            { x = -200, y = -200 },
            { x = -200, y = -320 },
            { x = 360, y = -320 },
            { x = 360, y = 0 }
          },
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 14,
      id = 8,
      name = "Tile Layer 3",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 14,
      id = 2,
      name = "Tile Layer 2",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 631, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 26,
      height = 14,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 772, 773, 772, 773, 772, 773, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 778, 779, 778, 779, 778, 779, 0, 0,
        10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 195, 0, 0, 10, 10, 10, 10, 37, 38, 39, 40, 38, 41, 0, 0,
        10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 195, 195, 195, 10, 10, 10, 55, 56, 57, 58, 56, 59, 0, 0,
        10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 195, 195, 28, 28, 28, 64, 65, 66, 67, 65, 68, 0, 0,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 10, 10, 10, 10, 195, 0, 0, 0, 73, 74, 75, 76, 74, 77, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 10, 10, 10, 10, 195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 195, 195, 10, 10, 10, 195, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 10, 195, 195, 195, 195, 195, 195, 195, 195, 10, 10, 10, 10, 195, 10, 10, 10, 10, 10, 10, 10, 10,
        0, 0, 0, 0, 10, 195, 10, 10, 10, 10, 10, 195, 28, 28, 10, 10, 10, 195, 10, 10, 10, 10, 10, 10, 10, 10,
        0, 0, 0, 0, 10, 195, 28, 28, 28, 28, 28, 28, 0, 0, 28, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
        0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
        0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          id = 3,
          name = "entry",
          type = "",
          shape = "point",
          x = 40,
          y = 140,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "spawn",
          type = "",
          shape = "point",
          x = 200,
          y = 140,
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
      id = 12,
      name = "objects",
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
          name = "npc",
          type = "",
          shape = "point",
          x = 840,
          y = 150,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "wall",
            ["text1"] = "* I Am the Statue Guardian.[wait:5]\n* Why am I all the way out here you ask?",
            ["text2"] = "* ... [wait:5]Eh.",
            ["text3"] = "* I got tired of guarding that statue after a while."
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
          id = 4,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 80,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "4_4th_sanctuary/fourth_sanctum_5",
            ["marker"] = "entry2"
          }
        },
        {
          id = 30,
          name = "gueienemy",
          type = "",
          shape = "point",
          x = 520,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "guei",
            ["animation"] = "chase",
            ["chase"] = true,
            ["chase_once"] = true,
            ["chaseaccel"] = 1.05,
            ["chasemax"] = 100,
            ["chasespeed"] = 1,
            ["chasetype"] = "multiplier",
            ["encounter"] = "balthizard",
            ["pacetype"] = "horizontalswing",
            ["swinglength"] = 80
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "objects_lightarea",
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
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 760,
          width = 755.284,
          height = 920,
          rotation = 0,
          gid = 883,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.25,
            ["light_color"] = "#ffffffff",
            ["light_dust"] = true,
            ["light_type"] = 1
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = -160,
          y = 760,
          width = 755.284,
          height = 920,
          rotation = 0,
          gid = 2147484531,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.25,
            ["light_color"] = "#ffffffff",
            ["light_dust"] = true,
            ["light_type"] = 1
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 1,
          name = "texturescroller",
          type = "",
          shape = "point",
          x = 222.333,
          y = -48.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "hsv"
          }
        },
        {
          id = 2,
          name = "filter",
          type = "",
          shape = "point",
          x = 29.3333,
          y = -26.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "hsv3"
          }
        }
      }
    }
  }
}
