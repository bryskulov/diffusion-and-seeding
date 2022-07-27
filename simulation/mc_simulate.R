#' Networks Spring 2022 - Research Proposal
#' Author: Bakbergen Ryskulov

#' mc_simulate: runs a Monte Carlo simulation for a diffusion process with discrete
#' information set
#' 
#' @param A An adjacency matrix of the network (matrix)
#' @param nodes_to_seed Initial nodes to seed the information for diffusion (vector)
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
#' mc_simulate(A=A, nodes_to_seed=c(1, 2), T=5, p=0.4, k=7, rand_seed42, n_sim=500)

mc_simulate <- function(A, nodes_to_seed, T, p, k, rand_seed, n_sim) {
   # Extract params
   N = dim(A)[1]
   # Generate seeds for MC simulation
   set.seed(rand_seed)
   mc_seeds <- sample(1:10^5, n_sim)
   
   # Perform MC simulation and store the results
   sum_count_not_null = 0
   sum_total_info = 0
   sum_sd = 0
   sum_new_info = 0
   
   for (seed in mc_seeds) {
      # Generate matrices to store info
      A_active = A
      set.seed(seed)
      A_random = matrix(runif(N*N),nrow=N)
      A_random = A_random * A_active
      
      # Generate a list of information that each node knows
      infoset = vector(mode="list", length=N)
      # Seed the information set
      for (node in nodes_to_seed) {
         infoset[[node]] = c(1:10)
      }
      
      # Run the simulation for T periods
      count_new_info = list()
      for (t in 1:T) {
         temp_infoset = infoset
         count_new_info_t = 0
         for (i in 1:N) {
            # Get information set of node
            node_info = infoset[[i]]
            if (!is.null(node_info)) {
               # Get the nodes to which to pass info
               node_to_pass = as.numeric(A_random[i,] > p)
               idxs_to_pass = which(node_to_pass %in% 1)
               # Assign random k elements of into to infected nodes
               for (idx_pass in idxs_to_pass) {
                  prev_info_length = length(temp_infoset[[idx_pass]])
                  if (prev_info_length != 0) infected = 1 else infected = 0
                  # Transmit the information
#                  set.seed(seed)
                  #info_to_pass = sample(node_info, ceiling(length(node_info)*k))
                  info_to_pass = sample(node_info, 10 - t)
                  temp_infoset[[idx_pass]] = unique(c(temp_infoset[[idx_pass]], info_to_pass))
                  # Track new info
                  delta = length(temp_infoset[[idx_pass]]) - prev_info_length
                  if (infected) count_new_info_t = count_new_info_t + delta
                  # Information can be passed only once
                  A_random[i,idxs_to_pass] = 0
               }
            }
         }
         infoset = temp_infoset
         count_new_info[t] = count_new_info_t
      }
      gen_measures = info_measure(infoset)
      
      # Store the results in the outer list
      sum_count_not_null = sum_count_not_null + gen_measures[[1]]
      sum_total_info = sum_total_info + gen_measures[[2]]
      sum_sd = sum_sd + gen_measures[[3]]
      sum_new_info = sum_new_info + Reduce(`+`, count_new_info)
   }
   
   # Average over all MC results
   result = c(sum_count_not_null/n_sim, sum_total_info/n_sim, sum_sd/n_sim,
              sum_new_info/n_sim)
   return(result)
}



