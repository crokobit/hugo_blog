fun join_list (list_1:int list, list_2:int list) =
  case of list_1
    [] => list_2
  | [x] => x::list_2
  | _ => hd(list_1)::join_list((tl list_1, list_2))
  if null(tl list_1)
  then
    (hd list_1)::list_2 
  else
    (hd list_1)::join_list((tl list_1), list_2)

join_list([1,2,3,4],[5,6])
