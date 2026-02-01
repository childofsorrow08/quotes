# Quotes by Child of Sorrow

The sole purpose of this library is to display or obtain a random quote from those predefined in `src/quotes.asm`.

I know it doesn't make much sense and the library may seem rather strange (which it is), but I had fun figuring out how to output text directly through system calls, as well as how to get a random index to the array of quotes.

I also plan to use this in my other educational projects, so I decided to post it as a separate library on GitHub.

There is no point in suggesting additions or changes if they do not relate to the code. I will not accept other people's quotes. I will only add my own that I like.

I also cannot guarantee that quotes will be displayed on Windows. Obtaining them via `get_random_quote()` will definitely work, but displaying them will not. I don't have Windows on hand to test this, and I don't want to work with it, so this is all just theoretical.

# Dependencies: 

- **NASM** compiler
- **CMake** 3.16 or higher
- **C compiler** if you going to build tests

# Building

To build this library you need this:

```bash
mkdir build && cd build
cmake .. -DSHARED_BUILD=OFF -DBUILD_TESTS=OFF 

# You can set -DSHARED_BUILD to ON if you want dynamic linking library
# You can set -DBUILD_TESTS to ON if you want to build small test for the asm code

cmake --build .
```
