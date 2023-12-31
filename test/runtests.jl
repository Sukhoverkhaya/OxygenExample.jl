using Test, HTTP

# Without including module file
using OxygenExample

OxygenExample.start_server()

@testset "Without including module file" begin
    @test HTTP.post("http://127.0.0.1:8080/my_name_is/MyNameIs") |> x -> x.status == 200 broken = true
    @test HTTP.get("http://127.0.0.1:8080/name") |> x -> x.status == 200 broken = true
end

# After including module file (even without using .OxygenExample and restart server)
include("../src/OxygenExample.jl")

@testset "After including module file" begin
    @test HTTP.post("http://127.0.0.1:8080/my_name_is/MyNameIs") |> x -> x.status == 200
    @test HTTP.get("http://127.0.0.1:8080/name") |> x -> x.status == 200
end
