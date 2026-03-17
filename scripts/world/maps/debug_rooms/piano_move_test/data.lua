return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 15,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 47,
  properties = {
    ["music"] = "smallpiano_room"
  },
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 91,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 289,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 15,
      height = 12,
      id = 5,
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
        631, 560, 560, 560, 560, 560, 560, 631, 560, 560, 560, 560, 560, 560, 631,
        637, 560, 553, 560, 560, 553, 560, 637, 560, 553, 560, 560, 553, 560, 637,
        643, 560, 559, 560, 560, 559, 560, 643, 560, 559, 560, 560, 559, 560, 643,
        661, 560, 565, 560, 560, 565, 560, 661, 560, 565, 560, 560, 565, 560, 661,
        655, 566, 566, 566, 566, 566, 566, 655, 566, 566, 566, 566, 566, 566, 655,
        100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
        100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
        100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
        118, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 118,
        0, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 0,
        0, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 0,
        0, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_switches",
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
          id = 30,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["downonce"] = true,
            ["group"] = "hint2",
            ["keepdown"] = true,
            ["npcpress"] = false,
            ["offsound"] = 0,
            ["onsound"] = 0
          }
        },
        {
          id = 31,
          name = "churchtilebutton",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["downonce"] = true,
            ["group"] = "hint",
            ["keepdown"] = true,
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
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 395,
          y = 240,
          width = 90,
          height = 66,
          rotation = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "piano",
          type = "",
          shape = "rectangle",
          x = 395,
          y = 200,
          width = 90,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "piano.door",
            ["destroyhints"] = false,
            ["solution"] = "000111333111"
          }
        },
        {
          id = 9,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 334,
          y = 60,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "hint2",
            ["hint"] = "000111",
            ["staff"] = "start"
          }
        },
        {
          id = 10,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 334,
          y = 100,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "hint2",
            ["hint"] = "333111",
            ["silent"] = true,
            ["staff"] = "end"
          }
        },
        {
          id = 21,
          name = "piano",
          type = "",
          shape = "rectangle",
          x = 115,
          y = 200,
          width = 90,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["destroyhints"] = true,
            ["destroyswitches"] = false,
            ["solution"] = "131315"
          }
        },
        {
          id = 22,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 54,
          y = 80,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "hint",
            ["hint"] = "131",
            ["staff"] = "start"
          }
        },
        {
          id = 23,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 80,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["group"] = "hint",
            ["hint"] = "315",
            ["silent"] = true,
            ["staff"] = "end"
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 115,
          y = 240,
          width = 90,
          height = 66,
          rotation = 0,
          gid = 8,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "npc",
          type = "",
          shape = "point",
          x = 300,
          y = 225,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "lobbyman",
            ["text"] = "* Fuck you i wont leave unless i hear some MUSIC"
          }
        },
        {
          id = 41,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "debug_rooms/piano_light_test",
            ["marker"] = "entry"
          }
        },
        {
          id = 43,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "debug_rooms/piano_big_test",
            ["marker"] = "entry2"
          }
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
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 320,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 440,
          width = 520,
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
          x = 0,
          y = 320,
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
          name = "spawn",
          type = "",
          shape = "point",
          x = 459,
          y = 260,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "entry2",
          type = "",
          shape = "point",
          x = 560,
          y = 265,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "entry",
          type = "",
          shape = "point",
          x = 20,
          y = 260,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
