return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 28,
  properties = {
    ["music"] = "smallpiano_room"
  },
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../tilesets/church_objects.tsx",
      exportfilename = "../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 11,
      filename = "../tilesets/bg_dw_church_2_tileset.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 160,
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
          x = 160,
          y = 120,
          width = 90,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "piano.door",
            ["solution"] = "000111333111"
          }
        },
        {
          id = 9,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 0,
          width = 120,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["hint"] = "000111",
            ["staff"] = "start"
          }
        },
        {
          id = 10,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 220,
          y = 0,
          width = 120,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["hint"] = "333111",
            ["staff"] = "end"
          }
        },
        {
          id = 21,
          name = "piano",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 120,
          width = 90,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["solution"] = "131315"
          }
        },
        {
          id = 22,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 280,
          width = 120,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["hint"] = "131",
            ["staff"] = "start"
          }
        },
        {
          id = 23,
          name = "pianohint",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 280,
          width = 120,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["hint"] = "315",
            ["staff"] = "end"
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 160,
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
          x = 80,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "lobbyman",
            ["text"] = "* Fuck you i wont leave unless i hear some MUSIC"
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
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 120,
          width = 40,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 250,
          y = 120,
          width = 30,
          height = 30,
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
          x = 280,
          y = 280,
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
