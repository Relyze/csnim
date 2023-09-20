# csnim

This is a basic external cs:go cheat coded in nim. **This is NOT VAC safe, we are directly opening a handle to the game, and reading the process memory and writing to it. Not only this, but we are writing to the player's glow/outline structure, which **will** flag you.

This is **not** a great example of an external, and the structure isn't very good either, but I made it in 2 hours with very little knowledge of nim.

However, it does of course utilize reading and writing structs to reduce the number of RPMs and WPMs used, which should moderately increase performance.
I might find time to further develop this, however I am busy with university, and will not have very much free time to spend on this.

thank you to [qb-0](https://github.com/qb-0) for the [nimem](https://github.com/qb-0/Nimem) lib. I didn't have to use this, but I saw it on github and was made me want to learn a little nim.

Compile via 
> nim c main.nim
