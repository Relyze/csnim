import math, colors

type
  Vec2* = object
    x*, y*: float32

  Vec3* = object
    x*, y*, z*: float32

  Rgb* = tuple
    r, g, b: float32


#[
  misc
]#

proc newRgb*(r, g, b: float32): Rgb =
  result.r = r
  result.g = g
  result.b = b

proc color*(color: string): Rgb =
  try:
    var c = parseColor(color).extractRGB()
    result.r = c.r.float32
    result.g = c.g.float32
    result.b = c.b.float32
  except:
    result = newRgb(0, 0, 0)

#[
  vector
]#

proc Vector*(x: float32, y: float32): Vec2 =
  Vec2(x: x, y: y)
proc Vector*(x: float32, y: float32, z: float32): Vec3 =
  Vec3(x: x, y: y, z: z)

proc `+`*(self: Vec2, v: Vec2): Vec2 =
  Vec2(x: self.x + v.x, y: self.y + v.y)
proc `+`*(self: Vec3, v: Vec3): Vec3 =
  Vec3(x: self.x + v.x, y: self.y + v.y, z: self.z + v.z)
proc `+`*(self: Vec2, v: float32): Vec2 =
  Vec2(x: self.x + v, y: self.y + v)
proc `+`*(self: Vec3, v: float32): Vec3 =
  Vec3(x: self.x + v, y: self.y + v, z: self.z + v)

proc `+=`*(self: var Vec2, v: float32) =
  self.x = self.x + v
  self.y = self.y + v
proc `+=`*(self: var Vec3, v: float32) =
  self.x = self.x + v
  self.y = self.y + v
  self.z = self.z + v
proc `+=`*(self: var Vec2, v: Vec2) =
  self.x = self.x + v.x
  self.y = self.y + v.y
proc `+=`*(self: var Vec3, v: Vec3) =
  self.x = self.x + v.x
  self.y = self.y + v.y
  self.z = self.z + v.z

proc `-`*(self: Vec2, v: Vec2): Vec2 =
  Vec2(x: self.x - v.x, y: self.y - v.y)
proc `-`*(self: Vec3, v: Vec3): Vec3 =
  Vec3(x: self.x - v.x, y: self.y - v.y, z: self.z - v.z)
proc `-`*(self: Vec2, v: float32): Vec2 =
  Vec2(x: self.x - v, y: self.y - v)
proc `-`*(self: Vec3, v: float32): Vec3 =
  Vec3(x: self.x - v, y: self.y - v, z: self.z - v)

proc `-=`*(self: var Vec2, v: float32) =
  self.x = self.x - v
  self.y = self.y - v
proc `-=`*(self: var Vec3, v: float32) =
  self.x = self.x - v
  self.y = self.y - v
  self.z = self.z - v
proc `-=`*(self: var Vec2, v: Vec2) =
  self.x = self.x - v.x
  self.y = self.y - v.y
proc `-=`*(self: var Vec3, v: Vec3) =
  self.x = self.x - v.x
  self.y = self.y - v.y
  self.z = self.z - v.z

proc `*`*(self: Vec2, v: Vec2): Vec2 =
  Vec2(x: self.x * v.x, y: self.y * v.y)
proc `*`*(self: Vec3, v: Vec3): Vec3 =
  Vec3(x: self.x * v.x, y: self.y * v.y, z: self.z * v.z)
proc `*`*(self: Vec2, v: float32): Vec2 =
  Vec2(x: self.x * v, y: self.y * v)
proc `*`*(self: Vec3, v: float32): Vec3 =
  Vec3(x: self.x * v, y: self.y * v, z: self.z * v)

proc `*=`*(self: var Vec2, v: float32) =
  self.x = self.x * v
  self.y = self.y * v
proc `*=`*(self: var Vec3, v: float32) =
  self.x = self.x * v
  self.y = self.y * v
  self.z = self.z * v
proc `*=`*(self: var Vec2, v: Vec2) =
  self.x = self.x * v.x
  self.y = self.y * v.y
proc `*=`*(self: var Vec3, v: Vec3) =
  self.x = self.x * v.x
  self.y = self.y * v.y
  self.z = self.z * v.z

proc `/`*(self: Vec2, v: Vec2): Vec2 =
  Vec2(x: self.x / v.x, y: self.y / v.y)
proc `/`*(self: Vec3, v: Vec3): Vec3 =
  Vec3(x: self.x / v.x, y: self.y / v.y, z: self.z / v.z)
proc `/`*(self: Vec2, v: float32): Vec2 =
  Vec2(x: self.x / v, y: self.y / v)
proc `/`*(self: Vec3, v: float32): Vec3 =
  Vec3(x: self.x / v, y: self.y / v, z: self.z / v)

proc `/=`*(self: var Vec2, v: float32) =
  self.x = self.x / v
  self.y = self.y / v
proc `/=`*(self: var Vec3, v: float32) =
  self.x = self.x / v
  self.y = self.y / v
  self.z = self.z / v
proc `/=`*(self: var Vec2, v: Vec2) =
  self.x = self.x / v.x
  self.y = self.y / v.y
proc `/=`*(self: var Vec3, v: Vec3) =
  self.x = self.x / v.x
  self.y = self.y / v.y
  self.z = self.z / v.z

proc magSq*(self: Vec2): float32 =
  (self.x * self.x) + (self.y * self.y)
proc magSq*(self: Vec3): float32 =
  (self.x * self.x) + (self.y * self.y) + (self.z * self.z)

proc mag*(self: Vec2): float32 =
  sqrt(self.magSq())
proc mag*(self: Vec3): float32 =
  sqrt(self.magSq())

proc dist*(self: Vec2, v: Vec2): float32 =
  mag(self - v)
proc dist*(self: Vec3, v: Vec3): float32 =
  mag(self - v)

proc normalize*(self: var Vec2) =
  self /= self.mag()
proc normalize*(self: var Vec3) =
  self /= self.mag()

proc perpendicular*(self: Vec2): Vec2 =
  result.x = -self.y
  result.y = self.x
