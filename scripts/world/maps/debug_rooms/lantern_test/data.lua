return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 42,
  height = 26,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 84,
  properties = {},
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 99,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 297,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 1,
          name = "darkroombg",
          type = "",
          shape = "point",
          x = 40,
          y = 200,
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
      width = 42,
      height = 26,
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
        370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 376, 370, 376, 376, 376, 370, 370, 376, 370, 370, 370, 370, 370, 376, 370, 376, 376, 376,
        376, 376, 0, 0, 376, 370, 376, 370, 370, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 376, 370, 376, 376, 370, 376, 376, 370, 370, 370, 370, 370, 376, 370, 370, 376, 370,
        370, 370, 0, 0, 376, 376, 376, 370, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 376, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382,
        376, 370, 376, 376, 370, 376, 382, 382, 376, 370, 376, 370, 370, 376, 0, 0, 376, 376, 376, 370, 376, 370, 376, 370, 376, 370, 370, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        376, 370, 376, 376, 376, 376, 0, 0, 376, 376, 370, 376, 370, 376, 0, 0, 370, 370, 370, 370, 376, 376, 370, 376, 376, 370, 376, 370, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        382, 382, 382, 382, 370, 376, 370, 376, 376, 370, 382, 382, 376, 370, 0, 0, 370, 376, 382, 382, 382, 382, 382, 382, 382, 382, 382, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 370, 376, 370, 370, 370, 376, 0, 0, 376, 376, 370, 370, 370, 370, 370, 376, 376, 370, 370, 376, 370, 370, 370, 370, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 382, 382, 382, 382, 382, 382, 0, 0, 376, 370, 376, 370, 370, 370, 376, 376, 376, 376, 370, 376, 376, 370, 376, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 382, 382, 382, 382, 382, 370, 370, 382, 382, 382, 376, 376, 0, 382, 382, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 370, 0, 0, 0, 376, 370, 0, 0, 0, 370, 376, 370, 376, 376, 376, 370, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 370, 370, 370, 370, 376, 376, 0, 0, 0, 376, 370, 376, 370, 376, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 370, 370, 370, 370, 376, 376, 0, 0, 0, 382, 382, 382, 382, 382, 382, 382, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 376, 370, 376, 370, 376, 370, 370, 382, 382, 382, 376, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 376, 376, 376, 370, 376, 370, 376, 370, 0, 0, 0, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 370, 376, 376, 376, 376, 376, 370, 370, 376, 370, 382, 382, 382, 382, 376, 370, 0, 0, 0, 376, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 370, 376, 376, 370, 376, 370, 370, 376, 376, 370, 0, 0, 0, 0, 370, 376, 0, 0, 0, 376, 370, 0, 0, 0, 0, 0, 376, 376, 370, 376, 376, 376, 370, 376, 370, 0, 0, 0, 0,
        0, 0, 0, 382, 382, 382, 376, 376, 382, 382, 382, 376, 370, 0, 0, 0, 0, 370, 370, 0, 0, 0, 376, 370, 0, 0, 0, 0, 0, 376, 376, 376, 376, 370, 370, 370, 376, 370, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 370, 376, 0, 0, 0, 370, 376, 0, 0, 0, 0, 376, 376, 0, 0, 0, 376, 370, 0, 0, 0, 0, 0, 376, 370, 382, 382, 382, 382, 382, 370, 376, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 376, 370, 0, 0, 0, 370, 370, 0, 0, 0, 0, 370, 370, 370, 376, 370, 376, 376, 370, 370, 370, 370, 370, 376, 370, 376, 376, 370, 370, 370, 370, 370, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 370, 370, 376, 376, 376, 376, 376, 0, 0, 0, 0, 376, 376, 376, 370, 376, 370, 376, 370, 376, 376, 376, 370, 370, 376, 376, 370, 370, 376, 370, 376, 370, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 370, 376, 370, 376, 370, 370, 370, 0, 0, 0, 0, 376, 376, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 382, 376, 376, 382, 0, 0, 0, 0,
        370, 370, 370, 370, 370, 376, 376, 370, 382, 382, 382, 376, 370, 0, 0, 0, 0, 376, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 376, 370, 376, 376, 376, 370, 370,
        370, 376, 370, 370, 376, 370, 376, 370, 0, 0, 0, 376, 370, 376, 376, 376, 370, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 376, 370, 376, 370, 376, 376, 370,
        382, 382, 382, 382, 382, 382, 382, 382, 0, 0, 0, 370, 376, 370, 376, 376, 376, 370, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 382, 382, 382, 382, 382, 382, 382,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 382, 382, 382, 382, 382, 382, 382, 382, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 16,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 560,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 47,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 760,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 51,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 580,
          y = 500,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 52,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 720,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 53,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 1020,
          y = 720,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 82,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 840,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 83,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 580,
          y = 900,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern",
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
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
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 7,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 420,
          y = 860,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 18,
          name = "pathenemygen",
          type = "",
          shape = "point",
          x = 540,
          y = 860,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 2,
            ["movetype"] = 3,
            ["rate"] = 40,
            ["timer"] = 19
          }
        },
        {
          id = 19,
          name = "pathenemyender",
          type = "",
          shape = "point",
          x = 540,
          y = 380,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 540,
          y = 740,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 3
          }
        },
        {
          id = 25,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 300,
          y = 740,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 2
          }
        },
        {
          id = 26,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 300,
          y = 500,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 1
          }
        },
        {
          id = 30,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 180,
          y = 620,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 32,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 420,
          y = 380,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 34,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 420,
          y = 620,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 50,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 540,
          y = 500,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 2
          }
        },
        {
          id = 54,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 900,
          y = 380,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 55,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 900,
          y = 620,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 56,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 900,
          y = 860,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 57,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 120,
          y = 800,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 60,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 1200,
          y = 800,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 61,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 1140,
          y = 620,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 62,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 660,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 63,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 660,
          y = 740,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 64,
          name = "pathenemygen",
          type = "",
          shape = "point",
          x = 780,
          y = 860,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 2,
            ["movetype"] = 3,
            ["rate"] = 40,
            ["timer"] = 19
          }
        },
        {
          id = 65,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 780,
          y = 740,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 1
          }
        },
        {
          id = 66,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 1020,
          y = 740,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 2
          }
        },
        {
          id = 67,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 780,
          y = 500,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 2
          }
        },
        {
          id = 68,
          name = "pathenemyturner",
          type = "",
          shape = "point",
          x = 1020,
          y = 500,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["dir"] = 3
          }
        },
        {
          id = 69,
          name = "pathenemyender",
          type = "",
          shape = "point",
          x = 780,
          y = 380,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 78,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 120,
          y = 980,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
          }
        },
        {
          id = 81,
          name = "lanternshrinking",
          type = "",
          shape = "point",
          x = 1200,
          y = 980,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "lantern"
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
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "spawn",
          type = "",
          shape = "point",
          x = 60,
          y = 860,
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
      name = "objects_overlay",
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
          id = 9,
          name = "darkness",
          type = "",
          shape = "point",
          x = 0,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["alpha"] = 1,
            ["highlight"] = false
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "battleareas",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    }
  }
}
