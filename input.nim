import os, winim
import globals

proc mouseClick* =
    mouse_event(0x2, 0, 0, 0, 0)
    sleep(10)
    mouse_event(0x4, 0, 0, 0, 0)

proc getKeyDown*(vKey: VK): bool =
    if GetAsyncKeyState(cast[int32](vKey)).bool:
        return true
    return false
