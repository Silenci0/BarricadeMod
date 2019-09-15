#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

#define PLUGIN_VERSION "1.0"

// Barricade strings for getting large/small cades
new String:LARGE_BARRICADE[128] = "models/zp_props/barricades/barricade_large.mdl";
new String:SMALL_BARRICADE[128] = "models/zp_props/barricades/barricade_small.mdl"; 

// Handles n' Globals m8
new Handle:cvar_Enabled = INVALID_HANDLE;
new Handle:cvar_BarricadeHealth = INVALID_HANDLE;
new Handle:gEntRefArray = INVALID_HANDLE;
new Handle:gCheckCadeTimer = INVALID_HANDLE;
new bool:gEnabled = true;
new gBarricadeHealth = 1;

public Plugin:myinfo = 
{
    name = "[ZPS] Barricade Mod",
    author = "Mr.Silence",
    description = "Changes barricade health and removes ability to pick them up once set.",
    version = PLUGIN_VERSION,
    url = "https://github.com/Silenci0/"
};

// Load what we need on plugin start
public OnPluginStart() 
{
    // Create Convars
    CreateConVar("sm_barricademod_version", PLUGIN_VERSION, "Barricade Mod version.", FCVAR_DONTRECORD|FCVAR_CHEAT|FCVAR_NOTIFY);
    cvar_Enabled = CreateConVar("sm_barricademod_enabled", "1", "Turns Barricade Mod On/Off. (1/0)", FCVAR_PROTECTED, true, 0.0, true, 1.0);
    cvar_BarricadeHealth = CreateConVar("sm_barricademod_health", "1000", "Changes the health value of barricades. Default = 1000", FCVAR_PROTECTED, true, 0.0, false);
    
    // Grab input variables from the configs
    gBarricadeHealth = GetConVarInt(cvar_BarricadeHealth);
    gEnabled = GetConVarBool(cvar_Enabled);
    
    // Create a config file for the plugin
    AutoExecConfig(true, "plugin.barricademod");	
    
    HookConVarChange(cvar_BarricadeHealth, BarricadeConVars);
    HookConVarChange(cvar_Enabled, BarricadeConVars);
}

// Hooks all convar changes that may occur
public BarricadeConVars(Handle:convar, const String:oldValue[], const String:newValue[]) 
{
    if (convar == cvar_Enabled)
    {
        gEnabled = GetConVarBool(cvar_Enabled);
    }
    
    if (convar == cvar_BarricadeHealth)
    {
        gBarricadeHealth = GetConVarInt(cvar_BarricadeHealth);
    }
}

// Loads up our array and convars based on what we have in the configs
public OnConfigsExecuted()
{
    // Grab input variables from the configs
    gBarricadeHealth = GetConVarInt(cvar_BarricadeHealth);
    gEnabled = GetConVarBool(cvar_Enabled);
    
    // Create our array
    gEntRefArray = CreateArray(64);
}

// Our timer/barricade hunting method. It runs on Map start with a repeat timer.
public Action:Timer_CheckBarricades(Handle:timer, any:client)
{
    decl String:EdictClassName[32];
    for (new i = 0; i <= GetEntityCount(); i++)
    {
        if (IsValidEntity(i))
        {
            GetEdictClassname(i, EdictClassName, sizeof(EdictClassName));
            if (StrEqual(EdictClassName, "prop_physics"))
            {
                // Get our entity reference if its prop physics
                new entRef = EntIndexToEntRef(i);
                
                // Get our model string, find out if we are using large/small barricades,
                decl String:bcModel[128];
                GetEntPropString(i, Prop_Data, "m_ModelName", bcModel, sizeof(bcModel));
                if (StrEqual(bcModel, SMALL_BARRICADE) && FindValueInArray(gEntRefArray, entRef) == -1)
                {
                    // Give health to the Small Barricade. We double it so that barricades have more health.
                    new iDblBarriHealth = gBarricadeHealth*2;
                    //LogMessage("Found an small cade (%s) entity! Give it %i health!", EdictClassName, iDblBarriHealth);
                    //LogMessage("Entity Reference #: %s", entRef);
                    SetEntProp(i, Prop_Data, "m_iHealth", iDblBarriHealth);
                    PushArrayCell(gEntRefArray, entRef);
                }
                if (StrEqual(bcModel, LARGE_BARRICADE) && FindValueInArray(gEntRefArray, entRef) == -1)
                {
                    // Give health to the Large Barricade
                    //LogMessage("Found a large cade (%s) entity! Give it %i health!", EdictClassName, gBarricadeHealth);
                    //LogMessage("Entity Reference #: %s", entRef);
                    SetEntProp(i, Prop_Data, "m_iHealth", gBarricadeHealth);
                    PushArrayCell(gEntRefArray, entRef);
                }
            }
        }
    }
}

// If we find a prop_physics entity, hook it and then call on our BlockPickUp method
public OnEntityCreated(entity, const String:classname[])
{
    if(gEnabled)
    {
        if(StrEqual(classname, "prop_physics"))
        {
            SDKHook(entity, SDKHook_Use, BlockPickup);
        }
    }
}

// This will block all use command once hooked to the barricades
public Action:BlockPickup(entity)
{
    decl String:cadeModel[128];
    GetEntPropString(entity, Prop_Data, "m_ModelName", cadeModel, sizeof(cadeModel));
    if (StrEqual(cadeModel, SMALL_BARRICADE))
    {
        //LogMessage("You can't pick up small cades!");
        return Plugin_Handled;    
    }
    if (StrEqual(cadeModel, LARGE_BARRICADE))
    {
        //LogMessage("You can't pick up large cades!");
        return Plugin_Handled;    
    }
    return Plugin_Continue;
}

// Create timer on map start. It will repeat indefinitely until:
// a.) Map end
// b.) Plugin Reload (which will restart the timer)
public OnMapStart()
{
    if(gEnabled)
    {
        CreateTimer(1.0, Timer_CheckBarricades, _, TIMER_REPEAT);
    }
}

// Clean up all of our resources at the end of the map!
public OnMapEnd()
{
    // Clearing adt_array.
    if(gEntRefArray != INVALID_HANDLE)
    {
        ClearArray(gEntRefArray);
        CloseHandle(gEntRefArray);
        gEntRefArray = INVALID_HANDLE;
    }
    
    // Kill the timer, we don't want it to carry over.
    if(gCheckCadeTimer != INVALID_HANDLE)
    {
        KillTimer(gCheckCadeTimer);
        CloseHandle(gCheckCadeTimer);
        gCheckCadeTimer = INVALID_HANDLE;   
    }
}