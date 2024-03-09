---
title: Ghidra notes
author: Zhibeau
date: 2024-01-18 09:51:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/24_01_18/
categories: [Notes,Tools]
tags: [Reverse Engineering, Ghidra]
---

## Pros and cons of SRE Tools

IDA, Radare2, 

## Structure in Assembly

## Add structure in Ghidra
Manually use data type manager
Import C header

1. High-level programming language
2. (Compile  =>) Assembly language
3. (Assemble =>) Machine code
4. (Link     =>) Executable (.ELF, .EXE)

![Process of the compiler](1.png)
![Process of the Link](2.png)

### Reverse Engineering:
 Reverse the process 1. => 4. to deconstruct the file

### Obsfucation
Deliberately making the source code or machine code of a program difficult to understand to protect the code from unauthorized analysis, reverse engineering, or modification.

## Prequisite Computer Architechture Knowledge

### Machine Cycle
![Machine Cycle](3.png)

### In this course
Deconstruct C programs into:
1. Registers
2. Instructions
3. Stack memory
4. Heap memory
**Instruction set focused**: Intel's x86-64

**Registers**: Small storage areas used by the processor.
**Instructions**: Define the operations being performed by the CPU(focus on the Intel's x86-64 in this course).
**Addressing mode**: Immediate(add rax,14; stores 14 into RAX) Reg2Reg(xor rax,rax; clears the value in RAX) Pointer(add rax, [rbx]; adds the value *pointed* to by RBX into RAX.)
**Stack**: Data structure containing elements in contiguous memory (grows from high to low)

## Ghidra: Navigation
Some of the default CodeBrowser windows include:
- **Program Tree**: this shows the segments of the ELF file
- **Symbol Tree**: lists and displays all currently defined symbols
- **Data Type Manager**: shows data types inferred during auto-analysis
- **Listing**: the resulting assembly code from auto analysis
- **Console**: tool output/debugging information
- **Decompiler**: C code created from the analyzed Ghidra's P-code (an intermediate language)