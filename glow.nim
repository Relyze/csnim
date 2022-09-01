import globals, nimem

proc glowEntity*(e: ptr Entity) {.discardable.} = 
    e.glow.rgba = [(1.0 - (e.health / 100)).float32, e.health / 100, 0, 0.75] # health based glow gradient
    e.glow.m_bRenderWhenOccluded = true
    e.glow.m_bRenderWhenUnoccluded = false
    e.glow.m_bFullBloomRender = false
    p.write((glowObjectManager + (e.glowIndex * 0x38)), e.glow)