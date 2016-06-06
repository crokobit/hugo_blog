fun sum_all_pairs (xs : (int * int) list) =
  if null xs
  then 0
  else #1 (hd xs) + #2 (hd xs) + sum_all_pairs (tl xs)

fun count_from_1 (xs : int) =
  let 
    fun count_list(from : int, to : int) =
      if from = to
      then []
      else from :: count_list(from+1, to)
  in
    count_list(1, xs)
  end


fun count_from_2 (to : int) =
  let 
    fun count_list(from : int) =
      if from = to
      then []
      else from :: count_list(from+1)
  in
    count_list(1)
  end
