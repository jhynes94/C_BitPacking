# Clean Register Access with C Bitfields + Union  
(aka "Structured Bitfields", "Named Register Bits")

## Introduction
In high performance applications such as embedded systems, drivers, game engines, protocol parsers, bit masking becomes a solution to put more information in less space. It's also becomes necessary for modifying hardware mapped registers. 

Doing this is often dirty and error prone. We've all been there using OR's with bit shifts, it's dumb. It ends up like this:

```c
reg |= (1u << 4);                   // turn on party mode
reg &= ~(1u << 3);                  // turn off high brightness
if (reg & (1u << 7)) { ... }        // check factory test mode
```

It's error-prone, hard to read, easy to mess up bit positions during refactors, and terrible for code review.
There's a much cleaner, self-documenting way that has been in the C language since forever:

```c
union {
    uint8_t raw;
    struct {
        uint8_t idle              : 1;  // [0]
        uint8_t low_brightness    : 1;  // [1]
        uint8_t normal_brightness : 1;  // [2]
        uint8_t high_brightness   : 1;  // [3]
        uint8_t party_mode        : 1;  // [4]
        uint8_t debug_mode        : 1;  // [5]
        uint8_t reserved          : 1;  // [6]
        uint8_t factory_test      : 1;  // [7] MSB
    } bits;
} status_reg;

status_reg.bits.party_mode = 1;      // readable!
status_reg.bits.high_brightness = 0;
```

### Try it out

Take a look at bitPacking.c, compile it with the following command and play around with it. It works awesome and is a better methond then old school Bit Masking. 

```bash
gcc bitPacking.c -o runMe
./runMe
```

# Backstory
A senior engineer on my team showed me this trick. I was super impressed and thought all of you should know about it too. 

It's made our code base super clean and stable.
