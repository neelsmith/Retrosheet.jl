"""Chadwick baseball project's repository of open data.

$(SIGNATURES)
"""
struct Chadwick
    root

    # Add constructor validating contents...
end

"""Read schedule for a given season.

$(SIGNATURES)
"""
function schedule(season::Int64, chadwick::Chadwick)
    fname = string(chadwick.root,  "/schedule/", season, "SKED.TXT")

end
