# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using Retrosheet

makedocs(
    sitename = "Retrosheet.jl",
    pages = [
        "Home" => "index.md",
        "API documentation" => "apis/index.md"
    ]
)


deploydocs(
    repo = "github.com/neelsmith/PolytonicGreek.jl.git",
) 