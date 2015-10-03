This mod provides tools for custom migration of data between different versions of the mod.


Development happens. Sometimes you may rebuild you code completelly, 
sometimes you decide to split mod into several. 
Such cases are beyond comprehension of standard mod migration algorithm.
And yet sometimes you need to provide means for players to smothly move 
away from previous versions to newer.

This mod
    implements those means by providing intermittent storage for global variables,
    that might be of use in newer version.
    It is only needed during the migration process, after the new version runs smoothly
    it can be disabled.

Here's how it should work:
    Along with release of your NewMod (for example modular version of OldMod)
    you release the FinalUpdate to OldMod.
    In that FinalUpdate version you put calls to interface functions of ModMigrator.
    Though those interface functions the data which is meaningful for the NewMod will 
    be temporarily stored in global of ModMigrator.
    The player which wants to upgrade his save first installs that FinalUpdate version,
    it transfers the data to ModMigrator. (As of 12.10 this can be performed during on_save event)
    Then player saves and exits the game, unplugs the OldMod and installs the NewMod 
    reloads the game and finally loads the migrating save.
    The NewMod should also have code that uses interface to ModMigrator in order 
    to obtain and incorporate migrated data.
    After all the data is migrated, the ModMigrator can be unplugged.
    This will clear the intermittent storage.
    To migrate several saves player should 
    disable the ModMigrator after finishing transition of single save, reload game,
    enable the ModMigrator and perform the migration of next save.

What needs to be migrated:
    Whatever data you store in global for your mod to work.
    For example a table of entities, that you keep track of.

What doesn't need be migrated:
    Entities you don't track. If your mod used to add some new entity which 
    simply works by game rules, it should transfer seamlessly if player simply 
    unplugs old mod and plugs new one that adds the same entity.
