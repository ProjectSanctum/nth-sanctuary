return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 15,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 11,
  nextobjectid = 53,
  properties = {
    ["border"] = "church_a",
    ["music"] = "climb"
  },
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../../tilesets/church_objects.tsx",
      exportfilename = "../../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_2_tileset",
      firstgid = 110,
      filename = "../../tilesets/bg_dw_church_2_tileset.tsx"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 308,
      filename = "../../tilesets/bg_dw_church_tileset_new.tsx",
      exportfilename = "../../tilesets/bg_dw_church_tileset_new.lua"
    },
    {
      name = "bg_dw_dither_overlay_tileset",
      firstgid = 890,
      filename = "../../tilesets/bg_dw_dither_overlay_tileset.tsx"
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
        0, 0, 0, 0, 119, 119, 119, 119, 119, 119, 119, 0, 0, 0, 0,
        0, 0, 0, 0, 119, 119, 119, 119, 119, 119, 119, 0, 0, 0, 0,
        0, 0, 0, 0, 119, 119, 119, 119, 119, 119, 119, 0, 0, 0, 0,
        0, 0, 0, 0, 119, 119, 119, 119, 119, 119, 119, 0, 0, 0, 0,
        0, 0, 0, 0, 119, 119, 119, 119, 119, 119, 119, 0, 0, 0, 0,
        0, 0, 0, 0, 119, 119, 119, 119, 119, 119, 119, 0, 0, 0, 0,
        0, 0, 0, 0, 137, 119, 119, 119, 119, 119, 137, 0, 0, 0, 0,
        0, 0, 0, 0, 818, 137, 119, 119, 119, 137, 820, 0, 0, 0, 0,
        0, 0, 0, 0, 824, 818, 119, 119, 119, 820, 826, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 824, 137, 137, 137, 826, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 818, 819, 820, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 824, 825, 826, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 15,
      height = 12,
      id = 10,
      name = "decal",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 899, 0, 0, 0, 0, 0, 899, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 899, 0, 0, 0, 899, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 899, 899, 899, 0, 0, 0, 0, 0, 0
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
          id = 21,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 330,
          width = 40,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "events2.noelletest",
            ["solid"] = true
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
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 0,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "",
          type = "",
          shape = "polygon",
          x = 120,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 80, y = 0 },
            { x = 80, y = 40 },
            { x = 120, y = 40 },
            { x = 120, y = 160 },
            { x = 0, y = 160 }
          },
          properties = {}
        },
        {
          id = 50,
          name = "",
          type = "",
          shape = "polygon",
          x = 360,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -120 },
            { x = 40, y = -120 },
            { x = 40, y = -160 },
            { x = 120, y = -160 },
            { x = 120, y = 0 }
          },
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 360,
          width = 120,
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
          x = 300,
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
