fun count_up_from_1(to:int) =
  let 
    fun count_range(from:int) =
      if to = from
      then [to]
      else
        from::count_range(from+1)
  in
    count_range(1)
  end
