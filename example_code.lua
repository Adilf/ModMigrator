--here lay examples of code that should be placed in 
--the FinalUpdate of OldMod (see readme) and in the NewMod

--this one is good while we still have on_save event
--OldMod
game.on_save(function()
    --mod's own code
    --...
    --migration
    remote.call("ModMigrator","make_chapter","Nat_Ev_En")--begin transition process for one of new modules (enemies)
    remote.call("ModMigrator","store","Nat_Ev_En",{ArtifactCollectors=global.ArtifactCollectors})--pack values 
    --transitions for other modules may take place below    
end)
--NewMod
game.on_load(function()
    --mod's own code
    --...
    --migration
    if remote.interfaces.ModMigrator and not global.updated then
        temp=remote.call("ModMigrator","fetch","Nat_Ev_En")
        if temp and temp.ArtifactCollectors then
            global.ArtifactCollectors= temp.ArtifactCollectors
            global.next_check=game.tick+interval
            global.next_collector= 1
            global.updated=true
            if global.itemCollectors ~= nil then
                game.on_event(defines.events.on_tick, function(event) ticker(event.tick) end)
            end
        end
    end
end)
