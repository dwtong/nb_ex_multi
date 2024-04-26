# nb_ex_multi

this is a modified version of [nb_ex](https://github.com/sixolet/nb_ex) that supports multiple distings.

configure the number of devices in `SYSTEM > MODS > NB_EX_MULTI`. after changing the number of devices, restart norns.

you may also need to configure the i2c address on the disting. supported addresses [from here](https://github.com/monome/crow/blob/7027d2971a5491b021d8b309101cf2f75a7b5787/lua/ii/disting.lua#L4) are: 0x41, 0x42, 0x43, 0x44

## original readme

This implementation is pretty simple. I have tested it with the following Disting Ex modes:
* SD Multisample
* Poly Wavetable
* Poly Exciter
* Macro Oscillator

Each of these you will have to configure within the ex's tiny screen yourself, but then you can play notes using nb. It always uses the Disting's internal voice allocator.

I think it would be cool if it worked with these but I haven't found a working setup:
* Filter Bank
* Resonator
