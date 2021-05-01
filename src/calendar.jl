
"""Format markdown table with calendar for month of given date.

$(SIGNATURES)
"""
function mdcal(d::Date)    
    lines = [
        "| Mon | Tue | Wed | Thu | Fri | Sat | Sun |",
        "| --- | --- | --- | --- | --- | --- | --- |"
    ]
    

    firstofmonth = firstdayofmonth(d)
    totaldays = lastdayofmonth(d) |> day

    padnum = dayofweek(firstofmonth) - 1
    calstr = "| " * repeat(" |", padnum)

    for i in 1:totaldays
        #println("Add ", i)
        calstr = string(calstr, i , " | ")
        dt = Date(year(d), month(d), i)

        if mod(dayofweek(dt),7) == 0
            calstr = calstr * "\n| "
        end
    end
    join(lines,"\n") * "\n" * calstr
end




function htmlcal(d::Date)    
    lines = [
        "<tr><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th><th>Sun </tr>"        
    ]
    

    firstofmonth = firstdayofmonth(d)
    totaldays = lastdayofmonth(d) |> day

    padnum = dayofweek(firstofmonth) - 1
    calstr = "<tr>" * repeat(" </tr><tr>", padnum)

    for i in 1:totaldays
        #println("Add ", i)
        calstr = string(calstr, i , "</td><td>")
        dt = Date(year(d), month(d), i)

        if mod(dayofweek(dt),7) == 0
            calstr = calstr * "</tr><tr>"
        end
    end
    join(lines,"\n") * "\n" * calstr * "</tr>"
end