return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 45,
  properties = {},
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../../tilesets/church_objects.tsx",
      exportfilename = "../../tilesets/church_objects.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 9,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          name = "light",
          type = "",
          shape = "point",
          x = 542,
          y = 250,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "light2",
          type = "",
          shape = "point",
          x = 700,
          y = 250,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "light3",
          type = "",
          shape = "point",
          x = 860,
          y = 250,
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
            ["flagcheck"] = "!pianotest",
            ["group"] = "hint",
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
          y = 60,
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
          id = 1,
          name = "staticlight",
          type = "",
          shape = "point",
          x = 382,
          y = 250,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["size"] = 96
          }
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 370,
          y = 274,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "lighttrigger",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 0,
          width = 40,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "light"
          }
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 530,
          y = 274,
          width = 26,
          height = 36,
          rotation = 0,
          gid = 86,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "lighttrigger",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 10,
          width = 40,
          height = 470,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "light2"
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 688,
          y = 274,
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
          y = 0,
          width = 40,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "light3"
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 848,
          y = 274,
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
          y = 40,
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
          y = 40,
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
          x = 222,
          y = 250,
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
          x = 210,
          y = 274,
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
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["size"] = 160
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
