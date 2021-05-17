### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ a0b3813e-adab-11eb-2983-616cf2bb6f5e
begin

       using LinearAlgebra, DifferentialEquations, Plots, PlutoUI
end

# ╔═╡ d84dbb08-b1a4-11eb-2d3b-0711fddd1347
html"""
<div style="
position: absolute;
width: calc(100% - 30px);
border: 50vw solid #282936;
border-top: 500px solid #282936;
border-bottom: none;
box-sizing: content-box;
left: calc(-50vw + 15px);
top: -500px;
height: 300px;
pointer-events: none;
"></div>

<div style="
height: 300px;
width: 100%;
background: #282936;
color: #fff;
padding-top: 68px;
">
<span style="
font-family: Vollkorn, serif;
font-weight: 700;
font-feature-settings: 'lnum', 'pnum';
"> <p style="
font-size: 1.5rem;
opacity: .8;
"><em>Supplementary Materials</em></p>
<p style="text-align: center; font-size: 2rem;">
<em> Forecasting virus outbreakes with Neural ODEs. </em>
</p>


<style>
body {
overflow-x: hidden;
}
</style>"""

# ╔═╡ ef8d6690-720d-4772-a41f-b260d306b5b2
TableOfContents(title="📚 Table of Contents", indent=true, depth=4, aside=true)

# ╔═╡ 30969341-9079-4732-bf55-d6bba2c2c16c
md"""
`sign(x)` returns 0 if x is 0, or ±1 for positive/negative x.
"""

# ╔═╡ 6139554e-c6c9-4252-9d64-042074f68391
begin
	f(y,a) =   sign(y)  + a -  y
	f(y,a,t) = f(y,a) # just for the difeq solver
end

# ╔═╡ 991f14bb-fc4a-4505-a3be-5ced2fb148b6


# ╔═╡ 61960e99-2932-4a8f-9e87-f64a7a043489
md"""
a = $(@bind a Slider(-5:.1:5, show_value=true, default=0) )


"""

# ╔═╡ 6f61180d-6900-48fa-998d-36110e79d2dc
gr()

# ╔═╡ 5027e1f8-8c50-4538-949e-6c95c550016e
md"""
### Flux argument

"""

# ╔═╡ 465f637c-0555-498b-a881-a2f6e5714cbb
md"""
y₀ = $(@bind y₀ Slider(-6:.1:6, show_value=true, default=2.0) )
"""

# ╔═╡ a09a0064-c6ab-4912-bc9f-96ab72b8bbca
sol = solve(  ODEProblem( f, y₀, (0,10.0), a ));

# ╔═╡ fb6e34b0-b4eb-11eb-3687-257bc18c3e52
md"""
### More

"""

# ╔═╡ bc96abb0-b4ea-11eb-21a1-fdd01945f9c6
md"""
### Auxiliary Code

"""

# ╔═╡ f8ee2373-6af0-4d81-98fb-23bde10198ef
function plotit(y₀, a)

	sol = solve(  ODEProblem( f, y₀, (0,10.0), a ));
	p = plot( sol , legend=false, background_color_inside=:black , ylims=(-7,7), lw=3, c=:red)

	# plot direction field:
		xs = Float64[]
		ys = Float64[]

	    lrx = LinRange( xlims(p)..., 30)
		for x in  lrx
			for y in LinRange( ylims(p)..., 30)
				v = [1, f(y, a ,x) ]
				v ./=  (100* (lrx[2]-lrx[1]))


				push!(xs, x - v[1], x + v[1], NaN)
				push!(ys, y - v[2], y + v[2], NaN)

			end
		end

	if a<1 hline!( [-1+a],c=:white,ls=:dash); end
	if a>-1  hline!( [1+a],c=:white,ls=:dash);end
	    hline!( [0 ],c=:pink,ls=:dash)
		plot!(xs, ys, alpha=0.7, c=:yellow)
	    ylabel!("y")
	    annotate!(-.5,y₀,text("y₀",color=:red))
	if a>-1
	   annotate!(5,1+a,text(round(1+a,digits=3),color=:white))
	end
	if a<1
	   annotate!(5,-1+a-.4,text(round(-1+a,digits=3),color=:white))
	end
    title!("Solution to y'=f(y,a)")
return(p)
end

# ╔═╡ a4686bca-90d6-4e02-961c-59f08fc37553
plotit(y₀, a)



#



# ╔═╡ Cell order:
# ╟─d84dbb08-b1a4-11eb-2d3b-0711fddd1347
# ╠═a0b3813e-adab-11eb-2983-616cf2bb6f5e
# ╠═ef8d6690-720d-4772-a41f-b260d306b5b2
# ╟─30969341-9079-4732-bf55-d6bba2c2c16c
# ╠═6139554e-c6c9-4252-9d64-042074f68391
# ╠═991f14bb-fc4a-4505-a3be-5ced2fb148b6
# ╠═61960e99-2932-4a8f-9e87-f64a7a043489
# ╠═6f61180d-6900-48fa-998d-36110e79d2dc
# ╠═a09a0064-c6ab-4912-bc9f-96ab72b8bbca
# ╠═5027e1f8-8c50-4538-949e-6c95c550016e
# ╠═465f637c-0555-498b-a881-a2f6e5714cbb
# ╠═a4686bca-90d6-4e02-961c-59f08fc37553
# ╠═fb6e34b0-b4eb-11eb-3687-257bc18c3e52
# ╠═bc96abb0-b4ea-11eb-21a1-fdd01945f9c6
# ╟─f8ee2373-6af0-4d81-98fb-23bde10198ef
