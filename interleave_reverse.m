function deinterleaved = interleave_reverse(interleavedBits)
    N = length(interleavedBits);

    rng(N, 'twister');
    perm = randperm(N);

    rng('shuffle');

    inv_perm = zeros(1, N);
    inv_perm(perm) = 1:N;

    deinterleaved = interleavedBits(inv_perm);
end
