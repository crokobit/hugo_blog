type date = { day:int, month:int, year: int }
fun records_as_parameter (date_1:date) =
  #year date_1

fun is_order (date_1:date, date_2:date) =
  let
    val year_1 = #year date_1
    val month_1 = #month date_1
    val day_1 = #day date_1

    val year_2 = #year date_2
    val month_2 = #month date_2
    val day_2 = #day date_2
  in
    year_2 > year_1 andalso month_2 > month_1 andalso day_2 > day_1
  end

fun number_in_month (dates:date list, month:int) =
    let
      val {day:int, month:int, year:int} = hd dates
    in
      if null(tl dates)
      then
        if month = 2 andalso year mod 4 = 0
        then
          [29]
        else
          case day of
            1 => [31]
          | 2 => [28]
          | 3 => [31]
          | 4 => [30]
          | 5 => [31]
          | 6 => [30]
          | 7 => [31]
          | 8 => [31]
          | 9 => [30]
          | 10 => [31]
          | 11 => [30]
          | 12 => [31]
      else
        valOf(number_in_month([hd dates], month)) :: number_in_month(tl dates, month)
    end
