
"""
	newton(f, x0)

Given a function f(x) that returns its value and its derivative, this routine determines a 
"""
function newton(f, x0; maxiter = 1000, tol = 1.0E-12)

	val, der = f(x0)
	xnow = x0
	niter = 0
	err = val/der
	while abs(err) > tol
		xnext = xnow - err
		val, der = f(xnext)
		err  = val/der
		xnow = xnext

		niter = niter + 1
		if niter > maxiter
			return nothing, niter
		end
	end

	return xnow, niter
end
