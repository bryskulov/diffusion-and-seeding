
# Diffusion and Seeding with Discrete Information Set 

Research proposal for my graduate course on "Networks".

## Abstract
In this project, I model the diffusion process where the node’s information set is not
restricted to be binary, but contains some subset of the initial information diffused. As a
preliminary result from Monte Carlo simulation, I find that although the diffusion process
cannot be characterized as "simple contagion", it is optimal to seed central and far apart
nodes. However, this result could be driven by high clustering property of the chosen
network and further research is required.

More details in the paper in the repo - *Networks_Term_Paper_Ryskulov.pdf*


## Documentation

The simulation process was implemented in R, using
"igraph" external package and custom functions. All the required code is documented
at the top of each .R file.

```Warning```: The implementation of the model in paper is done with the purpose of
prototyping, so the computation complexity is not optimized. Functions do not use
parallelization and mainly rely on for-loops for better intuitive understanding of the
diffusion process.

**Simulation technical requirements:**

Programming language: `R`\
External package: [igraph](https://igraph.org/), [tictoc](https://cran.r-project.org/web/packages/tictoc/index.html)

**The repo includes the following files in sumlation:**

- *main.R* : main script to run the simulation
- *info_measure.R* : function which calculates the statistics used to assess the outcomes of the given seeding strategy
- *mc_simulate.R* : function which runs a Monte Carlo simulation for a diffusion process with discrete information set described in the paper
- *random_seeding.R* : function which randomly draws a pair of nodes to seed and returns an average of their outcomes
- *simulate_and_plot.R* : function which runs a Monte Carlo simulation for a given pair of nodes and plots igraph network, marking the seeded nodes with red color
- *village2.csv*: the dataset used in the simulation
## Author

- [@bryskulov](https://www.github.com/bryskulov)

