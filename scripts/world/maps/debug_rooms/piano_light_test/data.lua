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
  nextobjectid = 64,
  properties = {
    ["music"] = "darkchurch_intro"
  },
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "libraryexcerpt",
      firstgid = 91,
      filename = "../../../tilesets/libraryexcerpt.tsx",
      exportfilename = "../../../tilesets/libraryexcerpt.lua"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 139,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 32,
      height = 12,
      id = 8,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 0, 0, 0, 271, 271, 271, 271, 271,
        271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271,
        271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271, 271
      }
    },
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
        410, 410, 410, 410, 410, 481, 517, 518, 519, 553, 517, 518, 519, 553, 517, 518, 519, 481, 410, 410, 410, 410, 410, 481, 411, 411, 411, 481, 410, 410, 410, 410,
        410, 410, 403, 410, 410, 487, 523, 524, 525, 559, 523, 524, 525, 559, 523, 524, 525, 487, 410, 410, 403, 410, 410, 487, 411, 411, 411, 487, 410, 410, 403, 410,
        410, 410, 409, 410, 410, 493, 529, 530, 531, 565, 529, 530, 531, 565, 529, 530, 531, 493, 410, 410, 409, 410, 410, 493, 411, 411, 411, 493, 410, 410, 409, 410,
        410, 410, 415, 410, 410, 511, 535, 536, 537, 577, 535, 536, 537, 577, 535, 536, 537, 511, 410, 410, 415, 410, 410, 511, 411, 411, 411, 511, 410, 410, 415, 410,
        416, 416, 416, 416, 416, 505, 547, 548, 549, 583, 547, 548, 549, 583, 547, 548, 549, 505, 416, 416, 416, 416, 416, 505, 212, 212, 212, 505, 416, 416, 416, 416,
        212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212,
        212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212,
        212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212, 212,
        589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 589, 212, 212, 212, 589, 589, 589, 589, 589,
        619, 620, 621, 622, 0, 0, 0, 619, 620, 621, 622, 0, 0, 0, 619, 620, 621, 622, 0, 0, 619, 620, 621, 622, 589, 589, 589, 619, 620, 621, 622, 0,
        625, 626, 627, 628, 0, 0, 0, 625, 626, 627, 628, 0, 0, 0, 625, 626, 627, 628, 0, 0, 625, 626, 627, 628, 574, 0, 574, 625, 626, 627, 628, 0,
        631, 632, 633, 634, 0, 0, 0, 631, 632, 633, 634, 0, 0, 0, 631, 632, 633, 634, 0, 0, 631, 632, 633, 634, 580, 0, 580, 631, 632, 633, 634, 0
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
          id = 10,
          name = "spawn",
          type = "",
          shape = "point",
          x = 100,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "light2",
          type = "",
          shape = "point",
          x = 540,
          y = 122,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "light3",
          type = "",
          shape = "point",
          x = 698,
          y = 122,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "light4",
          type = "",
          shape = "point",
          x = 940,
          y = 122,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "light5",
          type = "",
          shape = "point",
          x = 1100,
          y = 122,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "light1",
          type = "",
          shape = "point",
          x = 380,
          y = 122,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["size"] = 96
          }
        }
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
          id = 54,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 160,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 120,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 960,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 960,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 320,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 360,
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
      id = 5,
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
          id = 32,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["downonce"] = true,
            ["flagcheck"] = "!pianotest",
            ["group"] = "hint",
            ["keepdown"] = true,
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 33,
          name = "steelcage",
          type = "",
          shape = "rectangle",
          x = 1200,
          y = 74,
          width = 58,
          height = 246,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!pianotest"
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
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 368,
          y = 146,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {
            ["color"] = "#ff808080"
          }
        },
        {
          id = 5,
          name = "lighttrigger",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "light2"
          }
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 528,
          y = 146,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {
            ["color"] = "#ff808080"
          }
        },
        {
          id = 13,
          name = "lighttrigger",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "light3"
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 686,
          y = 146,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "lighttrigger",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["marker1"] = "light4",
            ["marker2"] = "light5"
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 146,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "piano",
          type = "",
          shape = "rectangle",
          x = 980,
          y = 160,
          width = 90,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "pianotest",
            ["solution"] = "131315"
          }
        },
        {
          id = 21,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 400,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!pianotest",
            ["group"] = "hint",
            ["hint"] = "131",
            ["light"] = true,
            ["once"] = true,
            ["staff"] = "start"
          }
        },
        {
          id = 22,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 1040,
          y = 400,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!pianotest",
            ["group"] = "hint",
            ["hint"] = "315",
            ["light"] = true,
            ["once"] = true,
            ["silent"] = true,
            ["staff"] = "end"
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 980,
          y = 200,
          width = 90,
          height = 66,
          rotation = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "staticlight",
          type = "",
          shape = "point",
          x = 220,
          y = 122,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["size"] = 96
          }
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 146,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "staticlight",
          type = "",
          shape = "point",
          x = 1320,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["size"] = 160
          }
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 146,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "lighttrigger",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "light1"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 44,
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
            ["flagcheck"] = "!pianotest",
            ["highlight"] = false
          }
        }
      }
    }
  }
}
