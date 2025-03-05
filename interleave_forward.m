function interleaved = interleave_forward(inputBits)
    N = length(inputBits);

    rng(N, 'twister');
    perm = randperm(N);

    rng('shuffle');

    interleaved = inputBits(perm);
end
