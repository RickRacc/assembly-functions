ARMv8 Assembly Functions Project
This repository contains a completed set of ARMv8 assembly functions written as part of a school project. The goal of this project was to implement and optimize specific low-level operations, showcasing an understanding of ARMv8 architecture and assembly programming.

Project Overview
This project focuses on implementing key functions in ARMv8 assembly, addressing various computational tasks. The implementation emphasizes performance and correctness, adhering to the constraints and requirements provided during the course.

Features
Comprehensive use of ARMv8 registers and operations.
Optimized memory access and instruction flow.
Aligned with coursework deliverables.
File Structure
student_a64_template.s
The main file containing all implemented functions. Each function is properly aligned and structured to meet ARMv8 performance standards.


How to Use
Compilation and Execution
1) Assemble the Code - Use the GNU Assembler (as) to compile the file into an object file:
  as -o project.o student_a64_template.s
2) Link the Object File - Use the GNU Linker (ld) to create an executable:
  ld -o project project.o
   Run the Executable - Execute the compiled binary:
  ./project
   
Testing:
You can write test drivers in C or assembly to invoke the functions. Use a simulator or ARM-compatible hardware for execution.

Tools Used
Assembler: as (GNU Assembler)
Linker: ld (GNU Linker)
Debugger: gdb


Learning Outcomes
Gained proficiency in ARMv8 assembly programming.
Enhanced understanding of low-level computation and optimization.
Developed skills in debugging and testing assembly programs.

This project was completed as part of coursework and is intended for educational purposes. Redistribution or reuse without permission may violate academic policies
