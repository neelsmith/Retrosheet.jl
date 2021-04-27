
const VISITOR = 0
const HOME = 1

const SINGLE_GAME = 0
const FIRST_GAME = 1
const SECOND_GAME = 2

const CHADWICK_RAW = "https://raw.githubusercontent.com/chadwickbureau/retrosheet/master/"

# In addition to standard 9 positions:
const DH = 10

# Used in `sub` records:
const PINCH_HITTER = 11
const PINCH_RUNNER = 12

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
)