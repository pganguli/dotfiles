using Pkg

if Base.JLOptions().project == C_NULL && isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end
