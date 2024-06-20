#' intersect_all
#' 
#' Allows to calculate the intersection between n vectors
#'
#' @param ... is all the vector you want to calculate the intersection from 
#' @examples
#'
#' print(intersect_all(c(1:5), c(1, 2, 3, 6), c(1:4)))
#' 
#' [1] 1 2 3
#'
#' @export

intersect_all <- function(...){
        rtn_v <- unlist(list(...)[1])

        if (length(rtn_v) > 1){
                for (el in list(...)[2:length(list(...))]){
                       rtn_v <- intersect(rtn_v, el) 
                }
        }

  return(rtn_v)
}

#' union_all
#'
#'  Allow to perform a union function to n vectors.
#'
#' @param ... are all the input vectors 
#' @examples
#'
#' print(union_all(c(1, 2), c(3, 4), c(1:8)))
#' 
#' [1] 1 2 3 4 5 6 7 8
#'
#' print(union_all(c(1, 2), c(3, 4), c(7:8)))
#'
#' [1] 1 2 3 4 7 8
#' 
#' @export

union_all <- function(...){
  cur_lst <- list(...)
  rtn_v <- c(unlist(cur_lst[1]))
  if (length(cur_lst) > 1){
    cur_lst <- cur_lst[2:length(cur_lst)]
    for (lst in cur_lst){
      rtn_v <- union(rtn_v, lst) 
    }
  return(rtn_v)
  }else{
    return(NULL)
  }
}

#' see_diff_all
#'
#' Allow to perform the opposite of intersect function to n vectors.
#'
#' @param ... are all the input vectors 
#' @examples
#'
#' vec1 <- c(3:6)
#' vec2 <- c(1:8)
#' vec3 <- c(12:16)
#' 
#' print(see_diff_all(vec1, vec2))
#' 
#' [1] 1 2 7 8
#'
#' print(see_diff_all(vec1, vec2, vec3))
#'
#' [1]  3  4  5  6  1  2  7  8 12 13 14 15 16
#' 
#' @export

see_diff_all <- function(...){
  cur_lst <- list(...)
  if (length(cur_lst) > 1){
    intersect_v <- intersect(unlist(cur_lst[1]), unlist(cur_lst[2]))
    union_v <- union(unlist(cur_lst[1]), unlist(cur_lst[2]))
    if (length(cur_lst) > 2){
      cur_lst <- cur_lst[3:length(cur_lst)]
      for (lst in cur_lst){
        intersect_v <- intersect(intersect_v, lst)    
        union_v <- union(union_v, lst)
      }
    }
    return(setdiff(union_v, intersect_v))
  }else{
    return(NULL)
  }
}

#' union_keep
#'
#' Performs a union operation keeping the number of elements of all input vectors, see examples
#'
#' @param ... are all the input vectors
#' @examples
#'
#' print(union_keep(c("a", "ee", "ee"), c("p", "p", "a", "i"), c("a", "a", "z")))
#'
#' [1] "a"  "ee" "ee" "p"  "p"  "i"  "z" 
#'
#' print(union_keep(c("a", "ee", "ee"), c("p", "p", "a", "i")))
#'
#' [1] "a"  "ee" "ee" "p"  "p"  "i" 
#'
#' @export

union_keep <- function(...){
  lst <- list(...)
  rtn_v <- unlist(lst[1])
  if (length(lst) > 1){ 
    see_diff <- function(vec1 = c(), vec2 = c()){
      return(setdiff(union(vec1, vec2), intersect(vec1, vec2)))
    } 
    grep_all <- function(inpt_v, pattern_v){
      rtn_v <- c(grep(pattern = pattern_v[1], x = inpt_v))
      if (length(pattern_v) > 1){
        pattern_v <- pattern_v[2:length(pattern_v)]
        for (ptrn in pattern_v){
          rtn_v <- c(rtn_v, grep(pattern = ptrn, x = inpt_v))
        }
      }
      return(rtn_v)
    }
    lst <- lst[2:length(lst)]
    for (vec in lst){
      diff_vec <- paste0("^", see_diff(rtn_v, vec), "$")
      if (!(is.null(diff_vec))){
        rtn_v <- c(rtn_v, vec[grep_all(inpt_v = vec, pattern_v = diff_vec)])
      }
    }
    return(rtn_v)
  }else{
    return(rtn_v)
  }
}

#' see_diff
#'
#' Output the opposite of intersect(a, b). Already seen at: https://stackoverflow.com/questions/19797954/function-to-find-symmetric-difference-opposite-of-intersection-in-r  
#'
#' @param vec1 is the first vector
#' @param vec2 is the second vector
#' @examples
#'
#' print(see_diff(c(1:7), c(4:12)))
#'
#' [1] 1 2 3 8 9 10 11 12
#'
#' @export

see_diff <- function(vec1 = c(), vec2 = c()){
  return(setdiff(union(vec1, vec2), intersect(vec1, vec2)))
}
