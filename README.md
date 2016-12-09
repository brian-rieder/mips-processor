# cycloneIV-mips-processor
Processor designed to operate on the Altera Cyclone IV FPGA as part of ECE437: Introduction to Digital Computer Design.

This processor was designed iteratively in multiple stages all stored on individual branches with tags: a single cycle iteration, a pipelined iteration, pipelined with instruction and data caches, and finally a dual-core pipelined processor with caches.

Each of these branches align with the steps in the course:
* **master** - Contains the most up to date version of the processor. Currently contains the multicore iteration.
* **singlecycle** - Contains the entirety of the single cycle design.
* **pipeline** - Contains the entirety of the pipelined design with forwarding implemented.
  * *Note:* the "forwarding" branch contains the development efforts for this implementation. It is identical to the pipelined design.
* **caches** - The implementation of a direct-mapped instruction cache and a two-way set-associative data cache on top of the pipelined design.
* **multicore** - Contains the dual-core implementation of the design with cache coherence for parallelism.

In order to use this design, there are three possible methods of execution:
1) Source simulation
2) Mapped simulation
3) Hardware

# Single-cycle Processor
![Singlecycle Diagram](documents/SingleCycleProcessor.jpg?raw=true "Singlecycle Diagram")
# Pipelined Processor
![Pipeline Diagram](documents/PipelineProcessor.jpg?raw=true "Pipeline Diagram")
