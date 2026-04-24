return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 13,
  nextobjectid = 47,
  properties = {
    ["border"] = "none",
    ["music"] = "alt_church_lobby"
  },
  tilesets = {
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 1,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "church_objects",
      firstgid = 199,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 302,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    },
    {
      name = "bg_dw_library_tileset_new",
      firstgid = 884,
      filename = "../../../tilesets/bg_dw_library_tileset_new.tsx"
    },
    {
      name = "ExtraCarpetTiles",
      firstgid = 1714,
      filename = "../../../tilesets/ExtraCarpetTiles.tsx",
      exportfilename = "../../../tilesets/ExtraCarpetTiles.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
      name = "objects_parallax",
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
          id = 43,
          name = "spires",
          type = "",
          shape = "rectangle",
          x = -160,
          y = 1560,
          width = 640,
          height = 1600,
          rotation = 0,
          opacity = 1,
          gid = 203,
          visible = true,
          properties = {
            ["HasProphecyEffect"] = true,
            ["color"] = "#ff4b61a3"
          }
        },
        {
          id = 44,
          name = "spires",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 480,
          width = 640,
          height = 1600,
          rotation = 0,
          opacity = 1,
          gid = 3221225675,
          visible = true,
          properties = {
            ["HasProphecyEffect"] = true,
            ["color"] = "#ff4b61a3"
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
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 320,
          width = 40,
          height = 160,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 280,
          width = 40,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 160,
          width = 40,
          height = 120,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 80,
          width = 160,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 160,
          width = 40,
          height = 120,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 280,
          width = 40,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 320,
          width = 40,
          height = 160,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 37, 38, 39, 41, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 37, 1717, 48, 48, 1716, 41, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 46, 48, 47, 48, 48, 50, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 55, 1715, 47, 48, 1714, 59, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 64, 55, 56, 57, 59, 64, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 73, 65, 66, 67, 68, 73, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 74, 75, 76, 77, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          id = 7,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 10,
      name = "objects_below",
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
          name = "churchmagicglass",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 320,
          width = 80,
          height = 160,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["idlealpha"] = 0,
            ["starthidden"] = true
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
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["map"] = "fractured_sanctuary/fractured_3",
            ["marker"] = "entry"
          }
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 260,
          y = 220,
          width = 142,
          height = 126,
          rotation = 0,
          opacity = 1,
          gid = 296,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "objects_rain",
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
          id = 40,
          name = "undertale_rain_spawner",
          type = "",
          shape = "point",
          x = 0,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["spawn_rate"] = 0.25
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects_top",
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
          name = "prophecy",
          type = "",
          shape = "point",
          x = 320,
          y = 182,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["alwaysvisible"] = true,
            ["fade_edges"] = true,
            ["no_back"] = true,
            ["panel_h"] = 86,
            ["panel_w"] = 101,
            ["texture"] = "tree_top",
            ["txt_offx"] = -157,
            ["txt_offy"] = -30
          }
        },
        {
          id = 5,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 290,
          y = 190,
          width = 50,
          height = 30,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["cutscene"] = "events.egg_tree",
            ["solid"] = true
          }
        },
        {
          id = 6,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 160,
          width = 20,
          height = 20,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["cutscene"] = "events.egggive",
            ["solid"] = true
          }
        }
      }
    }
  }
}
