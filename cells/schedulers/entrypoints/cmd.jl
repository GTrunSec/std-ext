using Pipelines
using JobSchedulers, Dates

scheduler_start()
sleep(2)

prog = CmdProgram(
    inputs = ["INPUT1", "INPUT2", "INPUT3"],
    # outputs = "OUTPUT_FILE",
    cmd = pipeline(`nix develop INPUT1` & `echo INPUT3`, `sort`, "OUTPUT_FILE"),
)

inputs = Dict(
    "INPUT1" => `./devshell -c std run //tenzir//entrypoints:config-vast-prod`,
    "INPUT2" => `Pipeline.jl`,
    "INPUT3" => 39871,
)
#outputs = "OUTPUT_FILE" => "out" # save output to file

program_job = Job(prog, inputs; touch_run_id_file = false)

submit!(program_job)

while JobSchedulers.DataFrames.nrow(queue()) > 0
    sleep(2)
end
# run(`cat out.txt`)
