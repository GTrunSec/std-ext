using Comonicon

@main function mycmd(arg; option = "Sam", flag::Bool = false)
    @show arg
    @show option
    @show flag
end
