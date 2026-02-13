return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 44,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 16,
  nextobjectid = 56,
  properties = {
    ["music"] = "bell_ambience"
  },
  tilesets = {
    {
      name = "church_objects",
      firstgid = 1,
      filename = "../../tilesets/church_objects.tsx",
      exportfilename = "../../tilesets/church_objects.lua"
    },
    {
      name = "bg_dw_church_tileset_new",
      firstgid = 32,
      filename = "../../tilesets/bg_dw_church_tileset_new.tsx"
    },
    {
      name = "light_areas",
      firstgid = 614,
      filename = "../../tilesets/light_areas.tsx"
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
      objects = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 44,
      height = 12,
      id = 10,
      name = "tiles_bg",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 450, 450, 450, 450, 450, 450, 450, 450, 450, 450, 450, 450, 470, 450, 450, 450, 450, 450, 450, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        410, 411, 412, 410, 411, 412, 410, 411, 412, 410, 411, 412, 410, 411, 412, 410, 411, 412, 470, 450, 470, 450, 450, 470, 450, 470, 410, 411, 412, 410, 411, 412, 410, 411, 412, 410, 411, 412, 410, 411, 412, 410, 411, 412
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 44,
      height = 12,
      id = 9,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 444, 444, 444, 0, 0, 0, 0, 0, 0, 444, 444, 444, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 384, 408, 408, 111, 111, 111, 111, 111, 111, 408, 408, 409, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444, 444,
        508, 508, 111, 409, 111, 111, 111, 111, 111, 508, 509, 111, 409, 509, 508, 111, 408, 506, 408, 111, 111, 111, 111, 111, 111, 408, 506, 408, 111, 508, 111, 111, 509, 509, 409, 111, 111, 111, 111, 111, 509, 508, 111, 509,
        482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 409, 408, 507, 506, 408, 408, 408, 508, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482, 482,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 421, 482, 482, 482, 482, 482, 482, 482, 482, 419, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_piano",
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
          id = 15,
          name = "pianobig",
          type = "",
          shape = "rectangle",
          x = 860,
          y = 300,
          width = 50,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {
            ["resetmus"] = true,
            ["solution"] = "aoamcdbaaoaebcdeeeeeacbnaaocdeeeeefghgfecaoamcdbaklji"
          }
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 402,
          width = 322,
          height = 382,
          rotation = 0,
          gid = 10,
          visible = true,
          properties = {}
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
          id = 49,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 1240,
          y = 360,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["once"] = false,
            ["script"] = "wicabel_jumpscare"
          }
        },
        {
          id = 55,
          name = "",
          type = "",
          shape = "rectangle",
          x = 845,
          y = 320,
          width = 70,
          height = 30,
          rotation = 0,
          gid = 31,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "objects_lightarea",
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
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 800,
          width = 120,
          height = 720,
          rotation = 0,
          gid = 616,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 720,
          width = 240,
          height = 720,
          rotation = 0,
          gid = 616,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 800,
          width = 120,
          height = 720,
          rotation = 0,
          gid = 616,
          visible = true,
          properties = {
            ["light"] = true,
            ["light_alpha"] = 0.1,
            ["light_color"] = "#ffffffff",
            ["light_type"] = 1
          }
        },
        {
          id = 39,
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
            ["alpha"] = 0.5,
            ["highlight"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 14,
      name = "objects_bell_btm",
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
          x = 1296,
          y = 114,
          width = 124,
          height = 126,
          rotation = 0,
          gid = 23,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 15,
      name = "objects_bell",
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
          id = 50,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1344,
          y = 100,
          width = 28,
          height = 14,
          rotation = 0,
          gid = 24,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1317,
          y = 110,
          width = 84,
          height = 120,
          rotation = 0,
          gid = 25,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 13,
      name = "objects_bell_top",
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
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1296,
          y = 114,
          width = 124,
          height = 126,
          rotation = 0,
          gid = 22,
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
          id = 43,
          name = "spawn",
          type = "",
          shape = "point",
          x = 200,
          y = 390,
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
      id = 3,
      name = "collision",
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
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 640,
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
          x = 640,
          y = 280,
          width = 480,
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
          x = 1120,
          y = 320,
          width = 640,
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
          x = 1040,
          y = 400,
          width = 720,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 440,
          width = 320,
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
          x = 0,
          y = 400,
          width = 720,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
