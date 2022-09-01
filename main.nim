import os, tables, winim, strutils, times
import globals, input, glow, nimem

proc initEntity(address: ByteAddress, entity: ptr Entity): bool {.discardable.} =
  entity.address = address
  entity.crossId = p.read(address + Offsets.m_iCrosshairId, int32)
  entity.glowIndex = p.read(address + Offsets.m_iGlowIndex, int32)
  entity.dormant = p.read(address + Offsets.m_bDormant, bool)
  entity.health = p.read(address + Offsets.m_iHealth, int32)
  entity.team = p.read(address + Offsets.m_iTeamNum, int32)
  entity.glow = p.read(glowObjectManager + (entity.glowIndex * 0x38), Glow)
  entity.id = p.read(address + Offsets.m_iD, int32) 

  if entity.dormant: 
    return
  if entity.health <= 0:
    return

  result = true

proc signOnState(): uint32 {.discardable.} =
    var 
        clientState: uint32
        signOnState: uint32
    clientState = p.read(engine + Offsets.dwClientState, uint32)
    signOnState = p.read(cast[ByteAddress](clientState) + Offsets.dwClientState_State, uint32)
    return signOnState

proc cheatLoop =
    while true:
        #check if player is ingame, if not, then we sleep for 1500ms
        if signOnState() == 6:
            let localPlayer = p.read(client + Offsets.dwLocalPlayer, cint) # read dwLocalPlayer
            let entityList = p.read(client + Offsets.dwEntityList, array[256, cint]) # entity buffer
            glowObjectManager = p.read(client + Offsets.dwGlowObjectManager, cint) 
            if localPlayer <= 0: 
                return
            var local: Entity 
            initEntity(localPlayer, local.addr) #initialize localplayer Entity
            for i in 1..63: # loop over entities, TODO: get max # of entities and loop instead of 63 maybe?
                let playerEntity = entityList[i * 4] # select entity from the buffer
                if playerEntity != 0 and playerEntity != localPlayer: # if the entity exists and is not the local player, initialize the entity, and apply glow
                    var entity: Entity
                    if initEntity(playerEntity, entity.addr):
                        if entity.team != local.team:
                            # we compare the crossId (the index of the entity within the entitylist that is in our crosshair) to our players indexes in the entitylist
                            if getKeyDown(VK.XBUTTON2) and local.crossId == entity.id:
                                mouseClick()
                            glowEntity(entity)
            sleep(5)
        else:
            sleep(1500)

when isMainModule:
    echo "initializing nimsgo..."
    try:
        # get the csgo process and dlls
        p = processByName("csgo.exe") 
        client = p.modules["client.dll"].baseaddr
        engine = p.modules["engine.dll"].baseaddr
    except:
        echo getCurrentExceptionMsg()
        quit(QuitFailure)
    
    echo "pid: 0x" & $p.pid.toHex(4) # obtain pid and print it
    echo "client.dll: 0x" & $client.toHex(8)
    echo "engine.dll: 0x" & $engine.toHex(8)
    echo "successfully initialized..."

    cheatLoop() # call our glow function

