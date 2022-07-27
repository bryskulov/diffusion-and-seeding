## =============================================================================
## RESEARCH PROPOSAL: Diffusion and Seeding with Discrete Information Set
## NETWORKS, IDEA, WINTER 2022
## Author: Ryskulov Bakbergen
## =============================================================================

#' This is the main script of the Monte Carlo simulation

## =============================================================================
## Setting up

# Clear the workspace and set the working directory
rm(list = ls())
setwd("Your working directory")

# Import libraries
library(foreign)
library(igraph)
library(plyr)

# Import custom functions
source("info_measure.R")
source("mc_simulate.R")
source("random_seeding.R")
source("simulate_and_plot.R")


## =============================================================================
### Run the Monte Carlo Simulation for 1 pair

## Reading the village graph as csv
A <- read.csv('village2.csv', header=F)
A <- as.matrix(A)
G <- graph.adjacency(A, mode="undirected")

## Exploring the network and setting params of the network
plot(G, vertex.size=5, vertex.label.dist=1, vertex.label.cex=.5)
N <- gorder(G)
M <- gsize(G)
C <- transitivity(G, type = "average")

## Set basic parameters of the simulation
rand_seed = 42
T = 1
p = 0.5
k = 0.7
S = 10
to_seed = c(164, 31)

## Test the function
mc_simulate(A, to_seed, T, p, k, rand_seed, S)


## =============================================================================
### Run MC Simulation for different seeding strategies

## 1. Random seeding

random_seeding(100, A, T, p, k, rand_seed, S)


## 2. Central nodes seeding (close and distant)

# Compute eigen-centralities of the nodes and sort them
eigens <- eigen_centrality(G)$vector
eigen_centr_nodes <- match(sort(eigens, decreasing = TRUE), eigens)

#Central but close: 88 + 55, 86 69
simulate_and_plot(A, c(88, 55), T, p, k, rand_seed, S)
simulate_and_plot(A, c(88, 86), T, p, k, rand_seed, S)
simulate_and_plot(A, c(88, 69), T, p, k, rand_seed, S)
#Central but distant: 88 + 123, 141, 169
simulate_and_plot(A, c(88, 123), T, p, k, rand_seed, S)
simulate_and_plot(A, c(88, 141), T, p, k, rand_seed, S)
simulate_and_plot(A, c(88, 169), T, p, k, rand_seed, S)

