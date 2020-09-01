local FiryoSecurity = {}
FiryoSecurity.Config = {}

FiryoSecurity.Config.Texts = {
    PlayerConnected = "se connecte avec un Garry's Mod en partage familial",
    OwnerBanned = "Compte utilisé pour bypass son ban avec le compte : ",
    PlayerBanned = "Tentative de bypass son ban avec le compte : ",
}

hook.Add("PlayerInitialSpawn", "Firyo:Security:SharedFamilyCheck", function(ply)
    local licenseOwnerSteam64 = ply:OwnerSteamID64()
    local licenseOwnerSteamID = util.SteamIDFrom64(licenseOwnerSteam64)

    if (ply:SteamID64() ~= licenseOwnerSteam64 ) then
        ply:ConCommand("say @" .. ply:Nick() .. "[" .. ply:SteamID() .. "] : " .. FiryoSecurity.Config.Texts.PlayerConnected)

        if ( ULib.bans[licenseOwnerSteamID] ) then
            ULib.addBan( licenseOwnerSteamID, 0, FiryoSecurity.Config.Texts.OwnerBanned .. ply:SteamID64(), ply:Nick() ) -- Ban the owner of the liscence

            ULib.addBan( ply:SteamID(), 0, FiryoSecurity.Config.Texts.PlayerBanned .. licenseOwnerSteam64, ply:Nick() ) -- Ban the account that use a shared family liscence
        end

    end

end)
