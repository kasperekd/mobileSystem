function symbols = qpsk_modulator(bits)

    if mod(length(bits), 2) ~= 0
        bits = [bits, 0];
    end

    const = [
             complex(1, 1) / sqrt(2); % 00
             complex(1, -1) / sqrt(2); % 01
             complex(-1, 1) / sqrt(2); % 10
             complex(-1, -1) / sqrt(2) % 11
             ];

    symbols = complex(zeros(1, length(bits) / 2));

    for i = 1:2:length(bits)
        pair = [bits(i), bits(i + 1)];
        idx = pair(1) * 2 + pair(2) + 1; % 00 -> 1, 11 -> 4
        symbols((i + 1) / 2) = const(idx);
    end

end
