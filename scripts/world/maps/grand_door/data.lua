return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 25,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 13,
  nextobjectid = 57,
  properties = {
    ["border"] = "",
    ["music"] = "grand_bells",
    ["name"] = "Entrance to Grand Sanctum"
  },
  tilesets = {
    {
      name = "bg_dw_church_library_2_tileset",
      firstgid = 1,
      filename = "../../tilesets/bg_dw_church_library_2_tileset.tsx"
    },
    {
      name = "church_objects",
      firstgid = 261,
      filename = "../../tilesets/church_objects.tsx",
      exportfilename = "../../tilesets/church_objects.lua"
    },
    {
      name = "light_areas",
      firstgid = 292,
      filename = "../../tilesets/light_areas.tsx"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 302,
      filename = "../../tilesets/bg_dw_church_tileset_new.tsx"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects_parallax",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 25,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        851, 851, 851, 851, 851, 851, 851, 851, 851, 851, 851, 851, 851, 851, 851, 851,
        434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434,
        434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434,
        434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434,
        434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434,
        434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434,
        434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434,
        434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434, 434,
        0, 0, 0, 0, 0, 0, 171, 163, 162, 174, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 171, 172, 173, 184, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 171, 173, 173, 174, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 191, 173, 193, 174, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 201, 202, 171, 173, 173, 194, 202, 203, 0, 0, 0, 0,
        0, 0, 0, 0, 171, 173, 173, 173, 173, 173, 173, 174, 0, 0, 0, 0,
        0, 0, 0, 0, 171, 173, 184, 0, 0, 181, 162, 184, 0, 0, 0, 0,
        0, 0, 0, 0, 181, 172, 173, 173, 173, 173, 183, 194, 0, 0, 0, 0,
        0, 0, 0, 0, 191, 173, 183, 173, 173, 173, 193, 174, 0, 0, 0, 0,
        0, 0, 0, 0, 221, 222, 191, 173, 172, 194, 222, 223, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 181, 172, 162, 184, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 171, 173, 173, 174, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "objects_tile",
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
          id = 47,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 250,
          width = 140,
          height = 40,
          rotation = 0,
          gid = 434,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 490,
          y = 250,
          width = 150,
          height = 40,
          rotation = 0,
          gid = 434,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "objects_closeddoor",
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
          name = "",
          type = "",
          shape = "rectangle",
          x = 134,
          y = 520,
          width = 360,
          height = 310,
          rotation = 0,
          gid = 280,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "objects_opendoor",
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
          name = "",
          type = "",
          shape = "rectangle",
          x = 134,
          y = 520,
          width = 360,
          height = 310,
          rotation = 0,
          gid = 281,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
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
          id = 30,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 1000,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "0_base_sanctum/base_fast_travel",
            ["marker"] = "entry_grand"
          }
        },
        {
          id = 31,
          name = "cameratarget",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 440,
          width = 160,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["lockx"] = true,
            ["locky"] = true,
            ["marker"] = "targ",
            ["time"] = 1
          }
        },
        {
          id = 32,
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 300,
          y = 760,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 480,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "* (It's locked...)[wait:5]\n* (Seems like you need a lot of [color:9999ff]Dark Shards[color:reset]...)"
          }
        },
        {
          id = 54,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 440,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "finale.entry",
            ["once"] = false
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects_lightareas",
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
          name = "darkness",
          type = "",
          shape = "point",
          x = 0,
          y = 240,
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
          id = 53,
          name = "",
          type = "",
          shape = "rectangle",
          x = 210,
          y = 1050,
          width = 220,
          height = 860,
          rotation = 0,
          gid = 294,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 10,
      name = "objects_top",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 520,
          width = 80,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 520,
          width = 80,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "polygon",
          x = 240,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 50, y = -20 },
            { x = 50, y = -40 },
            { x = 0, y = -40 }
          },
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "polygon",
          x = 400,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -40 },
            { x = -50, y = -40 },
            { x = -50, y = -20 }
          },
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 200,
          width = 160,
          height = 270,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 720,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 880,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 880,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 720,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 760,
          width = 80,
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
          id = 13,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 840,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "entry_ft",
          type = "",
          shape = "point",
          x = 320,
          y = 960,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "targ",
          type = "",
          shape = "point",
          x = 320,
          y = 320,
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
      name = "controllers",
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
