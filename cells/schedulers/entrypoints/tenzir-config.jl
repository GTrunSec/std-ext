using Pipelines
using JobSchedulers, Dates

scheduler_start()
sleep(2)

prog = CmdProgram(
    inputs = ["PATH", "SHELL", "INPUT1", "INPUT2"],
    # outputs = "OUTPUT_FILE",
    cmd = pipeline(`SHELL PATH -c INPUT1`,
                   `SHELL PATH -c INPUT2`
                   ),
)

inputs = Dict(
    "SHELL" => `nix develop`,
    "PATH" => ENV["PRJ_ROOT"] * "/devshell",
    "INPUT1" => `std run //tenzir//entrypoints:config-vast-prod`,
    "INPUT2" => `std run //cliche//entrypoints:example add 1 2`,
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
