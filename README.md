# Retro Builder

## Purpose

This project aims to create a central hub of tool chains and CICD tooling for the building of homebrew for retro hardware. So that developers can drop their code into a set structure and build without worring about the build process.
Hopefully this will also lower the barrier to new developers by allowing them to to focus on the code and not the setup and configuration.

## Status

|Manufacturer|Platform|Toolchain|CICD|Notes|
|-|-|-|-|-|
|-|68K/Z80 VASM|&check;||only mot68k tested, very basic test|
|Nintendo|Gameboy DMG|&check;|||
||Gameboy Advance||||
||NES/Famicom||||
||SNES/Super Famicom||||
||N64|&check;||Issue with Spicy, changing to ld|
|Sega|Dreamcast||||
||Mega Drive / Genesis|&check;||Untested|
|Sony|Playstation 1 (PSX)||||

## Build

All of the tool chains will be built as docker images as this provides a simple way of ensuring that all processes are kept in a consistant format.

## Test

This is still to be determined as it requires the build process to somehow integrate with an emulator / real hardware and as most homebrew is likely to be games / UI based automated testing will have to be strech goal as opposed to a primary one.

## Release
