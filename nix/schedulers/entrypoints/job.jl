using JobSchedulers
using Base.Threads

scheduler_start()
sleep(2)
scheduler_status()


job = Job(@task(begin
    sleep(2)
    println("highpriority")
end), name = "high_priority", priority = 0)
display(job)
submit!(job)
