fun max_of_list(xs : int list) =
  if null xs
  then 0
  else
    let
      val max_of_tl = max_of_list(tl xs)
    in
      if max_of_tl > hd(xs)
      then max_of_tl
      else hd(xs)
    end

fun max_of_list_2(xs : int list) =
  if null xs
  then NONE
  else
    let
      val tl_max = max_of_list_2(tl xs)
    in
      if isSome(tl_max) andalso valOf(tl_max) > hd(xs)
      then tl_max
      else SOME(hd(xs))
    end

fun max_of_list_3(xs : int list) =
  if null xs
  then NONE
  else
    let
      fun max_of_list_without_check_none(xs : int list) =
        if null(tl xs)
        then hd xs
        else
          let 
            val tl_max = max_of_list_without_check_none(tl xs)
          in
            if tl_max > hd(xs)
            then tl_max
            else hd(xs)
          end

    in
      SOME(max_of_list_without_check_none xs)
    end

val test = max_of_list_3([4,3,6,8,3,66,3,7,8])
