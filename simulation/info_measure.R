#' Networks Spring 2022 - Research Proposal
#' Author: Bakbergen Ryskulov

#' info_measure: calculates the measure statistics used to assess the 
#'     outcomes of the given seeding strategy
#'     
#' @param infoset A list of information sets for each node (list)
#' 
#' @return the list of 3 statistics: total number of informed nodes, total
#' information, standard deviation of information sets
#' 
#' @example 
#' info_measure(infoset)

info_measure <- function(infoset) {
   N = length(infoset)
   info_summ = rep(0, N)
   for (i in 1:N) {
      node_info = infoset[[i]]
      if (!is.null(infoset)) {
         info_summ[i] = length(node_info)
      }
   }
   count_not_null = sum(info_summ != 0)
   total_info = sum(info_summ)
   sd = sd(info_summ)
   out = list(count_not_null, total_info, sd)
   return(out)
}