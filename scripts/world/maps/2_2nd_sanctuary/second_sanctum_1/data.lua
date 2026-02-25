return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 22,
  height = 28,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 14,
  nextobjectid = 95,
  parallaxorigin = {
    x = -320,
    y = -240
  },
  properties = {
    ["border"] = "church_b",
    ["music"] = "second_church",
    ["name"] = "Second Sanctuary"
  },
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
      name = "church_objects",
      firstgid = 781,
      filename = "../../../tilesets/church_objects.tsx",
      exportfilename = "../../../tilesets/church_objects.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
      name = "objects_parallax3",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.3,
      parallaxy = 0.82,
      properties = {},
      objects = {
        {
          id = 77,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 416,
          height = 130,
          rotation = 90,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 79,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 410,
          width = 416,
          height = 130,
          rotation = 90,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 80,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 820,
          width = 416,
          height = 130,
          rotation = 90,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 81,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 0,
          width = 416,
          height = 130,
          rotation = 90,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 82,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 410,
          width = 416,
          height = 130,
          rotation = 90,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        },
        {
          id = 83,
          name = "",
          type = "",
          shape = "rectangle",
          x = 630,
          y = 820,
          width = 416,
          height = 130,
          rotation = 90,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff00007f"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "objects_parallax2",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.4,
      parallaxy = 0.85,
      properties = {},
      objects = {
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = -240,
          y = 240,
          width = 640,
          height = 200,
          rotation = 0,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 240,
          width = 640,
          height = 200,
          rotation = 0,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = -240,
          y = 760,
          width = 640,
          height = 200,
          rotation = 0,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 760,
          width = 640,
          height = 200,
          rotation = 0,
          gid = 793,
          visible = true,
          properties = {
            ["color"] = "#ff2525ba"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_parallax",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.5,
      parallaxy = 0.9,
      properties = {},
      objects = {
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = -280,
          y = 1120,
          width = 640,
          height = 1600,
          rotation = -315,
          gid = 785,
          visible = true,
          properties = {}
        },
        {
          id = 65,
          name = "",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 1080,
          width = 640,
          height = 1600,
          rotation = -45,
          gid = 785,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "objects_shadow",
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
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 1120,
          width = 900,
          height = 880,
          rotation = 270,
          gid = 789,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 22,
      height = 28,
      id = 11,
      name = "tiles_osc_optimize",
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
        0, 0, 0, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 776, 776, 776, 776, 776, 776, 776, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 10,
      name = "objects_osc",
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
          id = 41,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 120,
          width = 320,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "texturescroller",
          type = "",
          shape = "point",
          x = 60,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "hsv"
          }
        },
        {
          id = 54,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 240,
          width = 280,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 640,
          width = 240,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "tile_oscillate",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 920,
          width = 320,
          height = 120,
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
      width = 22,
      height = 28,
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
        0, 0, 0, 80, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 718, 737, 738, 739, 718, 0, 0,
        0, 0, 0, 80, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 754, 746, 747, 748, 754, 0, 0,
        0, 0, 0, 80, 80, 756, 756, 756, 756, 756, 756, 0, 0, 0, 0, 718, 746, 747, 748, 718, 0, 0,
        0, 0, 0, 80, 752, 751, 770, 599, 599, 769, 593, 669, 0, 0, 0, 727, 746, 747, 748, 727, 0, 0,
        0, 0, 0, 770, 599, 599, 760, 778, 761, 599, 769, 678, 669, 0, 0, 736, 746, 747, 748, 736, 0, 0,
        0, 0, 0, 610, 610, 610, 610, 610, 610, 610, 610, 687, 678, 669, 756, 745, 755, 756, 757, 745, 0, 0,
        0, 0, 0, 0, 709, 710, 711, 712, 709, 0, 0, 696, 687, 678, 616, 617, 618, 80, 80, 80, 592, 0,
        0, 0, 0, 0, 718, 719, 720, 721, 718, 0, 0, 0, 696, 687, 625, 626, 627, 80, 80, 80, 592, 0,
        0, 0, 0, 0, 718, 728, 729, 730, 718, 0, 0, 0, 0, 696, 634, 635, 636, 584, 585, 586, 592, 0,
        0, 0, 0, 0, 718, 737, 738, 739, 718, 0, 0, 0, 0, 0, 80, 80, 80, 593, 594, 595, 751, 0,
        0, 0, 0, 0, 754, 746, 747, 748, 754, 0, 0, 0, 0, 0, 80, 80, 80, 80, 80, 599, 760, 0,
        0, 0, 0, 0, 718, 746, 747, 748, 718, 0, 0, 0, 0, 670, 80, 80, 80, 752, 751, 770, 769, 0,
        0, 0, 0, 0, 727, 746, 747, 748, 727, 0, 0, 0, 670, 679, 80, 80, 770, 599, 599, 760, 761, 0,
        0, 0, 0, 0, 736, 746, 747, 748, 736, 0, 0, 670, 679, 688, 610, 610, 610, 610, 610, 610, 610, 0,
        0, 0, 0, 0, 745, 755, 756, 757, 745, 756, 670, 679, 688, 697, 0, 709, 710, 711, 712, 709, 0, 0,
        0, 0, 0, 0, 602, 603, 605, 584, 585, 613, 679, 688, 697, 0, 0, 718, 719, 720, 721, 718, 0, 0,
        0, 0, 0, 0, 611, 612, 80, 593, 594, 595, 688, 697, 0, 0, 0, 718, 728, 729, 730, 718, 0, 0,
        0, 0, 0, 0, 80, 714, 715, 587, 717, 80, 697, 0, 0, 0, 0, 718, 737, 738, 739, 718, 0, 0,
        0, 0, 0, 0, 80, 723, 724, 725, 726, 80, 0, 0, 0, 0, 0, 754, 746, 747, 748, 754, 0, 0,
        0, 0, 0, 0, 80, 732, 733, 734, 735, 80, 669, 0, 0, 0, 0, 718, 746, 747, 748, 718, 0, 0,
        0, 0, 0, 0, 80, 741, 742, 743, 744, 80, 678, 669, 0, 0, 0, 727, 746, 747, 748, 727, 0, 0,
        0, 0, 0, 0, 610, 610, 610, 610, 610, 610, 687, 678, 669, 0, 0, 736, 746, 747, 748, 736, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 696, 687, 678, 669, 756, 745, 755, 756, 757, 745, 756, 756,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 696, 687, 678, 80, 589, 590, 591, 759, 760, 761, 762,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 696, 687, 80, 598, 599, 600, 768, 769, 770, 771,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 696, 80, 607, 608, 609, 777, 778, 779, 780,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 610, 610, 610, 610, 610, 610, 610, 610,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 80,
          y = 0,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 0,
          width = 280,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 200,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 240,
          width = 40,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 520,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 560,
          width = 280,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 600,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 320,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "polygon",
          x = 560,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -160, y = 160 },
            { x = -160, y = 0 }
          },
          properties = {}
        },
        {
          id = 68,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 880,
          width = 310,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 840,
          width = 280,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 71,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 1040,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 84,
          name = "",
          type = "",
          shape = "polygon",
          x = 400,
          y = 760,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 160, y = 160 },
            { x = 160, y = 0 }
          },
          properties = {}
        },
        {
          id = 88,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 200,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 89,
          name = "",
          type = "",
          shape = "polygon",
          x = 440,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 120, y = 120 },
            { x = 120, y = 0 }
          },
          properties = {}
        },
        {
          id = 90,
          name = "",
          type = "",
          shape = "polygon",
          x = 440,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 120, y = 120 },
            { x = 0, y = 120 }
          },
          properties = {}
        },
        {
          id = 91,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 680,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 92,
          name = "",
          type = "",
          shape = "polygon",
          x = 400,
          y = 680,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 160, y = -160 },
            { x = 160, y = 0 }
          },
          properties = {}
        },
        {
          id = 93,
          name = "",
          type = "",
          shape = "polygon",
          x = 400,
          y = 840,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 160, y = 160 },
            { x = 0, y = 160 }
          },
          properties = {}
        },
        {
          id = 94,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 1000,
          width = 40,
          height = 80,
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
          id = 18,
          name = "entry",
          type = "",
          shape = "point",
          x = 160,
          y = 60,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "entry2",
          type = "",
          shape = "point",
          x = 800,
          y = 1000,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "spawn",
          type = "",
          shape = "point",
          x = 480,
          y = 570,
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
          id = 19,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 120,
          y = -40,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "2_2nd_sanctuary/second_sanctum_0_ripple_post",
            ["marker"] = "entry"
          }
        },
        {
          id = 38,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 700,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 700,
          y = 840,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "enemy",
          type = "",
          shape = "point",
          x = 680,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "winglade",
            ["chase"] = "true",
            ["encounter"] = "winglade"
          }
        },
        {
          id = 61,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 920,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "2_2nd_sanctuary/second_sanctum_2",
            ["marker"] = "entry"
          }
        },
        {
          id = 66,
          name = "window_glow",
          type = "",
          shape = "point",
          x = 260,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "savepoint",
          type = "",
          shape = "point",
          x = 360,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* (You find yourself in a familiar sanctuary...)",
            ["text2"] = "* (You're filled with the power of liminal nostalgia.)"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects_overlay",
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
          id = 22,
          name = "churchfog",
          type = "",
          shape = "point",
          x = 40,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "filter",
          type = "",
          shape = "point",
          x = 50,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "hsv"
          }
        }
      }
    }
  }
}
