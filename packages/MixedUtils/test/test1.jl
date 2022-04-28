#
# Test of newton routine
#

using Test, MixedUtils

@testset "Testing Newton routine" begin
    root, niter = newton(x -> (x^2 - 3, 2*x), 8.45)
    @test isapprox(root^2, 3.0)
end
