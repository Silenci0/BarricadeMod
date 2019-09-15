# BarricadeMod
ZPS Plugin that modifies barricade health. Yes, its real and its now available, for free, with no strings attached (outside of the GPLv3 License, which has been provided in the repository).

My former protege, Kana, created the plugin that Vertigo Gaming used for the longest time on their Lake server. At the time, I simply gave her the entity type of the barricades used (which were prop_physics entities back in ZPS 2.4.1) and told her to look for the names of the barricades. Once found, the entity could be manipulated and its health changed. As a result, the plugin was created. 

Eventually, the code was given to me and I simply maintained it until those servers were no more. Seeing as how none of the people involved at the time are around/active in ZPS now and Kana no longer cares about any of this stuff, I figured I'd release the source code and wash my hands of this thing. It was simply a waste just sitting around on my harddrive never being used. I'm sure someone could find a use for it. However, whether or not it works is another story completely as it hasn't been tested in ZPS 3.0 and beyond. However, for anyone entertprising enough, just know that manipulating the barricades in ZPS is a trival thing and it can easily be done just like it was in this plugin.

As for the plugin itself, it is a really simple mod. Large barricades have normal health while Small barricades recieve x2 health, much like the game's established mechanics. The plugin generates its own configuration file with the health cvar added to it. However, due to how this plugin works, you cannot pick up the barricade once it has been placed due to it resetting the health of the barricade. Also, you do not want to reload the plugin while its running as it will break the timer that controls the monitoring of barricade health so it won't work properly on current/new barricades that get put down. 

As for future features, I believe the following were supposed to have been implemented, but neither Kana nor I had the time to do so:

* Picking up the barricade and putting it back down would not reset health.
* Barricades could be used on top of one another. 

I'm sure there was others, but I cannot remember them now. Anyway, feel free to use the plugin/code on your ZPS server if you want.