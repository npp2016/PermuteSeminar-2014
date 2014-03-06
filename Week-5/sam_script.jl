# Just for fun, translated my R script into Julia to see how much faster I could
# get it.  The only significant change in implementation is in hwi(), which uses
# a loop instead of indexing with vectors to count up the presences.  This saves
# memory and goes a lot faster.  On my laptop, generating 1000 random matrices
# with this script takes ~ 0.25 seconds, compared with 18-19 seconds in R.

function hwi(a, b, m)
	ya, yb, x = 0, 0, 0
	for i in 1:size(m, 1)
		ya += m[i, a]
		yb += m[i, b]
		x += m[i, a] & m[i, b]
	end
	return x / (x + 0.5 * (ya + yb))
end

function swap!(m)
	# operates in place
	while true
		i = rand(1:size(m, 1), 2)
		j = rand(1:size(m, 2), 2)
		if m[i, j] in ([1 0; 0 1], [0 1; 1 0])
			m[i, j] = flipud(m[i, j])
			break
		end
	end
end

function association_matrix(m)
	D = size(m, 2)
	result = zeros(D, D)
	for j in 1:D, i in j:D # j first for performance
		result[i, j] = hwi(i, j, m)
	end
	return result
end

function S{T}(assoc_mat, e_mat)
	sum((assoc_mat - e_mat).^2) / size(assoc_mat, 2)
end

function randomized_S(m, n_swaps)
	D = size(m, 2)
	e_matrix = zeros(D, D)
	S_trace = zeros(n_swaps)
	o_matrix = zeros(D, D)
	for i in 1:n_swaps
		o_matrix = association_matrix(m)
		S_trace[i] = S(o_matrix, e_matrix)
		swap!(m)
	end
	return S_trace
end

## Script ########################

dolphins, = readcsv("Dolphin data.csv", has_header=true)
dolphins = int(dolphins[:, 2:end])

m = copy(dolphins)
n_swaps = 1000

randomized_S(m, 2) # run once to make randomized_S compile
m = copy(dolphins) # redo
@time S_trace = randomized_S(m, n_swaps)