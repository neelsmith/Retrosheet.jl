"""Chadwick baseball project's repository of open data.

$(SIGNATURES)
"""
struct Chadwick
    root

    # Add constructor validating contents...
end

"""Read schedule for a given season from appropriate file in the Chadwick repository.

$(SIGNATURES)
"""
function schedule(season::Int64, chadwick::Chadwick)
    fname = string(chadwick.root,  "/schedule/", season, "SKED.TXT")
    data = readlines(fname)
    nonempty = filter(row -> length(row) > 20, data)
    map(row -> scheduledgame(row), nonempty)
end
