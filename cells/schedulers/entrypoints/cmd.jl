using Pipelines

echo = CmdProgram(
    inputs = [
        "REQUIRED",               # no default value; any data type.
        "TYPED" => String,        # no default value; String type only.
        "OPTIONAL" => 4,          # default value is 4; any data type.
        "FULL" => String => "abc", # default value is abc; String type only.
    ],
    cmd = `echo REQUIRED TYPED OPTIONAL FULL`,
)
inputs = Dict("REQUIRED" => "Pipelines.jl", "TYPED" => "is", "FULL" => "everyone!")
run(echo, inputs)

print("asd")
