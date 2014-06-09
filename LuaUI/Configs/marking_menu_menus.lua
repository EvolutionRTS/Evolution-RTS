local menu_ecommander = {
  items = {
  {
    angle = 0,
    unit = "emetalextractor",
    label = "Economy",
    items = {
      {
        angle = 45,
        unit = "esolar2"
      },
    }
  },
  {
    angle = -45,
    unit = "ebasefactory",
    label = "Facs",
    items = {
      {
        angle = 90,
        unit = "eairplant"
      },
      
    }
  },
 }
}
local menu_use = {
  ecommander = menu_ecommander,
}

return menu_use
