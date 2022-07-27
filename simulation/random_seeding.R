#' Networks Spring 2022 - Research Proposal
#' Author: Bakbergen Ryskulov

#' random_seeding: Randomly draws a pair of nodes to seed and returns an average
#'    of outcomes as a result of Monte Carlo simulation
#' 
#' @param n_draws Number of random draws of pair of nodes (integer)
#' @param A An adjacency matrix of the network (matrix)
#' @param T Total periods to run the diffusion (integer
#' @param p Probability of information transmission between two nodes (number b-w 0-1)
#' @param k Fraction of information transmitted to another node (number b-w 0-10)
#' @param rand_seed Seeding number for reproducibility of simulation (integer)
#' @param n_sim Number of iterations in Monte Carlo simulation (integer)
#' 
#' @return the list of 4 statistics: total number of informed nodes, total
#' information, standard deviation of information sets, total amount of new information
#' 
#' @example 
#' random_seeding(n_draws=100, A=A, T=5, p=0.5, k=0.7, rand_seed=42, S=500)


random_seeding <- function(n_draws, A, T, p, k, rand_seed, n_sim) {
   # Extract params
   N = dim(A)[1]
   
   # Set empty variables to store results
   sum_count_not_null = 0
   sum_total_info = 0
   sum_sd = 0
   sum_new_info = 0
   
   for (iter in 1:n_draws) {
      if (iter %% 20 == 0) {
         print(paste("Completed iterations: ",iter))
      }
      pair <- sample(1:N, 2)
      # Simulate for the given pair of nodes
      output <- mc_simulate(A, pair, T, p, k, rand_seed, n_sim)
      
      # Store the results in the outer list
      sum_count_not_null = sum_count_not_null + output [[1]]
      sum_total_info = sum_total_info + output [[2]]
      sum_sd = sum_sd + output[[3]]
      sum_new_info = sum_new_info + output [[4]]
   }
   # Average over random drawings
   result = c(sum_count_not_null/n_draws, sum_total_info/n_draws, sum_sd/n_draws,
              sum_new_info/n_draws)
   return(result)
}