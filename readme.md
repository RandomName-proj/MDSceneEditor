A Level editor for Sega Mega Drive games. 

## Implemented Features
- Scene viewer that is easily adaptable to effects such as palette cycling and HBlank water(like in Classic Sonic Trilogy)
- Loading/Saving compressed files (thanks to mdcomp) 
- Loading most of the data from the levels in Classic Sonic Trilogy\* (Palette, Art, PLCs, Object Layout, Object Mappings, Plane Tiles, Plane Blocks, Plane Chunks, Plane Layout)
- Modular scene loading system that allows custom loaders for all data types (all script files are stored in: "user/formatters")
- Loading multiple scenes in one window
- Loading data from labels/offsets from the rom (currently asm68k only(without linker) but AS support isn't hard to implement)

## Future plans
- Revamping the scene json format
- Merging Chunk and Block data classes into one Tilemap data class
- Implementing Editing
- Support for Special Stages from Classic Sonic Trilogy\* (at least from Sonic 1)
- Support for other MD games
- Optimizing Tile Rendering (it is the main cause of high RAM usage) 

\* Classic Sonic Trilogy - Sonic 1,2,3, CD

## Current state of development

Currently the project is on an indefinite hiatus. However, I will read issues and pull requests if anyone needs help with figuring out the code or how to use the editor  

## Credits

Flamewing - mdcomp


