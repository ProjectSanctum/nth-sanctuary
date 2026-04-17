return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 13,
  nextobjectid = 50,
  properties = {
    ["border"] = "none",
    ["music"] = "secret_sanctuary"
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
          x = 560,
          y = 1000,
          width = 480,
          height = 1200,
          rotation = -45,
          gid = 299,
          visible = true,
          properties = {
            ["HasProphecyEffect"] = true,
            ["color"] = "#ff530003"
          }
        },
        {
          id = 44,
          name = "spires",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 800,
          width = 480,
          height = 1200,
          rotation = -45,
          gid = 299,
          visible = true,
          properties = {
            ["HasProphecyEffect"] = true,
            ["color"] = "#ff530003"
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
          visible = true,
          properties = {
            ["map"] = "fractured_sanctuary/fractured_3",
            ["marker"] = "entry"
          }
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
          x = 80,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
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
          id = 49,
          name = "roomglow",
          type = "",
          shape = "point",
          x = 40,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["active"] = true,
            ["alpha"] = 0.75,
            ["darkness"] = "#ffc04040",
            ["highlight"] = "#40ffffff",
            ["shadow"] = false,
            ["tint"] = "#ffff8080"
          }
        }
      }
    }
  }
}
