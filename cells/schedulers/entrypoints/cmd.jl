using Pipelines
using JobSchedulers, Dates

scheduler_start()
sleep(2)

prog = CmdProgram(
    inputs = ["INPUT1", "INPUT3"],
    # outputs = "OUTPUT_FILE",
    cmd = pipeline(`nix develop INPUT1 INPUT2`),
)

inputs = Dict(
    "INPUT1" => ENV["PRJ_ROOT"] * "/devshell",
    "INPUT2" => `-c std run //tenzir//entrypoints:config-vast-prod`,
)
#outputs = "OUTPUT_FILE" => "out" # save output to file

program_job = Job(prog, inputs; touch_run_id_file = false)

submit!(program_job)

while JobSchedulers.DataFrames.nrow(queue()) > 0
    sleep(2)
end
# run(`cat out.txt`)
