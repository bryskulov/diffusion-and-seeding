#' Networks Spring 2022 - Research Proposal
#' Author: Bakbergen Ryskulov

#' simulate_and_plot: Runs a Monte Carlo simulation for a given pair of nodes
#'     and plots igraph network marking seed nodes with red color
#' 
#' @param A An adjacency matrix of the network (matrix)
#' @param nodes_to_seed Initial nodes to seed the information for diffusion (vector)
#' @param T Total periods to run the diffusion (integer
#' @param p Probability of information transmission between two nodes (number b-w 0-1)
#' @param k Fraction of information transmitted to another node (number b-w 0-10)
#' @param rand_seed Seeding number for reproducibility of simulation (integer)
#' @param n_sim Number of iterations in Monte Carlo simulation (integer)
#' 
#' @return Nothing. Print the standard 4 measure statistics and plot the igraph network
#' 
#' @example 
#' simulate_and_plot(A=A, nodes_to_seed=c(88, 55), T=55, p=0.5, k=0.7, rand_seed=42, n_sim=500)

simulate_and_plot <- function(A, nodes_to_seed, T, p, k, rand_seed, n_sim) {
   result <- mc_simulate(A, to_seed, T, p, k, rand_seed, n_sim)
   print(result)
   color = c(rep("orange", N))
   color[nodes_to_seed] = "red"
   V(G)$color <- color
   plot(G, vertex.size=5, vertex.label.dist=1, vertex.label.cex=.5)
}