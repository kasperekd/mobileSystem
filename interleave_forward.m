function interleaved = interleave_forward(inputBits)
    global perm;

    if isempty(perm)
        N = length(inputBits);
        perm = randperm(N);
    end

    interleaved = inputBits(perm);
end
