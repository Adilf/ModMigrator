remote.addinterface("ModMigrator",{
    make_chapter=function(modname) make_chapter(modname) end,
    store=function(modname,variables) store(modname,variables) end,
    fetch=function(modname) fetch(modname) end,
})

function make_chapter(modname)
--function takes string modname adds according chapter to global to allow 
--variables to be stored there
--modname is not tied to any actual name, but probably it's wise to assign the name of
--migration target to it.
--function should be called once per migration
--if there's already such chapter present it will assume 
--that the other save migration of same mod is not yet finished and will error
    if not global[modname] then
        global[modname]={}
    else
        print('Error:   '..modname.." is already being migrated.\nFinish previous migration and reload the ModMigrator to start new one")
        game.players[1].print('Error:   '..modname.." is already being migrated.\nFinish previous migration and reload the ModMigrator to start new one")
    end
end
function store(modname,variables)
--stores variables in modname
--variables should be table with fieldnames corresponding to variable names in mod:
--variables['entities']=enities
--the function can be called several times during one migration
--the function will prevent overwriting of previously stored variables

    --first we need to verify there's no clashes in names
    local errored=false
    for n in pairs(variables) do
        if global[modname][n] then
            message("Error:\n"..n.." has already been exported in mod:\n"..
                modname.."\nVerify your migration code")
            errored=true
        end
    end
    if errored then return end
    --then we store variables
    for n,v in pairs(variables) do
        global[modname][n]=v;
    end
end
function fetch(modname)
--returns the stored variables to asking mod
    return global[modname]
end
function message(strin)
--prints strin wherever it can
print(strin)
game.players[1].pritn(strin)
end
