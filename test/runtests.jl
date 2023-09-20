using Test, HTTP

# Without including module file
using OxygenExample

OxygenExample.start_server(;port = 8080)

@testset "Without including module file" begin
    @test HTTP.post("http://127.0.0.1:8080/my_name_is/MyNameIs") |> x -> x.status == 200
    @test HTTP.get("http://127.0.0.1:8080/name") |> x -> x.status == 200
end

# After including module file (even without using .OxygenExample and restart server)
include("../src/OxygenExample.jl")

@testset "After including module file" begin
    @test HTTP.post("http://127.0.0.1:8080/my_name_is/MyNameIs") |> x -> x.status == 200
    @test HTTP.get("http://127.0.0.1:8080/name") |> x -> x.status == 200
end
