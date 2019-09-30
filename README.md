# BarricadeMod
ZPS Plugin that modifies barricade health. Yes, its real and its now available, for free, with no strings attached (outside of the GPLv3 License, which has been provided in the repository). It has the following cvars:

- `sm_barricademod_enabled` - Turns Barricade Mod On/Off. Default value: "1"
- `sm_barricademod_health` - Changes the health value of barricades. Default = "1000"

The plugin itself is a really simple mod and it is by no means very elegant . The health cvar affects both Large and Small barricades with Large barricades having modified health while Small barricades recieve x2 modified health. The plugin generates its own configuration file with these cvars added to it. It is highly suggested that you test the health and determine if 1000 health is correct for you or not. 

Due to how this plugin works, you cannot pick up the barricade once it has been placed due to it resetting the health of the barricade. Also, you do not want to reload the plugin while its running as it will break the timer that controls the monitoring of barricade health so it won't work properly on current/new barricades that get put down. Finally, the plugin was compiled for use in Sourcemod 1.9 and, with any luck, it should still work. 

# Background

My former protege, Kana, created the plugin that Vertigo Gaming used for the longest time on their Lake server sometime in 2015. At the time, I simply gave her the entity type of the barricades used (which were prop_physics entities back in ZPS 2.4.1) and told her to look for the names of the barricades. Once found, the entity could be manipulated and its health changed. After some work on her part, it resulted in the plugin being created, though the source code for it was never released publicly.

Eventually, the code was given to me and I maintained it until those servers were no more. Seeing as how none of the people involved at the time are around/active in ZPS now (and probably don't care) and Kana no longer cares about anything ZPS related, I figured I'd release the source code for everyone to use/look at incase anyone was still interested in it. It was simply a waste just sitting around on my harddrive never being used and I'm sure someone could find a use for it. However, whether or not it works is another story completely as it hasn't been tested in ZPS 3.0 and beyond. However, for anyone entertprising enough, just know that manipulating the barricades in ZPS is a trival thing and it can easily be done just like it was in this plugin.

# Possible Features?

As for future features, I believe the following were supposed to have been implemented (or were something I thought of doing), but neither Kana nor I had the time to do so:

* Picking up the barricade and putting it back down would not reset health (configurable). This might require entity IDs and some array work to identify the board being placed.
* Adding a message like "You cannot pick up a barricade once it has been placed". This would be useful if the above is not possible OR if it is, but you'd rather have it configurable to make it possible to disable that.
* Adding a barricade "owner" feature that displays which barricade belongs to who (ie: who owns this barricade). This would be helpful to see which person placed the barricade and make it possible to add further features (if not a point system) that would help develop further features.
* Barricades could be used on top of one another (configurable). I don't think its an important feature, but I think it would rather cool. 
* Barricades could be placed on props directly (configurable). It would be similar to the option above but instead of just boards, it could be used on anything prop_physics_multiplayer to prop_static. 
* Make barricades unbreakable by humans. This would be good to help survivors from breaking their own barricades by stepping on them. only zombies could break them by doing that.
* Complete prop-damage immunity (configurable). Higher health does kind of make this possible, but I believe there is a way to manipulate it to not break when other props hit it while maintaining lower health. 
* Possible point system for barricades? It would be good to encourage the use of barricades in general which would help encourage barricading houses. This idea would need to be fleshed out more to deal with various caveats and abuses, but it would be a good feature to have, potentially. 
* Possible barricade ban? If someone was trolling or purposely wasting barricades, have a system (possibly linked/integrated into sourcebans in some way) to prevent problem players from picking up/using barricades. This is more of an administrative thing, though I could see the potential to create a "job" system where only people could with a certain job could actually place barricades if implemented another way. More of a "food for thought" feature than anything else.


At the moment thats all I could think of/come up with. Some of these were things that were going to be added, but never got the chance to do so, unfortunately. Again, if you and your community are enterprising enough, I'm sure you could implement most of the above. I know some of it is possible to do.

Anyway, feel free to use the plugin/code on your ZPS server if you want or use it however you like. All that I ask of you is to adhere to the license and share changes made to the plugin as appropriate. 
