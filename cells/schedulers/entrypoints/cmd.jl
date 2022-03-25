using Pipelines
using JobSchedulers, Dates

scheduler_start()
sleep(2)

prog = CmdProgram(
    inputs = ["SHELL", "INPUT1"],
    # outputs = "OUTPUT_FILE",
    cmd = pipeline(`nix develop SHELL INPUT1`),
)

inputs = Dict(
    "SHELL" => ENV["PRJ_ROOT"] * "/devshell",
    "INPUT1" => `-c std run //tenzir//entrypoints:config-vast-prod`,
)
#outputs = "OUTPUT_FILE" => "out" # save output to file

program_job = Job(prog, inputs; touch_run_id_file = false)

submit!(program_job)

while JobSchedulers.DataFrames.nrow(queue()) > 0
    sleep(2)
    all_queue()
    queue(all = true)
end
# run(`cat out.txt`)
