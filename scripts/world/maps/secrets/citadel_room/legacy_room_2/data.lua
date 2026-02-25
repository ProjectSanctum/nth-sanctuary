return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 11,
  properties = {
    ["music"] = "greenroom_detune"
  },
  tilesets = {
    {
      name = "bg_ch3_dw_teevie_land_tileset",
      firstgid = 1,
      filename = "../../../../tilesets/teevie_land.tsx"
    },
    {
      name = "church_objects",
      firstgid = 157,
      filename = "../../../../tilesets/church_objects.tsx",
      exportfilename = "../../../../tilesets/church_objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 12,
      id = 1,
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
        0, 0, 0, 0, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 0,
        0, 0, 0, 0, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 0,
        0, 0, 0, 62, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 66,
        0, 0, 0, 68, 69, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 71, 72,
        0, 0, 0, 74, 75, 46, 46, 46, 46, 46, 46, 20, 21, 20, 21, 20, 21, 46, 77, 78,
        3, 3, 3, 4, 75, 46, 46, 46, 46, 46, 46, 26, 27, 26, 27, 26, 27, 46, 77, 78,
        9, 9, 9, 10, 75, 46, 46, 46, 46, 46, 46, 20, 21, 20, 21, 20, 21, 46, 77, 78,
        15, 15, 15, 16, 75, 46, 46, 46, 46, 46, 46, 26, 27, 26, 27, 26, 27, 46, 77, 78,
        20, 21, 20, 21, 75, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 83, 84,
        26, 27, 26, 27, 0, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 83, 84,
        0, 0, 0, 0, 59, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 60, 90,
        0, 0, 0, 0, 0, 33, 28, 33, 33, 33, 33, 28, 33, 33, 33, 33, 28, 33, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 12,
      id = 5,
      name = "tiles2",
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
        0, 0, 0, 0, 38, 39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 30, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 29,
        0, 0, 0, 0, 50, 51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 56, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 119, 52, 52, 52, 117, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 74, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 74, 75, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 102, 64, 64, 64, 98, 75, 0, 0, 0,
        0, 0, 0, 74, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 80, 81, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 0, 0,
        0, 0, 0, 86, 87, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 0, 0,
        0, 0, 42, 0, 35, 35, 35, 35, 35, 0, 0, 0, 0, 0, 36, 36, 36, 36, 36, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 120,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 760,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 120,
          width = 40,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 80,
          width = 600,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 280,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 120,
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
          id = 6,
          name = "spawn",
          type = "",
          shape = "point",
          x = 40,
          y = 360,
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
          id = 7,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 530,
          y = 220,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "dummy",
            ["encounter"] = "mad_dummy"
          }
        },
        {
          id = 8,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 320,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "secrets/citadel_room/legacy_room_1",
            ["marker"] = "entry"
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 260,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 183,
          visible = true,
          properties = {
            ["solid"] = "true",
            ["text1"] = "* \"THE BATTLE SCENE\"",
            ["usetile"] = true
          }
        }
      }
    }
  }
}
