
"""Format markdown table with calendar for one month of a given team's schedule.

$(SIGNATURES)
"""
function mdcal(d::Date, teamcode::AbstractString)    
    sched = season(year(d), teamcode) 
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
        
        dt = Date(year(d), month(d), i)
        matches = filter(g -> g.gamedate == dt, sched)        

        if isempty(matches)
            calstr = string(calstr, i , " | ")
        else
            game = matches[1]
            if game.hometeamcode == teamcode
                calstr = string(calstr, "**", i, "**<br/>**",  game.visitingteamcode  , "** | ")
            else
                calstr = string(calstr, "*", i, "*<br/>*@",  game.hometeamcode  , "* | ")
            end
        end

        if mod(dayofweek(dt),7) == 0
            calstr = calstr * "\n| "
        end
    end
    join(lines,"\n") * "\n" * calstr
end



"""Format html table with calendar for one month of a given team's schedule.

$(SIGNATURES)
"""
function htmlcal(d::Date, teamcode::AbstractString) 
    sched = season(year(d), teamcode)    
    lines = [
        "<table><tr><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th><th>Sun </tr>"        
    ]
    

    firstofmonth = firstdayofmonth(d)
    totaldays = lastdayofmonth(d) |> day

    padnum = dayofweek(firstofmonth) - 1
    calstr = "<tr>" * repeat("<td> </td>", padnum)

    for i in 1:totaldays
        dt = Date(year(d), month(d), i)
        matches = filter(g -> g.gamedate == dt, sched)        
        if isempty(matches)
            calstr = string(calstr, "<td>", i , "</td>")
        else
            game = matches[1]
            if game.hometeamcode == teamcode
                calstr = string(calstr, "<td class='home'>", i , "<br/>", game.visitingteamcode, "</td>")
            else
                calstr = string(calstr, "<td class='away'>", i ,"<br/>@", game.hometeamcode, "</td>")
            end 
        end

        if mod(dayofweek(dt),7) == 0
            calstr = calstr * "</tr><tr>"
        end
    end
    join(lines,"\n")  * calstr * "</tr></table>"
end