
const VISITOR = 0
const HOME = 1

const TOP = 1
const BOTTOM = 2

const SINGLE_GAME = 0
const FIRST_GAME = 1
const SECOND_GAME = 2

const CHADWICK_RAW = "https://raw.githubusercontent.com/chadwickbureau/retrosheet/master/"

const hitlabels = Dict(
    "S" => "single",
    "D" => "double",
    "T" => "triple",
    "HR" => "home run"
)


const positionlabels = Dict(
    "1" => "pitcher",
    "2" => "catcher",
    "3" => "first base",
    "4" => "second base",
    "5" => "third base",
    "6" => "shortstop",
    "7" => "left field",
    "8" => "center field",
    "9" => "right field",
    "10" => "designated hitter",
    "11" => "pinch hitter",
    "12" => "pinch runner",
)

function ordinallabel(n)
    irregs = Dict(
    1 => "first",
    2 => "second",
    3 => "third")
    if n < 4
        irregs[n]
    else
        string(n, "th")
    end
end