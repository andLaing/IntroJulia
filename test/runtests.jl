using IntroJulia

using Test

@testset "Getting Started" begin
    orig_std = stdout
    readpipe, writepipe = redirect_stdout()
    IntroJulia.greet()
    redirect_stdout(orig_std)
    close(writepipe)
    greeting = read(readpipe, String)

    @test length(greeting) == 54
end


@testset "simple_math" begin
    test_input = 22
    @test times_two(test_input) == 44
end