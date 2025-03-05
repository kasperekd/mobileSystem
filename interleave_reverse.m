function deinterleaved = interleave_reverse(interleavedBits)
    global perm;

    if isempty(perm)
        error('Перестановка не инициализирована. Сначала вызовите interleave_forward.');
    end

    N = length(interleavedBits);
    inv_perm = zeros(1, N);
    inv_perm(perm) = 1:N;
    deinterleaved = interleavedBits(inv_perm);

    perm = [];
end
