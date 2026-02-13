return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 18,
  properties = {},
  tilesets = {
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 1,
      filename = "../../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../../tilesets/bg_dw_church_tileset_new.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 583,
      filename = "../../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "light_areas",
      firstgid = 781,
      filename = "../../../tilesets/light_areas.tsx"
    }
  },
  layers = {
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
        529, 530, 531, 529, 530, 531, 529, 530, 530, 531, 529, 530, 531, 529, 530, 531,
        535, 536, 537, 535, 536, 537, 535, 536, 536, 537, 535, 536, 537, 535, 536, 537,
        541, 542, 543, 541, 542, 543, 541, 542, 542, 543, 541, 542, 543, 541, 542, 543,
        0, 0, 0, 0, 0, 0, 175, 176, 177, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 91, 92, 93, 0, 181, 182, 183, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 97, 98, 99, 0, 187, 188, 189, 211, 212, 213, 214, 0, 0, 0,
        0, 0, 103, 104, 105, 0, 193, 194, 195, 217, 218, 219, 220, 0, 0, 0,
        0, 0, 109, 110, 111, 0, 199, 200, 201, 223, 224, 225, 226, 0, 0, 0,
        0, 0, 115, 116, 117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601,
        601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601, 601,
        610, 610, 610, 610, 610, 610, 610, 610, 610, 610, 610, 610, 610, 610, 610, 610
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
          id = 4,
          name = "npc",
          type = "",
          shape = "point",
          x = 520,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ddelta",
            ["text1"] = "* testing the lighting system here",
            ["text2"] = "* light type 2/4 is always full-bright",
            ["text3"] = "* light type 3/5 acts kinda like darkness but is brighter\nthan the actual darkness",
            ["text4"] = "* use light types 4 and 5 if you don't want it to draw additively as well"
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
      id = 5,
      name = "objects_lightareas",
      class = "",
      visible = true,
      opacity = 0.5,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 6,
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
            ["highlight"] = true
          }
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 480,
          width = 80,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 480,
          width = 40,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 480,
          width = 80,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 480,
          width = 40,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 480,
          width = 80,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 480,
          width = 40,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 480,
          width = 80,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 4
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 480,
          width = 40,
          height = 480,
          rotation = 0,
          gid = 785,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.5,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 5
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "objects_overlay",
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
