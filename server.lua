--executeSQLQuery("DROP TABLE Sistema_Guardado")
executeSQLQuery("CREATE TABLE IF NOT EXISTS Sistema_Guardado (Nombre TEXT, Cuenta TEXT, posX INT, posY INT, posZ INT, Apariencia INT, Fondos INT, Salud INT, Interior INT, Dimension INT, Armas INT, Ocupacion INT, Empleo INT, Horas INT, Minutos INT)")

function getPlayerINFO(player)
    accName = getAccountName(getPlayerAccount(player))
    query = executeSQLQuery("SELECT * FROM Sistema_Guardado WHERE Cuenta = ?", accName)
    return query
end

function playerLogin()
    if  not (isGuestAccount (getPlayerAccount (source))) then
        local accName = getAccountName(getPlayerAccount(source))
        if (accName) then
            query = executeSQLQuery("SELECT * FROM Sistema_Guardado WHERE Cuenta = ?", accName)
            if (#query == 0) then
                spawnPlayer (source,  -1547.1318359375, -439.8125, 6, 0, 0, 0, 0)
                local setMoney = math.random(15000,20000)
                setPlayerMoney (source, setMoney)
                exports['[TO]Notificaciones']:sendMessage("La economía aquí no es tan efectiva, tienes en total $"..setMoney,source,255,255,255,11)
                setElementData(source,"Ocupación","Jugador")
                setElementData(source,"TOUtils.job","None")
                setCameraTarget (source)
                setElementData(source,"TOUtils.skin",0)
                setElementData( source, "TOJobs.utilsGreen", false)
                executeSQLQuery("INSERT INTO Sistema_Guardado VALUES ('nil','"..accName.."','0','0','0','0','0','100','0','0','0','Jugador','None','0','0')")
                setElementData(source,"TOUtils.acc",accName)	
                executeSQLQuery("INSERT INTO Sistema_Vehiculos VALUES ('"..accName.."','1','510','5000','255','255','255','255','255','255','255','255','255','3','1000','0','1000')")
                setTimer(triggerClientEvent,50,1,source,"showWindowSkin",source)
                setTimer(setPedStat,50,1,source,24,1000)
                setTimer(setPedStat,50,1,source,70,1000)
                setTimer(setPedStat,50,1,source,71,1000)
                setTimer(setPedStat,50,1,source,72,1000)
                setTimer(setPedStat,50,1,source,74,1000)
                setTimer(setPedStat,50,1,source,76,1000)
                setTimer(setPedStat,50,1,source,77,1000)
                setTimer(setPedStat,50,1,source,78,1000)
                setTimer(setPedStat,50,1,source,79,1000)
                setTimer(setPedStat,50,1,source,229,1000)
                setTimer(setPedStat,50,1,source,230,1000)
                setTimer(setElementHealth,50,1,source, 200)
                setTimer(toggleControl,50,1,player,"forwards",true)
                setTimer(toggleControl,50,1,player,"backwards",true)
                setTimer(toggleControl,50,1,player,"left",true)
                setTimer(toggleControl,50,1,player,"right",true)
            else
                local me = getPlayerINFO(source)
                playerX = me[1].posX
                playerY = me[1].posY
                playerZ = me[1].posZ
                playerSkin = me[1].Apariencia
                playerInterior = me[1].Interior
                playerDimension = me[1].Dimension
                playerMoney = me[1].Fondos
                playerHealth = me[1].Salud
                playerWeapons = me[1].Armas
                playerOccupation = me[1].Ocupacion
                playerJob = me[1].Empleo
                playerName = me[1].Nombre
                spawnPlayer (source, playerX, playerY, playerZ +1, 0, playerSkin, playerInterior, playerDimension)
                setElementData( source, "TOJobs.utilsGreen", false)
                setPlayerMoney (source, playerMoney)
                setElementHealth (source, playerHealth)
                giveWeapons(source, playerWeapons)
                setElementData(source,"Ocupación",playerOccupation)
                setElementData(source,"TOUtils.job",playerJob)
                setElementData(source,"TOUtils.skin",playerSkin)
                setElementData(source,"TOUtils.acc",accName)	
                setCameraTarget (source)
                setTimer(setPedStat,50,1,source,24,1000)
                setTimer(setPedStat,50,1,source,70,1000)
                setTimer(setPedStat,50,1,source,71,1000)
                setTimer(setPedStat,50,1,source,72,1000)
                setTimer(setPedStat,50,1,source,74,1000)
                setTimer(setPedStat,50,1,source,76,1000)
                setTimer(setPedStat,50,1,source,77,1000)
                setTimer(setPedStat,50,1,source,78,1000)
                setTimer(setPedStat,50,1,source,79,1000)
                setTimer(setPedStat,50,1,source,229,1000)
                setTimer(setPedStat,50,1,source,230,1000)
                setTimer(setElementHealth,50,1,source, 200)
                setTimer(toggleControl,50,1,source,"forwards",true)
                setTimer(toggleControl,50,1,source,"backwards",true)
                setTimer(toggleControl,50,1,source,"left",true)
                setTimer(toggleControl,50,1,source,"right",true)
            end   
        end
    end
end
addEventHandler ("onPlayerLogin", getRootElement(), playerLogin)
addEvent ("TOUtils.logLast", true)
addEventHandler ("TOUtils.logLast", root, playerLogin)


function onQuitSave()
    if not (isGuestAccount(getPlayerAccount(source))) then
        local accName = getAccountName(getPlayerAccount(source))
        if (accName) then
            local data = getElementData(source,"theftop.mystery")
            if data then
                takeWeapon(source,tonumber(data))
            end
            local x,y,z = getElementPosition (source)
            local money = getPlayerMoney(source)
            local int = getElementInterior(source)
            local dim = getElementDimension(source)
            local hp = getElementHealth(source)
            local occ = getElementData(source,"Ocupación")
            local weapons = convertWeapons(source)
            local job = getElementData(source,"TOUtils.job")
            local model = getElementData(source,"TOUtils.skin")
            query = executeSQLQuery("SELECT * FROM Sistema_Guardado WHERE Cuenta = ?", accName)
            if (#query == 0) then
                executeSQLQuery("INSERT INTO Sistema_Guardado VALUES ('nil','"..accName.."','"..x.."','"..y.."','"..z.."','"..model.."','"..money.."','"..hp.."','"..int.."','"..dim.."','"..weapons.."','"..occ.."','"..job.."','0','0')")
            else
                executeSQLQuery("UPDATE Sistema_Guardado SET Nombre = 'nil',posX = '"..x.."',posY = '"..y.."',posZ = '"..z.."',Apariencia = '"..model.."',Fondos = '"..money.."',Salud = '"..hp.."',Interior = '"..int.."',Dimension = '"..dim.."',Armas = '"..weapons.."',Ocupacion= '"..occ.."',Empleo= '"..job.."' WHERE Cuenta= '"..accName.."'")
            end
        end
    end
    
end
addEventHandler ("onPlayerQuit", root, onQuitSave)
addEvent ("TOUtils.quitSave", true)
addEventHandler ("TOUtils.quitSave", root, onQuitSave)

function onStop()
    for k, v in ipairs (getElementsByType("player")) do
        if not (isGuestAccount (getPlayerAccount (v))) then
            triggerEvent ("TOUtils.quitSave", v)
        end
    end
end
addEventHandler ("onResourceStop", resourceRoot, onStop)


function convertWeapons(player)
    local weaponSlots = 12
    local weaponsTable = {}
    for slot=1, weaponSlots do
        local weapon = getPedWeapon( source, slot )
        local ammo = getPedTotalAmmo( source, slot )
        if (weapon > 0 and ammo > 0) then
            weaponsTable[weapon] = ammo
        end
    end
    return toJSON(weaponsTable)
end

function giveWeapons(player, weapons)
    if (weapons and weapons ~= "") then
        for weapon, ammo in pairs(fromJSON(weapons)) do
            if (weapon and ammo) then
                giveWeapon(player, tonumber(weapon), tonumber(ammo))
            end
        end
    end
end

function triggerHealth()
    local me = getPlayerINFO(source)
    health = me[1].Salud
    setElementHealth(source,health)
end
addEvent("TORegistry.triggerHealth",true)
addEventHandler("TORegistry.triggerHealth",root,triggerHealth)



addEventHandler("onPlayerJoin",root,
function()
    spawnPlayer (source, 0, 0, 9.5, 0)
    fadeCamera(source,false)
end
)

